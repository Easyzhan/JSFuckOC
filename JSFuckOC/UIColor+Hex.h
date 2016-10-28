//
//  UIColor+Hex.h
//  ShangouForIPhone
//
//  Created by Johnny on 1/6/14.
//  Copyright (c) 2014 zhipei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (instancetype)colorWithHex:(NSUInteger)hex;
+ (instancetype)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha;

@end
