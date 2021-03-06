//
//  ZPJListLoader.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/15.
//

#import <Foundation/Foundation.h>

@class ZPJListItem;
NS_ASSUME_NONNULL_BEGIN

typedef void(^MyListLoaderFinishBlcok)(BOOL success, NSArray<ZPJListItem *> *dataArray);

/// 新闻界面的数据加载器
@interface ZPJListLoader : NSObject

+ (instancetype)sharedMyListLoader;

/// 加载网络数据
/// @param channelInfo 频道信息
/// @param finishBlock 完成网络请求的回调
- (void)loadListDataWithChannelInfo:(NSDictionary *)channelInfo FinishBlock:(MyListLoaderFinishBlcok)finishBlock;

@end
 
NS_ASSUME_NONNULL_END
