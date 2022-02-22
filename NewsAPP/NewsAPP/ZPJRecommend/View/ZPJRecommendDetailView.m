//
//  ZPJRecommendDetailView.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/21.
//

#import "ZPJRecommendDetailView.h"
#import "ZPJHeader.h"
#import "MyRecommendListItem.h"
#import <SDWebImage/SDWebImage.h>

@interface ZPJRecommendDetailView()

@property (nonatomic, strong) MyRecommendListItem *model;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ZPJRecommendDetailView

- (void)showImageDetailWithModel:(MyRecommendListItem *)model {
    _model = model;
    [self setupView];
}

/// 初始化图片详情
- (void)setupView {
    [CAAnimation animation];
    self.frame = CGRectMake(0, 0, kZPJScreenWidth, kZPJScreenHeight);
    self.backgroundColor = [UIColor whiteColor];
    
    // 添加图片展示器
    [self addSubview:({
        _imageView = [[UIImageView alloc] init];
        _imageView.center = self.center;
        [_imageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_dismissDetailView)];
        [_imageView addGestureRecognizer:tapGesture];
        _imageView;
    })];
    
    // 获取并添加图片
    NSDictionary *imageInfo = [_model.images firstObject];
    //https://photo.tuchong.com/ + user_id +/f/ + img_id 即图片地址
    NSString *imageURL = [NSString stringWithFormat:kZPJNetworkRecommendDetailURL, imageInfo[kZPJModelKeyRecommendImageUserID], imageInfo[kZPJModelKeyRecommendImageImageID]];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:kZPJImagePlaceHolder]];
    // 图片大小
    CGFloat imageViewHeight, imageViewWidth = kZPJScreenWidth;
    imageViewHeight = imageViewWidth * [imageInfo[kZPJModelKeyRecommendImageHeight] floatValue]/ [imageInfo[kZPJModelKeyRecommendImageWidth] floatValue];
    _imageView.frame = CGRectMake(0, 0, imageViewWidth, imageViewHeight);
    _imageView.center = self.center;
    
    CGFloat margin = 7;
    // 添加图片互动数据
    UIView *authorInfoBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kZPJScreenWidth, kZPJScreenStatusBarHeight + kZPJScreenNavigationBarHeight)];
    authorInfoBackgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:authorInfoBackgroundView];
    
    // 作者头像
    UIImageView *authorIconView = [[UIImageView alloc] initWithFrame:CGRectMake(22, kZPJScreenStatusBarHeight, kZPJScreenNavigationBarHeight, kZPJScreenNavigationBarHeight)];
    authorIconView.layer.cornerRadius = 22;
    authorIconView.layer.masksToBounds = YES;
    NSString *authorIconURL = _model.site[kZPJModelKeyRecommendAuthorIcon];
    [authorIconView sd_setImageWithURL:[NSURL URLWithString:authorIconURL] placeholderImage:[UIImage imageNamed:kZPJImagePlaceHolder]];
    [authorInfoBackgroundView addSubview:authorIconView];
    
    // 作者姓名
    UILabel *authorNameView = [[UILabel alloc] initWithFrame:CGRectMake(22 + kZPJScreenStatusBarHeight + margin, kZPJScreenStatusBarHeight + margin, 0, 0)];
    authorNameView.text = _model.site[kZPJModelKeyRecommendAuthorName];
    authorNameView.font = [UIFont boldSystemFontOfSize:25];
    authorNameView.textColor = [UIColor blackColor];
    [authorNameView sizeToFit];
    [authorInfoBackgroundView addSubview:authorNameView];
    
    // 关注按钮
    UILabel *followAuhorView = [[UILabel alloc] initWithFrame:CGRectMake(kZPJScreenWidth - 100, kZPJScreenStatusBarHeight, 60, 38)];
    followAuhorView.text = @"关注";
    followAuhorView.backgroundColor = [UIColor systemPinkColor];
    followAuhorView.textColor = [UIColor whiteColor];
    followAuhorView.textAlignment = NSTextAlignmentCenter;
    followAuhorView.layer.cornerRadius = 10;
    followAuhorView.layer.masksToBounds = YES;
    [authorInfoBackgroundView addSubview:followAuhorView];

    // 图片说明背景
    UIView *imageExcerptBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame), kZPJScreenWidth, kZPJScreenStatusBarHeight + kZPJScreenNavigationBarHeight)];
    imageExcerptBackgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:imageExcerptBackgroundView];

    // 图片说明
    UITextView *imageExcerptView = [[UITextView alloc] initWithFrame:CGRectZero];
    imageExcerptView.text = _model.excerpt;
    imageExcerptView.font = [UIFont systemFontOfSize:20];
    [imageExcerptView sizeToFit];
    [imageExcerptBackgroundView addSubview:imageExcerptView];
}

/// 关闭详情页
- (void)_dismissDetailView {
    if ([self.delegate respondsToSelector:@selector(showTabBar)]) {
        [self.delegate showTabBar];
    }
    [self removeFromSuperview];
}

@end
