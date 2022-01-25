//
//  MyVideoCoverView.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/16.
//

#import "MyVideoCoverView.h"
#import <SDWebImage.h>
#import "MyVideoPlayer.h"
#import "MyVideoToolbar.h"
#import "MyVideoListItem.h"

@interface MyVideoCoverView()

@property (nonatomic, strong, readwrite) UIImageView *coverView;
@property (nonatomic, strong, readwrite) UIImageView *playButton;
@property (nonatomic, copy, readwrite) NSString *videoUrl;
@property (nonatomic, copy, readwrite) NSString *videoCoverUrl;

@property (nonatomic, strong, readwrite) MyVideoToolbar *videoToolbar;

@property (nonatomic, strong, readwrite) MyVideoListItem *videoListItem;

@property (nonatomic, readwrite) CGSize cellSize;

@end

@implementation MyVideoCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, (frame.size.width) * 9 / 16)];
            _coverView;
        })];

        [_coverView addSubview:({
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 50) / 2, (frame.size.width - 50) * 9 / 16 / 2, 50, 50)];
            _playButton.image = [UIImage imageNamed:@"toPlay.png"];
            _playButton;
        })];
        
        [self addSubview:({
            _videoToolbar = [[MyVideoToolbar alloc] initWithFrame:CGRectMake(0, _coverView.frame.size.height, frame.size.width, 0)];
            _videoToolbar;
        })];
        
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        
        //点击全部Item都支持播放
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)dealloc {
}

#pragma mark - public method

//- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl {
//    [_coverView sd_setImageWithURL:[NSURL URLWithString:videoCoverUrl]];
//    _videoUrl = videoUrl;
//    [_videoToolbar layoutWithModel:@""];
//
//    // 重新布局cell的高度
////    self.frame = CGRectMake(0, 0, self.frame.size.width, _videoToolbar.frame.size.height + _videoToolbar.frame.origin.y);
//
//}

- (void)layoutWithVideoItem:(MyVideoListItem *)videoListItem {
    self.videoListItem = videoListItem;
    [self.coverView sd_setImageWithURL:[NSURL URLWithString:self.videoListItem.videoCover]];
    self.videoUrl = self.videoListItem.videoPlayUrl;
    [self.videoToolbar layoutWithModel:self.videoListItem];
}

#pragma mark - private method

- (void)_tapToPlay {
    [[MyVideoPlayer sharedPlayer] playVideoWithvideoUrl:_videoUrl attachView:_coverView];
}

@end
