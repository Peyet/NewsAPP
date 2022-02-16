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

/// 列表请求
@interface MyListLoader : NSObject

+ (instancetype)sharedMyListLoader;

- (void)loadListDataWithRequstBlock:(MyListLoaderRequestURLBlcok)requestURL FinishBlock:(MyListLoaderFinishBlcok)finishBlock;

@end
 
NS_ASSUME_NONNULL_END
