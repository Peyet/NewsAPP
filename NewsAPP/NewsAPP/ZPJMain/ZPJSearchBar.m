//
//  ZPJSearchBar.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/7.
//

#import "ZPJSearchBar.h"
#import "ZPJHeader.h"

@interface ZPJSearchBar ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

@implementation ZPJSearchBar

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kZPJScreenWidth, kZPJScreenNavigationBarHeight);
        [self addSubview:({
            _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, kZPJScreenWidth- 10*4, kZPJScreenNavigationBarHeight - 10)];
            _textField.backgroundColor = [UIColor whiteColor];
            _textField.layer.cornerRadius = 17;
            _textField.layer.masksToBounds = YES;
            _textField.delegate = self;
//            UIImage *leftImage = [UIImage imageNamed:@"NewsApp.png"];
//            _textField.leftView = [[UIImageView alloc] initWithImage:leftImage];
            _textField.leftViewMode = UITextFieldViewModeAlways;
            _textField.clearButtonMode = UITextFieldViewModeAlways;
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.alignment = NSTextAlignmentCenter;
            NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"今日热点推荐" attributes:@{NSParagraphStyleAttributeName:style}];
            _textField.attributedPlaceholder = attri;
            _textField;
        })];
    }
    return self;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_textField resignFirstResponder];
    return YES;
}


@end
