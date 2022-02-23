//
//  MyRecommendListLoader.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/19.
//

#import <Foundation/Foundation.h>

@class MyRecommendListItem;
NS_ASSUME_NONNULL_BEGIN

/// 推荐界面的数据加载器
@interface MyRecommendListLoader : NSObject

typedef void(^MyListLoaderFinishBlcok)(BOOL success, NSArray<MyRecommendListItem *>  * _Nullable dataArray);

/// 网络数据加载器单例
+ (instancetype)sharedMyListLoader;

/// 加载网络数据
/// @param channelInfo 需要加载数据的频道（目前只有一个请求地址，为以后增加功能用，暂时为空）
/// @param finishBlock 完成网络请求的回调
- (void)loadListDataWithChannelInfo:(NSString * _Nullable )channelInfo FinishBlock:(MyListLoaderFinishBlcok)finishBlock;

@end

NS_ASSUME_NONNULL_END
