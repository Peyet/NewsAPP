//
//  MyRecommendListLoader.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/19.
//

#import "MyRecommendListLoader.h"
#import <AFNetworking.h>
#import "MyRecommendListItem.h"

@implementation MyRecommendListLoader

/// 网络数据加载器的单例
+ (instancetype)sharedMyListLoader {
    static MyRecommendListLoader *loader;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loader = [[MyRecommendListLoader alloc] init];
    });
    return loader;
}

/// 加载网络数据
- (void)loadListDataWithRequstBlock:(MyListLoaderRequestURLBlcok)requestURL FinishBlock:(MyListLoaderFinishBlcok)finishBlock {
    // 加载网络数据
    __weak typeof(self) weakSelf = self;
    [[AFHTTPSessionManager manager] GET:requestURL() parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSArray *dataArray = responseObject[@"feedList"];
            NSMutableArray *listItemArray = [NSMutableArray arrayWithCapacity:30];
            for (NSDictionary *info in dataArray) {
                MyRecommendListItem *listItem = [[MyRecommendListItem alloc] initWithConfig:info];
                [listItemArray addObject:listItem];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                // 请求成功，返回网络数据
                if (finishBlock) {
                    finishBlock(YES, listItemArray);
                }
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 请求数据失败
                if (finishBlock) {
                    finishBlock(NO, nil);
                }
            });
        }];
}

@end
