//
//  ZPJVideoCell.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/16.
//

#import "ZPJVideoCell.h"
#import <SDWebImage.h>
#import "ZPJVideoPlayer.h"
#import "ZPJVideoToolbar.h"
#import "ZPJVideoListItem.h"

@interface ZPJVideoCell()

@property (nonatomic, strong) UIImageView *coverView;
@property (nonatomic, strong) UIImageView *playButton;
@property (nonatomic, copy) NSString *videoUrl;
@property (nonatomic, copy) NSString *videoCoverUrl;

@property (nonatomic, strong) ZPJVideoToolbar *videoToolbar;

@property (nonatomic, strong) ZPJVideoListItem *videoListItem;

@property (nonatomic, assign) CGSize cellSize;

@end

@implementation ZPJVideoCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViewWithFrame:frame];
    }
    return self;
}

- (void)dealloc {
}

/// 初始化view
/// @param frame 当前view的frame
- (void)setupViewWithFrame:(CGRect)frame {
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
        _videoToolbar = [[ZPJVideoToolbar alloc] initWithFrame:CGRectMake(0, _coverView.frame.size.height, frame.size.width, 0)];
        _videoToolbar;
    })];
    
    self.layer.cornerRadius = 15;
    self.layer.masksToBounds = YES;
    
    //点击全部Item都支持播放
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
    [self addGestureRecognizer:tapGesture];
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

/// 根据cell内容设置cell的布局信息
/// @param videoListItem cell的内容
- (void)layoutWithVideoItem:(ZPJVideoListItem *)videoListItem {
    self.videoListItem = videoListItem;
    [self.coverView sd_setImageWithURL:[NSURL URLWithString:self.videoListItem.videoCover]];
    self.videoUrl = self.videoListItem.videoPlayUrl;
    [self.videoToolbar layoutWithModel:self.videoListItem];
}

#pragma mark - private method

/// 点击开始播放
- (void)_tapToPlay {
    [[ZPJVideoPlayer sharedPlayer] playVideoWithvideoUrl:_videoUrl attachView:_coverView];
}

@end
