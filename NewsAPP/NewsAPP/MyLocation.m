//
//  MyLocation.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/30.
//

#import "MyLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface MyLocation()<CLLocationManagerDelegate>

@property (nonatomic, strong, readwrite) CLLocationManager *manager;

@end

@implementation MyLocation

+ (MyLocation *)locationManager {
    static MyLocation *locationManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationManager = [[MyLocation alloc] init];
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
