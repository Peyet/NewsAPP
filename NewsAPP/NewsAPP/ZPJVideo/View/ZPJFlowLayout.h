//
//  ZPJFlowLayout.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/20.
//

#import <UIKit/UIKit.h>
@class ZPJFlowLayout;

NS_ASSUME_NONNULL_BEGIN

@protocol ZPJFlowLayoutDelegate <NSObject>

@required
/// 返回cell高度
- (CGFloat)cellHeightWithIndexPath:(NSIndexPath *)indexPath;
/// 返回cell个数
- (NSInteger)cellCount;

@end

/// 视频tab中collectionView的flowlayout布局
@interface ZPJFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<ZPJFlowLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
