//
//  MyNotification.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/30.
//

#import "MyNotification.h"
#import <UserNotifications/UserNotifications.h>

@interface MyNotification ()<UNUserNotificationCenterDelegate>

@property (nonatomic, strong, readwrite) MyNotification *notificationManager;

@end

@implementation MyNotification

+ (MyNotification *)notificationManager {
    static MyNotification *notificationManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notificationManager = [[MyNotification alloc] init];
    });
    return notificationManager;
}

- (void)checkNotificationAuthorization {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            [self _pushLocalNotification];
        }
        }];
}

#pragma mark - private method

- (void)_pushLocalNotification {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.badge = @(2);
    content.title = @"热点新闻！！！";
    content.body = @"一条即时的热点新闻！";
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:60.f repeats:YES];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"_pushLocalNotification" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            
    }];
}

#pragma mark - UNUserNotificationCenterDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    completionHandler(UNNotificationPresentationOptionAlert);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    // 处理业务逻辑
    completionHandler();
}


@end
