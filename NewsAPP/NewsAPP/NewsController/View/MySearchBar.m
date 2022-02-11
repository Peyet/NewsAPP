//
//  MySearchBar.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/7.
//

#import "MySearchBar.h"

@interface MySearchBar ()<UITextFieldDelegate>

@property (nonatomic, strong, readwrite) UITextField *textField;

@end

@implementation MySearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 10*4, frame.size.height - 10)];
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
