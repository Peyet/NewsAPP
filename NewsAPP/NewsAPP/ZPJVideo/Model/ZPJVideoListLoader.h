//
//  ZPJVideoListLoader.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/21.
//

#import <Foundation/Foundation.h>
@class ZPJVideoListItem;

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyListLoaderFinishBlcok)(BOOL success, NSArray<ZPJVideoListItem *> *dataArray);

/// 视频界面的数据加载器
@interface ZPJVideoListLoader : NSObject

/// 网络数据加载器单例
+ (instancetype)sharedMyListLoader;

/// 加载网络数据
/// @param channel 需要加载数据的频道
/// @param finishBlock 完成网络请求的回调
- (void)loadListDataWithChannel:(NSString *)channel FinishBlock:(MyListLoaderFinishBlcok)finishBlock;

@end

NS_ASSUME_NONNULL_END
