//
//  ZPJLocation.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/30.
//

#import "ZPJLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface ZPJLocation()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;

@end

@implementation ZPJLocation

+ (ZPJLocation *)sharedLocation {
    static ZPJLocation *locationManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationManager = [[ZPJLocation alloc] init];
    });
    return locationManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.manager = [[CLLocationManager alloc] init];
        self.manager.delegate = self;
    }
    return self;
}

- (void)checkLocationAuthorization {
    // 判断系统是否开启位置服务
    if (![CLLocationManager locationServicesEnabled ]) {
        // 引导弹窗
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.manager requestWhenInUseAuthorization];
    }
}

#pragma mark -  CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
}



@end
