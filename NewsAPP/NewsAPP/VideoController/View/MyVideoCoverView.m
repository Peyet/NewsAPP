//
//  MyVideoCoverView.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/16.
//

#import "MyVideoCoverView.h"
#import <SDWebImage.h>
#import "MyVideoPlayer.h"

@interface MyVideoCoverView()

@property (nonatomic, strong, readwrite) UIImageView *coverView;
@property (nonatomic, strong, readwrite) UIImageView *playButton;
@property (nonatomic, copy, readwrite) NSString *videoUrl;
@property (nonatomic, copy, readwrite) NSString *videoCoverUrl;

@end

@implementation MyVideoCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            _coverView;
        })];

        [_coverView addSubview:({
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 50) / 2, (frame.size.height - 50) / 2, 50, 50)];
            _playButton.image = [UIImage imageNamed:@"videoPlay"];
            _playButton;
        })];
        
        //点击全部Item都支持播放
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)dealloc {
}

#pragma mark - public method

- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl {
    [_coverView sd_setImageWithURL:[NSURL URLWithString:videoCoverUrl]];
    _videoUrl = videoUrl;
}

#pragma mark - private method

- (void)_tapToPlay {
    [[MyVideoPlayer sharedPlayer] playVideoWithvideoUrl:_videoUrl attachView:_coverView];
}

@end
