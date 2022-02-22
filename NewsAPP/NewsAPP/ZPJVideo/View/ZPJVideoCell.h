//
//  ZPJVideoCell.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/16.
//

#import <UIKit/UIKit.h>
@class ZPJVideoListItem;

NS_ASSUME_NONNULL_BEGIN

/// 视频Tab对应的Cell
@interface ZPJVideoCell : UICollectionViewCell

/// 根据cell内容设置cell的布局信息
/// @param videoListItem cell的内容
- (void)layoutWithVideoItem:(ZPJVideoListItem *)videoListItem;

@end

NS_ASSUME_NONNULL_END
