//
//  ZPJNormalNewsCell.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZPJListItem;

@protocol ZPJNormalNewsCellDelegate <NSObject>

/// 点击删除按钮
/// @param tableViewCell cell所在的tableview
/// @param deleteButton 点击的删除按钮
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton;

@end

/// 新闻列表Cell
@interface ZPJNormalNewsCell : UITableViewCell

@property (nonatomic, weak, readwrite) id<ZPJNormalNewsCellDelegate> delegate;

/// 计算cell的大小
/// @param item cell的模型数据
- (void)layoutTableViewCellWithItem:(ZPJListItem *)item;

@end

NS_ASSUME_NONNULL_END
