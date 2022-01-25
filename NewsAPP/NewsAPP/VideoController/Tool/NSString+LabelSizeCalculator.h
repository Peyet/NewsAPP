//
//  NSString+LabelSizeCalculator.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LabelSizeCalculator)

+ (CGSize)sizeWithText:(NSString *)text MaxSize:(CGSize)maxSize Font:(UIFont *)font;
- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize Font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
