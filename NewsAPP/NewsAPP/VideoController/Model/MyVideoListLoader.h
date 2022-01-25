//
//  MyVideoListLoader.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/21.
//

#import <Foundation/Foundation.h>
@class MyVideoListItem;

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyListLoaderFinishBlcok)(BOOL success, NSArray<MyVideoListItem *> *dataArray);

@interface MyVideoListLoader : NSObject

- (void)loadListDataWithFinishBlock:(MyListLoaderFinishBlcok)finishBlock;

@end

NS_ASSUME_NONNULL_END
