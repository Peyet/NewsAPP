//
//  MyRecommendPageViewCellCollectionViewCell.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/19.
//

#import "MyRecommendPageViewCellCollectionViewCell.h"
#import "MyRecommendListItem.h"
#import <SDWebImage/SDWebImage.h>

@interface MyRecommendPageViewCellCollectionViewCell()

@property (nonatomic, strong, readwrite) UIImageView *pictureImageView;
@property (nonatomic, strong, readwrite) UILabel *pictureExcerptLabel;

@end

@implementation MyRecommendPageViewCellCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 添加图片
        [self addSubview:({
            _pictureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            _pictureImageView.layer.cornerRadius = 20;
            _pictureImageView.layer.masksToBounds = YES;
            _pictureImageView;
        })];
        
        // 添加图片标题
        // 默认字体大小配置
        CGFloat excerptFontSize = 15;
        [self addSubview:({
            _pictureExcerptLabel = [[UILabel alloc] init];
            _pictureExcerptLabel.font = [UIFont systemFontOfSize:excerptFontSize];
            _pictureExcerptLabel.numberOfLines = 2;
            _pictureExcerptLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _pictureExcerptLabel;
                })];

    }
    return self;
}

- (void)layoutCellWithModel:(MyRecommendListItem *)model {
    NSDictionary *imageInfo = [model.images firstObject];
    //https://photo.tuchong.com/ + user_id +/f/ + img_id 即图片地址
    NSString *imageURL = [NSString stringWithFormat:@"https://photo.tuchong.com/%@/f/%@.jpg", imageInfo[@"user_id"], imageInfo[@"img_id"]];
    [_pictureImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    // cell重用的时候重新布局大小
    _pictureImageView.frame = CGRectMake(0, 0, [model.cellSize[@"pictureSize"] CGSizeValue].width, [model.cellSize[@"pictureSize"] CGSizeValue].height);
    _pictureExcerptLabel.frame = CGRectMake(5, [model.cellSize[@"pictureSize"] CGSizeValue].height + 5, [model.cellSize[@"excerptSize"] CGSizeValue].width, [model.cellSize[@"excerptSize"] CGSizeValue].height);
    _pictureExcerptLabel.text = model.excerpt;


}


@end
