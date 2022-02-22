//
//  ZPJNotification.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// APP 推送管理
@interface ZPJNotification : NSObject

+ (ZPJNotification *)sharedNotification;

- (void)checkNotificationAuthorization;

@end

NS_ASSUME_NONNULL_END
