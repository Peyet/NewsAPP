//
//  ZPJVideoToolbar.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/17.
//

#import <UIKit/UIKit.h>
@class ZPJVideoListItem;

NS_ASSUME_NONNULL_BEGIN

/// 视频Cell底部视频信息展示栏
@interface ZPJVideoToolbar : UIView

/// 重新布局videoToolbar的内容
/// @param model toolbar显示的信息模型
- (void)layoutWithModel:(ZPJVideoListItem *)model;

@end

NS_ASSUME_NONNULL_END
