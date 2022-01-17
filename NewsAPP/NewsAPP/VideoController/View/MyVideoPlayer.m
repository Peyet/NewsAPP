//
//  MyVideoPlayer.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/17.
//

#import "MyVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface MyVideoPlayer()
@property (nonatomic, strong, readwrite) AVPlayerItem *videoItem;
@property (nonatomic, strong, readwrite) AVPlayer *avPlayer;
@property (nonatomic, strong, readwrite) AVPlayerLayer *playerLayer;

@end

@implementation MyVideoPlayer

+ (MyVideoPlayer *)sharedPlayer{
    static MyVideoPlayer *player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[MyVideoPlayer alloc] init];
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
    [_videoItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_videoItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
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
    [_videoItem removeObserver:self forKeyPath:@"status"];
    [_videoItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    
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
    if ([keyPath isEqualToString:@"status"]) {
        if (((NSNumber *)[change objectForKey:NSKeyValueChangeNewKey]).integerValue == AVPlayerItemStatusReadyToPlay) {
            [_avPlayer play];
        } else{
            // 资源加载失败
            
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        // 缓冲进度监听
        NSLog(@"缓冲：%@", [change objectForKey:NSKeyValueChangeNewKey]);
    }
}

@end
