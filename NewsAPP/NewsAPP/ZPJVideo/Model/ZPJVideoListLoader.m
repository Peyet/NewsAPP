//
//  ZPJVideoListLoader.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/21.
//

#import "ZPJVideoListLoader.h"
#import "ZPJVideoListItem.h"
#import <AFNetworking.h>
#import "ZPJHeader.h"

@implementation ZPJVideoListLoader

/// 网络数据加载器的单例
+ (instancetype)sharedMyListLoader {
    static ZPJVideoListLoader *loader;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loader = [[ZPJVideoListLoader alloc] init];
    });
    return loader;
}

/// 加载网络数据
- (void)loadListDataWithChannel:(NSString *)channel FinishBlock:(MyListLoaderFinishBlcok)finishBlock {

    NSArray<ZPJVideoListItem *> *listData = [self _readDataFromLocal];
    if (listData) {
        finishBlock(YES, listData);
    }
    
    __weak typeof(self) weakSelf = self;
    NSString *channelURL = [NSString stringWithFormat:kZPJNetworkVideoURL, channel];
    [[AFHTTPSessionManager manager] GET:channelURL parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            // 请求成功，返回网络数据
            NSArray *dataArray = responseObject[kZPJModelKeyVideoGetData];
            NSMutableArray *listItemArray = [NSMutableArray arrayWithCapacity:30];
            for (NSDictionary *info in dataArray) {
                ZPJVideoListItem *listItem = [[ZPJVideoListItem alloc] initWithConfig:info];
                if (listItem) {
                    [listItemArray addObject:listItem];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finishBlock) {
                    finishBlock(YES, listItemArray);
                }
            });
            // 缓存数据
            [strongSelf _archiveListDataWithArray:listItemArray.copy];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 请求数据失败，返回本地缓存
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finishBlock) {
                    finishBlock(NO, listData);
                }
            });
        }];
}

#pragma mark - private method

/// 读取本地缓存数据
- (NSArray<ZPJVideoListItem *> *)_readDataFromLocal{
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
    NSString *listDataPath = [cachePath stringByAppendingPathComponent:kZPJLocalCacheVideoPath];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSData *readListData = [fileManager contentsAtPath:listDataPath];

    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class],[ZPJVideoListItem class], nil]  fromData:readListData error:nil];
    
    if ([unarchiveObj isKindOfClass:[NSArray class]] && [unarchiveObj count] > 0) {
        return (NSArray<ZPJVideoListItem *> *)unarchiveObj;
    }
    return nil;;
}

/// 缓存到本地网络数据
/// @param array 需要缓存的数据
- (void)_archiveListDataWithArray:(NSArray<ZPJVideoListItem *> *)array {
    NSArray *pathArray =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 初始化文件
    NSString *dataPath = [cachePath stringByAppendingPathComponent:kZPJLocalCachePath];
    if (![fileManager fileExistsAtPath:dataPath]) {
        NSError *createError;
        [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&createError];
    }
    
    // 缓存新闻数据
    NSString *listDataPath = [dataPath stringByAppendingPathComponent:kZPJLocalCacheVideoFileName];
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:NULL];
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];
}


@end
