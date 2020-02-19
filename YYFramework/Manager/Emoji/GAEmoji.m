//
//  GAEmoji.m
//  FinancialPlanner
//
//  Created by houjianan on 2019/6/13.
//  Copyright © 2019 PUXIN. All rights reserved.
//

#import "GAEmoji.h"

@implementation GAEmoji
- (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = YES;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 // 区分九宫格输入 U+278b u'➋' -  U+2792 u'➒'
                 if (0x278b <= hs && hs <= 0x2792) {
                     returnValue = NO;
                     // 九宫格键盘上 “^-^” 键所对应的为符号 ☻
                 } else if (0x263b == hs) {
                     returnValue = NO;
                 } else {
                     returnValue = YES;
                 }
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

@end
