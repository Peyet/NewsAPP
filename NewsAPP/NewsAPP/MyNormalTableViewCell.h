//
//  MyNormalTableViewCell.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MyNormalTableViewCellDelegate <NSObject>

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton;

@end

@interface MyNormalTableViewCell : UITableViewCell

@property (nonatomic, weak, readwrite) id<MyNormalTableViewCellDelegate> delegate;

- (void)layoutTableViewCell; 

@end

NS_ASSUME_NONNULL_END
