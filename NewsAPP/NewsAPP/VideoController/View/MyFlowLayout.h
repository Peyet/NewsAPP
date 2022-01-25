//
//  MyFlowLayout.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/20.
//

#import <UIKit/UIKit.h>
@class MyFlowLayout;

NS_ASSUME_NONNULL_BEGIN

@protocol MyFlowLayoutDelegate <NSObject>

@required
/// 返回cell高度
- (CGFloat)cellHeightWithIndexPath:(NSIndexPath *)indexPath;
/// 返回cell个数
- (NSInteger)cellCount;

@optional
/// 列间距
- (CGFloat)columnMarginInMyFlowLayout:(MyFlowLayout *)myFlowLayout;
/// 行间距
- (CGFloat)rowMarginInMyFlowLayout:(MyFlowLayout *)myFlowLayout;
/// collectionView边距
- (UIEdgeInsets)edgeInsetsInMyFlowLayout:(MyFlowLayout *)myFlowLayout;

@end

/// 视频tab中collectionView的flowlayout布局
@interface MyFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<MyFlowLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
