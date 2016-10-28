//
//  LegendJS.m
//  JSFuckOC
//
//  Created by Vizard on 16/9/17.
//  Copyright © 2016年 Vizard. All rights reserved.
//

#import "LegendJS.h"
#import "UIImageView+WebCache.h"
#import "CKAlertViewController.h"
@interface LegendJS()
@end
@implementation LegendJS

- (void)disMissVc
{
    NSLog(@"销毁当前的控制器eee!");
    dispatch_async(dispatch_get_main_queue(), ^{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ggg从LegendJS" message:@"disMissVc" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alert show];
        [_controller.navigationController popToRootViewControllerAnimated:YES];
    });

}

- (void)setUpNavItemColorWithHexAndText:(NSString *)controlText method:(NSString *)method{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (controlText.length > 0) {
            
            [_controller.releaseButton setImage:nil forState:UIControlStateNormal];
            [_controller.releaseButton setTitle:controlText forState:UIControlStateNormal];
//            [_controller.releaseButton setBackgroundColor:[UIColor colorWithHex:strtoul([hex UTF8String],0,16)]];
            [_controller.releaseButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            NSLog(@"---方法名,%@",method);
            _controller.method = method;
            _controller.title = controlText;
            
        }
    });
}


- (void)showNavgationItemByImage:(NSString *)imageUrl method:(NSString *)method
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"-----%@",imageUrl);
        [_controller.releaseButton setTitle:@"" forState:UIControlStateNormal];
        _controller.method = method;
        [_controller.releaseButton setBackgroundColor:nil];

        [_controller.releaseButton.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://10.0.1.221:8080/statics/img/insurance/status-mypolicy.png"]];
        
        [_controller.releaseButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    });
}

- (void)showAddCar
{
    NSLog(@"JS调用了无参数的OC方法");
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIViewController *vc = [UIViewController new];
        vc.title = @"补充车型信息";
        [_controller.navigationController pushViewController:vc animated:NO];
        
        
        
    });
    
}
- (void)payByAlipay:(NSString *)orderNo
{

    NSLog(@"orderNo:%@",orderNo);
    
    if ([orderNo  isEqual: @"201511120981234"]) {
        CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:[NSString stringWithFormat:@"发现新版本(%@)",@"34"] message:@"xiangqing"];
        alertVC.messageAlignment = NSTextAlignmentLeft;
        
        CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"朕知道了" handler:^(CKAlertAction *action) {
        [_controller.webView stringByEvaluatingJavaScriptFromString:@"payResult('cao')"];
        }];
        
        CKAlertAction *update = [CKAlertAction actionWithTitle:@"立即更新" handler:^(CKAlertAction *action) {
       
        }];
        
        [alertVC addAction:cancel];
        [alertVC addAction:update];
        
        [self.controller presentViewController:alertVC animated:NO completion:nil];
//        [[JSContext currentContext][@"payResult"] callWithArguments:@[@"支付成功"]];
        
//        [[JSContext currentContext][@"payResult"] callWithArguments:@[@"支付成功"]];
    }else{
        [[JSContext currentContext][@"payResult"] callWithArguments:@[orderNo]];
    }

}


- (void)capture:(NSString *)token whichspot:(NSString *)whichspot{

//    __weak typeof(self) weakSelf = self;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片"
//                                                                 delegate:_controller
//                                                        cancelButtonTitle:@"取消"
//                                                   destructiveButtonTitle:nil
//                                                        otherButtonTitles:@"图库", @"拍照", nil];
//        [actionSheet showInView:_controller.view];
//        if ([whichspot isEqualToString:@"证件照"]) {
            [[JSContext currentContext][whichspot] callWithArguments:@[@"上传成功"]];
//        }else{
//            [[JSContext currentContext][whichspot] callWithArguments:@[@"艳照搞来"]];
//        }
//    });
    NSLog(@"i am h5 ye baby give me pic iwant this%@然后回调 =%@方法",token,whichspot);
   
}

- (void)callCIA:(NSString *)numPhone{
    
//    NSString *phoneNum = [NSString stringWithFormat:@"tel:10010"];
//     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNum]];
    UIWebView *webView = [[UIWebView alloc]init];
    NSString *str = [NSString stringWithFormat:@"tel://%@",numPhone];
    NSURL *url = [NSURL URLWithString:str];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)getTimeStamp{
    NSTimeInterval systemStartupTime = [[NSDate date] timeIntervalSince1970] * 1000;
    NSLog(@"---systemStartupTime = %@",[NSString stringWithFormat:@"%f",systemStartupTime]);
}

- (void)showAlert:(NSString *)appStoreVersion
{
    CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:[NSString stringWithFormat:@"发现新版本(%@)",appStoreVersion] message:@"xiangqing"];
    alertVC.messageAlignment = NSTextAlignmentLeft;
    
    CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"朕知道了" handler:^(CKAlertAction *action) {
        
    }];
    
    CKAlertAction *update = [CKAlertAction actionWithTitle:@"立即更新" handler:^(CKAlertAction *action) {
        
    }];
    
    [alertVC addAction:cancel];
    [alertVC addAction:update];
    
    [self.controller presentViewController:alertVC animated:NO completion:nil];
}
@end
