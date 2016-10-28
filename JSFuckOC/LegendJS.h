//
//  LegendJS.h
//  JSFuckOC
//
//  Created by Vizard on 16/9/17.
//  Copyright © 2016年 Vizard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "UIColor+Hex.h"
//#import "SecondViewController.h"
@protocol LegendJSProtocol <JSExport>

- (void)disMissVc;

JSExportAs(setRightActionBarByText,- (void)setUpNavItemColorWithHexAndText:(NSString *)controlText method:(NSString *)method);
JSExportAs(setRightActionButtonByImgUrl,- (void)showNavgationItemByImage:(NSString *)imageUrl method:(NSString *)method);

JSExportAs(payByAlipay, - (void)payByAlipay:(NSString *)order);
JSExportAs(payByWechat, - (void)payByWechat:(NSString *)order);

JSExportAs(capture,- (void)capture:(NSString *)token whichspot:(NSString *)whichspot);

#pragma -mark Native跳转到补充车型信息 不用参数
- (void)showAddCar;

- (void)callCIA:(NSString *)numPhone;
- (void)getTimeStamp;
@end

@interface LegendJS : NSObject<LegendJSProtocol>

@property (nonatomic, strong) ViewController *controller;

@end
