//
//  MyMineViewController.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/15.
//

#import "MyMineViewController.h"

@interface MyMineViewController ()

@end

@implementation MyMineViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor grayColor];
        self.tabBarItem.title = @"我的";
        self.tabBarItem.image = [UIImage imageNamed:@"home@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"home@2x_selected.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"mineController");
}


@end
