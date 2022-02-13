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

- (void)loadListDataWithChannel:(NSString *)channel FinishBlock:(MyListLoaderFinishBlcok)finishBlock {

    NSArray<MyListItem *> *listData = [self _readDataFromLocal];
    if (listData) {
        finishBlock(YES, listData);
    }
    
    __weak typeof(self) weakSelf = self;
    NSString *channelURL = [NSString stringWithFormat:@"http://v.juhe.cn/toutiao/index?type=%@&key=d268884b9b07c0eb9d6093dc54116018", channel];
    [[AFHTTPSessionManager manager] GET:channelURL parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
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
            // 缓存数据
            [strongSelf _archiveListDataWithArray:listItemArray.copy];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finishBlock) {
                    finishBlock(NO, nil);
                }
            });
        }];
}

#pragma mark - private method

- (NSArray<MyListItem *> *)_readDataFromLocal{
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
    NSString *listDataPath = [cachePath stringByAppendingPathComponent:@"MYData/list"];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSData *readListData = [fileManager contentsAtPath:listDataPath];

    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class],[MyListItem class], nil]  fromData:readListData error:nil];
    
    if ([unarchiveObj isKindOfClass:[NSArray class]] && [unarchiveObj count] > 0) {
        return (NSArray<MyListItem *> *)unarchiveObj;
    }
    return nil;;
}

- (void)_archiveListDataWithArray:(NSArray<MyListItem *> *)array {
    NSArray *pathArray =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 初始化文件
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"MYData"];
    if ([fileManager fileExistsAtPath:dataPath]) {
        NSError *createError;
        [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&createError];
    }
    
    // 缓存新闻数据
    NSString *listDataPath = [dataPath stringByAppendingPathComponent:@"list"];
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:NULL];
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];
    
    NSData *readListData = [fileManager contentsAtPath:listDataPath];
    id unarchivedObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[MyListItem class], [NSArray class], nil] fromData:readListData error:NULL];
}

@end
