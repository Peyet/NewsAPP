//
//  MyDeleteCellView.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 删除图层
@interface MyDeleteCellView : UIView

/// 点击出现删除cell浮层
/// @param point 点击的位置
/// @param clickBlock 点击后的操作
- (void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock;

@end

NS_ASSUME_NONNULL_END
