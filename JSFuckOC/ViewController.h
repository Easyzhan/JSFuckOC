//
//  ViewController.h
//  JSFuckOC
//
//  Created by Vizard on 16/9/14.
//  Copyright © 2016年 Vizard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIActionSheetDelegate>
{
//    UIButton *releaseButton;
}
@property (nonatomic,strong) UIWebView * webView;

@property(nonatomic, strong) UIButton *releaseButton;

@property(nonatomic, copy) NSString *method;
@end

