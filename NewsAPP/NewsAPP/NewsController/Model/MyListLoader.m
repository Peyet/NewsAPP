//
//  MyListLoader.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/15.
//

#import "MyListLoader.h"
#import <AFNetworking.h>
#import "MyListItem.h"

@implementation MyListLoader

- (void)loadListDataWithFinishBlock:(MyListLoaderFinishBlcok)finishBlock {
    [[AFHTTPSessionManager manager] GET:@"http://v.juhe.cn/toutiao/index?type=top&key=d268884b9b07c0eb9d6093dc54116018" parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *dataArray = [(responseObject[@"result"]) objectForKey:@"data"];
            NSMutableArray *listItemArray = [NSMutableArray arrayWithCapacity:30];
            for (NSDictionary *info in dataArray) {
                MyListItem *listItem = [[MyListItem alloc] initWithConfig:info];
                [listItemArray addObject:listItem];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finishBlock) {
                    finishBlock(YES, listItemArray);
                }
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finishBlock) {
                    finishBlock(NO, nil);
                }
            });
        }];
}

@end
