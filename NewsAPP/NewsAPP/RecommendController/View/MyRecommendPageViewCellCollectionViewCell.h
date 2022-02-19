//
//  MyRecommendPageViewCellCollectionViewCell.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/19.
//

#import <UIKit/UIKit.h>
@class MyRecommendListItem;

NS_ASSUME_NONNULL_BEGIN

/// 推荐界面展示图片的cell
@interface MyRecommendPageViewCellCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong, readwrite) MyRecommendListItem *model;

/// 让cell展示信息
/// @param model 给cell 用来展示信息的model
- (void)layoutCellWithModel:(MyRecommendListItem *)model;

@end

NS_ASSUME_NONNULL_END
