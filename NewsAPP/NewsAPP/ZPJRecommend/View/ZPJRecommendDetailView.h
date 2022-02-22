//
//  ZPJRecommendDetailView.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/21.
//

#import <UIKit/UIKit.h>
@class MyRecommendListItem;

NS_ASSUME_NONNULL_BEGIN

@protocol ZPJRecommendDetailViewDelegate <NSObject>
/// 恢复tabbar，不再隐藏
- (void)showTabBar;
@end

@interface ZPJRecommendDetailView : UIView

/// 显示图片详情
/// @param model 需要显示的图片的模型数据
- (void)showImageDetailWithModel:(MyRecommendListItem *)model;

@property (nonatomic, strong) id<ZPJRecommendDetailViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
