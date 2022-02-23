//
//  ZPJMultiPicNewsCell.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/22.
//

#import <UIKit/UIKit.h>
@class ZPJListItem;

NS_ASSUME_NONNULL_BEGIN

@interface ZPJMultiPicNewsCell : UITableViewCell

/// 计算cell的大小
/// @param item cell的模型数据
- (void)layoutTableViewCellWithItem:(ZPJListItem *)item;

@end

NS_ASSUME_NONNULL_END
