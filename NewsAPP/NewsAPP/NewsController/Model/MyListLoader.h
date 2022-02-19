//
//  MyListLoader.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/15.
//

#import <Foundation/Foundation.h>

@class MyListItem;
NS_ASSUME_NONNULL_BEGIN

typedef void(^MyListLoaderFinishBlcok)(BOOL success, NSArray<MyListItem *> *dataArray);
typedef  NSString * _Nonnull (^MyListLoaderRequestURLBlcok)(void);

/// 新闻界面的数据加载器
@interface MyListLoader : NSObject

+ (instancetype)sharedMyListLoader;

/// 加载网络数据
/// @param requestURL 需要加载数据的网址
/// @param finishBlock 完成网络请求的回调
- (void)loadListDataWithRequstBlock:(MyListLoaderRequestURLBlcok)requestURL FinishBlock:(MyListLoaderFinishBlcok)finishBlock;

@end
 
NS_ASSUME_NONNULL_END
