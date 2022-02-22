//
//  ZPJVideoPlayer.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/17.
//

#import "ZPJVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface ZPJVideoPlayer()
@property (nonatomic, strong) AVPlayerItem *videoItem;
@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@implementation ZPJVideoPlayer
#pragma mark - 监听Key
static NSString *const kVideoObserverStatus = @"status";                    // 视频状态
static NSString *const kVideoObserverTimeRanges = @"loadedTimeRanges";      // 视频长度

+ (ZPJVideoPlayer *)sharedPlayer{
    static ZPJVideoPlayer *player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[ZPJVideoPlayer alloc] init];
    });
    return player;
}

#pragma mark - private method

- (void)playVideoWithvideoUrl:(NSString *)videoUrl attachView:(UIView *)attachView {
    // 停止上次播放
    [self _stopPlay];
    
    AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:videoUrl]];
    _videoItem = [AVPlayerItem playerItemWithAsset:asset];
    
    // 监听视频资源状态、缓冲进度
    [_videoItem addObserver:self forKeyPath:kVideoObserverStatus options:NSKeyValueObservingOptionNew context:nil];
    [_videoItem addObserver:self forKeyPath:kVideoObserverTimeRanges options:NSKeyValueObservingOptionNew context:nil];
    
    CMTime duration = _videoItem.duration;
    CGFloat videoDuration = CMTimeGetSeconds(duration);
    
    // 创建播放器
    _avPlayer = [AVPlayer playerWithPlayerItem:_videoItem];
    [_avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        NSLog(@"播放进度：%@", @(CMTimeGetSeconds(time)));
    }];
    
    // 展示播放画面
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    _playerLayer.frame = attachView.bounds;
    [attachView.layer addSublayer:_playerLayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handlePlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];

}

#pragma mark - private method

- (void)_stopPlay {
    // 移除监听对象
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_videoItem removeObserver:self forKeyPath:kVideoObserverStatus];
    [_videoItem removeObserver:self forKeyPath:kVideoObserverTimeRanges];
    
    // 销毁播放器
    [_playerLayer removeFromSuperlayer];
    _videoItem = nil;
    _avPlayer = nil;
}

- (void)_handlePlayEnd {
    // 循环播放
    [_avPlayer seekToTime:CMTimeMake(0, 1)];
    [_avPlayer play];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kVideoObserverStatus]) {
        if (((NSNumber *)[change objectForKey:NSKeyValueChangeNewKey]).integerValue == AVPlayerItemStatusReadyToPlay) {
            [_avPlayer play];
        } else{
            // 资源加载失败
            
        }
    } else if ([keyPath isEqualToString:kVideoObserverTimeRanges]) {
        // 缓冲进度监听
        NSLog(@"缓冲：%@", [change objectForKey:NSKeyValueChangeNewKey]);
    }
}

@end
