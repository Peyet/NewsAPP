//
//  MyNormalTableViewCell.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MyListItem;

@protocol MyNormalTableViewCellDelegate <NSObject>

/// 点击删除按钮
/// @param tableViewCell cell所在的tableview
/// @param deleteButton 点击的删除按钮
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton;

@end

/// 新闻列表Cell
@interface MyNormalTableViewCell : UITableViewCell

@property (nonatomic, weak, readwrite) id<MyNormalTableViewCellDelegate> delegate;

- (void)layoutTableViewCellWithItem:(MyListItem *)item;

@end

NS_ASSUME_NONNULL_END
