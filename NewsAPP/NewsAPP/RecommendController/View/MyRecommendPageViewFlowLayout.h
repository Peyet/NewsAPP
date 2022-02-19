//
//  MyRecommendPageViewFlowLayout.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/19.
//

#import <UIKit/UIKit.h>
@class MyRecommendPageViewFlowLayout;
@class MyRecommendListItem;

NS_ASSUME_NONNULL_BEGIN

@protocol MyRecommendPageViewFlowLayoutDelegate <NSObject>

@required
/// 计算cell的大小
/// @param indexPath 将要计算cell的model
/// @param myFlowLayout 当前layout
- (MyRecommendListItem *)cellImageSizeWithIndexPath:(NSIndexPath *)indexPath InFlowLayout:(MyRecommendPageViewFlowLayout *)myFlowLayout;

/// 返回cell个数
/// @param myFlowLayout 当前layout
- (int)cellCountInFlowLayout:(MyRecommendPageViewFlowLayout *)myFlowLayout;

/// 记录当前model对应的大小
/// @param indexPath 对应的model
/// @param cellSize 将要设置的cell的大小
/// @param myFlowLayout 当前layoutt
- (void)setCellImageSizeWithIndexPath:(NSIndexPath *)indexPath cellSize:(NSDictionary *)cellSize InFlowLayout:(MyRecommendPageViewFlowLayout *)myFlowLayout;

@end

/// waterLayout布局
@interface MyRecommendPageViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, strong, readwrite) id<MyRecommendPageViewFlowLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
