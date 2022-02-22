//
//  ZPJSplashView.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/27.
//

#import "ZPJSplashView.h"

@interface ZPJSplashView()

@property (nonatomic, strong) UIButton *button;

@end

@implementation ZPJSplashView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"Splash@x4.jpg"];
        self.userInteractionEnabled = YES;
        [self addSubview:({
            _button = [[UIButton alloc] initWithFrame:CGRectMake(330, 100, 60, 40)];
            _button.backgroundColor = [UIColor lightGrayColor];
            _button.layer.cornerRadius = 8;
            _button.layer.masksToBounds = YES;
            [_button setTitle:@"跳过" forState:UIControlStateNormal];
            [_button addTarget:self action:@selector(_removeSplashView) forControlEvents:UIControlEventTouchUpInside];
            _button;
        })];
    }
    return self;
}

- (void)_removeSplashView {
    [self removeFromSuperview];
}

@end
