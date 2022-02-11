//
//  MyLocation.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// app中统一的信息管理
@interface MyLocation : NSObject

+ (MyLocation *)locationManager;

- (void)checkLocationAuthorization;

@end

NS_ASSUME_NONNULL_END
