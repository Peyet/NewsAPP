//
//  NSString+LabelSizeCalculator.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/20.
//

#import "NSString+LabelSizeCalculator.h"

@implementation NSString (LabelSizeCalculator)

+ (CGSize)sizeWithText:(NSString *)text MaxSize:(CGSize)maxSize Font:(UIFont *)font
{
    return [text sizeOfTextWithMaxSize:maxSize Font:font];
}
- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize Font:(UIFont *)font
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
