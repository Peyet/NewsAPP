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
typedef  NSString * _Nonnull (^MyListLoaderRequestURLBlcok)(void);


/// 网络数据加载器单例
+ (instancetype)sharedMyListLoader;

/// 加载网络数据
/// @param requestURL 需要加载数据的网址
/// @param finishBlock 完成网络请求的回调
- (void)loadListDataWithRequstBlock:(MyListLoaderRequestURLBlcok)requestURL FinishBlock:(MyListLoaderFinishBlcok)finishBlock;

@end

NS_ASSUME_NONNULL_END
