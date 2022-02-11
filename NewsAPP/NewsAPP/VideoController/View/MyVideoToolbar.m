//
//  MyVideoToolbar.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/17.
//

#import "MyVideoToolbar.h"
#import <SDWebImage.h>
#import "MyDeleteCellView.h"
#import "MyVideoListItem.h"
#import "MyDeleteCellView.h"

@interface MyVideoToolbar()

@property (nonatomic, strong, readwrite) UILabel *videoTitleLabel;

@property (nonatomic, strong, readwrite) UILabel *tagLabel;

@property (nonatomic, strong, readwrite) UIImageView *authorAvatarImageView;
@property (nonatomic, strong, readwrite) UILabel *authorAvatarLabel;

@property (nonatomic, strong, readwrite) UIButton *closeButton;

@end

@implementation MyVideoToolbar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        // 默认字体大小配置
        CGFloat titleFontSize = 22, detailFontSize = 15;
        // 添加视频标题
        [self addSubview:({
            _videoTitleLabel = [[UILabel alloc] init];
            _videoTitleLabel.font = [UIFont systemFontOfSize:titleFontSize];
            _videoTitleLabel.numberOfLines = 0;
            _videoTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//            _videoTitleLabel.backgroundColor = [UIColor yellowColor];
            _videoTitleLabel;
                })];
        
        // 添加话题标签
        [self addSubview:({
            _tagLabel = [[UILabel alloc] init];
            _tagLabel.font = [UIFont systemFontOfSize:detailFontSize];
            _tagLabel.textColor = [UIColor redColor];
            _tagLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _tagLabel;
                })];
        
        // 添加作者头像
        [self addSubview:({
            _authorAvatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
            _authorAvatarImageView.layer.cornerRadius = 7.5;
            _authorAvatarImageView.layer.masksToBounds = YES;
            _authorAvatarImageView.layer.borderWidth = 0.1;
            _authorAvatarImageView.contentMode = UIViewContentModeScaleToFill;
            _authorAvatarImageView;
                })];
        
        // 添加作者名称
        [self addSubview:({
            _authorAvatarLabel = [[UILabel alloc] init];
            _authorAvatarLabel.font = [UIFont systemFontOfSize:detailFontSize];
            _authorAvatarLabel.textColor = [UIColor grayColor];
            _authorAvatarLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _authorAvatarLabel;
                })];
        
        // 添加删除按钮
        [self addSubview:({
            _closeButton = [[UIButton alloc] init];
            [_closeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            _closeButton.titleLabel.font = [UIFont systemFontOfSize:detailFontSize];
            [_closeButton addTarget:self action:@selector(_closeClicked) forControlEvents:UIControlEventTouchUpInside];
            _closeButton;
                })];
        
        self.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1];;
//        self.backgroundColor = [UIColor redColor];

    }
    return self;
}

/// 根据model重新布局
/// @param model 数据模型
- (void)layoutWithModel:(MyVideoListItem *)model {
    
    CGFloat margin = 10, marginWithSuperViewBottom = 10;
    _videoTitleLabel.text = model.videoTitle;
    _videoTitleLabel.frame = CGRectMake(margin, margin, self.frame.size.width  - margin*2, 0);
    [_videoTitleLabel sizeToFit];

    CGFloat yOfVideoTag = margin + _videoTitleLabel.frame.origin.y + _videoTitleLabel.frame.size.height ;
    _tagLabel.text = model.videoCategory;
    _tagLabel.frame = CGRectMake(margin, yOfVideoTag, 0, 0);
    [_tagLabel sizeToFit];
    
    [_authorAvatarImageView sd_setImageWithURL:[NSURL URLWithString:model.videoAuthorIcon]];
    _authorAvatarImageView.frame = CGRectMake(_tagLabel.frame.origin.x + _tagLabel.frame.size.width + margin, yOfVideoTag, _authorAvatarImageView.frame.size.width, _authorAvatarImageView.frame.size.height);
    
    _authorAvatarLabel.text = model.videoAuthorName;
    _authorAvatarLabel.frame = CGRectMake(_authorAvatarImageView.frame.origin.x + _authorAvatarImageView.frame.size.width + 3, yOfVideoTag, 0, 0);
    [_authorAvatarLabel sizeToFit];
    
    [_closeButton setTitle:@"X" forState:UIControlStateNormal];
    [_closeButton sizeToFit];
    _closeButton.frame = CGRectMake(self.frame.size.width - marginWithSuperViewBottom - _closeButton.frame.size.width, yOfVideoTag, _tagLabel.frame.size.width, _tagLabel.frame.size.height);
    [_closeButton sizeToFit];
    _closeButton.center = CGPointMake(_closeButton.center.x, _tagLabel.center.y);

    // 重新计算自己frame的高度
    self.frame = CGRectMake(0, self.frame.origin.y, self.frame.size.width, _tagLabel.frame.origin.y +_tagLabel.frame.size.height + marginWithSuperViewBottom);
}

- (void)_deleteButtonClick {
    MyDeleteCellView *deleteView = [MyDeleteCellView new];
    [deleteView showDeleteViewFromPoint:CGPointMake(0, 0) clickBlock:^{
            
    }];
}

#pragma mark - private method
- (void)_closeClicked {
    MyDeleteCellView *deleteView = [[MyDeleteCellView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
    [deleteView showDeleteViewFromPoint:CGPointMake(0, 0) clickBlock:^{
            
    }];
}

@end
