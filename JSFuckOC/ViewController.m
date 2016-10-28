//
//  ViewController.m
//  JSFuckOC
//
//  Created by Vizard on 16/9/14.
//  Copyright © 2016年 Vizard. All rights reserved.
//

#define SCREEN [UIScreen mainScreen].bounds.size
#import "ViewController.h"
//#import "SecondViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "LegendJS.h"
#import "UIColor+Hex.h"
#import "UpYun.h"
//#import "SDWebImage/UIImageView+WebCache.h"
#import "SDWebImage/UIButton+WebCache.h"
@interface ViewController ()<UIWebViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIBarButtonItem *sortBarButtonItem;
    NSString *temp;
    UIButton *button;
}


@property (nonatomic,weak) JSContext * context;
@property(nonatomic, strong) LegendJS *legend;

@property(nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;
//=====================UPyun===
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIProgressView *pv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _releaseButton = [UIButton new];
//    [_releaseButton setTitle:@"发布" forState:normal];
    _releaseButton.frame = CGRectMake(0, 0, 50, 25);
    
    _releaseButton.layer.cornerRadius = 5;
    _releaseButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _releaseButton.clipsToBounds = YES;
//    _releaseButton.backgroundColor = [UIColor redColor];
    [_releaseButton sd_setBackgroundImageWithURL:[NSURL URLWithString:@"http://10.0.1.221:8080/statics/img/insurance/status-mypolicy.png"] forState:UIControlStateNormal];
    [_releaseButton setImage:[UIImage imageNamed:@"status-mypolicy"] forState:UIControlStateNormal];
    _releaseButton.tintColor = [UIColor whiteColor];
   
    [_releaseButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_releaseButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];

    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,releaseButtonItem];
    
    _webView = [[UIWebView alloc] init];
    _webView.frame = CGRectMake(0, 0, SCREEN.width, SCREEN.height/2);
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    //加载本地html
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.html" ofType:nil];
//    NSLog(@"---%@",path);
    
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
//    NSLog(@"---url = %@",url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    if (button == nil) {
        //创建两个原生button,演示调用js方法
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2 +20, 200, 50);
//        button.backgroundColor = [UIColor blackColor];
//        [button setTitle:@"OC调用无参JS" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(function1) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [button setImage:[UIImage imageNamed:@"appoint_alert"] forState:UIControlStateNormal];

//        [button.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://10.0.1.221:8080/statics/img/insurance/status-mypolicy.png"]];
    }
    

     UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
     btn2.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2+100, 200, 50);
     btn2.backgroundColor = [UIColor blackColor];
     [btn2 setTitle:@"OC调用JS(传参)" forState:UIControlStateNormal];
     [btn2 addTarget:self action:@selector(function2) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:btn2];
    
}

#pragma -mark UIWebViewDelegate方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"开始请求");
    //获取js的运行环境
    _context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.legend.controller = self;
    [self.context setExceptionHandler:^(JSContext *context, JSValue *value) {
        NSLog(@"Web JS: %@", value);
    }];
//    [self addPayActionWithContext:_context];
    
//=====================block方式js调oc========================================
    //html调用无参数oc
    _context[@"carInfo"] = ^(){
        [self toCarInfoVc];
        
    };
//    _context[@"disMissVc"] = ^(){
//        [self disMissVc];
//    };
    //html调用oc(传参数过来)
    _context[@"test2"] = ^(){
        NSArray *args = [JSContext currentArguments];//传过来的参数
        for (id obj in args) {
            NSLog(@"---html传过来的参数\n%@",obj);
        }
        
        temp = [args[0] toString];
        
        NSString *name = [args[0] toString];
        
        NSString *str = [args[1] toString];
        [self menthod2:name and:str];
        //        [self sortAction];
    };
//=====================block方式js调oc========================================
    
    
    
    
    return YES;
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"--开始加载网页");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"网页加载完毕");
    _context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    [self.context setExceptionHandler:^(JSContext *context, JSValue *value) {
        NSLog(@"Web JS: %@", value);
    }];
    self.legend = [[LegendJS alloc] init];
    self.legend.controller = self;
#pragma -mark 传递的是个对象
    self.context[@"legendJS"] = self.legend;
    [self observeJSContext];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"网页加载出错");
}

#pragma -mark 供js调用的方法
- (void)toCarInfoVc{
    NSLog(@"JS调用了无参数OC方法");
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIViewController *vc = [UIViewController new];
        vc.title = @"补充车型信息";
        [self.navigationController pushViewController:vc animated:NO];
    
        if (button == nil) {
            //创建两个原生button,演示调用js方法
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2 +20, 200, 50);
            button.backgroundColor = [UIColor blackColor];
            [button setTitle:@"OC调用无参JS" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(function1) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    
    });
}

- (void)disMissVc
{
    NSLog(@"销毁当前的控制器!");
    dispatch_async(dispatch_get_main_queue(), ^{
        sortBarButtonItem.title = temp;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ggg" message:@"disMissVc" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    });
}
- (void)menthod2:(NSString *)str1 and:(NSString *)str2
{
     NSLog(@"%@%@",str1,str2);
    dispatch_async(dispatch_get_main_queue(), ^{
        sortBarButtonItem.title = temp;
        NSString *str = @"0xff055008";
        //先以16为参数告诉strtoul字符串参数表示16进制数字，然后使用0x%X转为数字类型
        unsigned long red = strtoul([str UTF8String],0,16);
        //strtoul如果传入的字符开头是“0x”,那么第三个参数是0，也是会转为十六进制的,这样写也可以：
//        unsigned long red = strtoul([@"0x6587" UTF8String],0,0);
        NSLog(@"转换完的数字为：%lx",red);
        
        _releaseButton.backgroundColor = [UIColor colorWithHex:strtoul([str1 UTF8String],0,16)];
        NSLog(@"---str1.integer.value = %ld",str1.integerValue);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str1 message:str2 delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    });

}

#pragma OC调用JS方法
 -(void)function1{
        [_webView stringByEvaluatingJavaScriptFromString:@"aaa()"];
     
     [UPYUNConfig sharedInstance].DEFAULT_BUCKET = @"test654123";
     [UPYUNConfig sharedInstance].DEFAULT_PASSCODE = @"0/8/1gPFWUQWGcfjFn6Vsn3VWDc=";
     __block UpYun *uy = [[UpYun alloc] init];
     uy.successBlocker = ^(NSURLResponse *response, id responseData) {
         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"上传成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
         [alert show];
         NSLog(@"response body %@", responseData);
     };
     uy.failBlocker = ^(NSError * error) {
         NSString *message = error.description;
         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"message" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
         [alert show];
         NSLog(@"error %@", error);
     };
     uy.progressBlocker = ^(CGFloat percent, int64_t requestDidSendBytes) {
         [_pv setProgress:percent];
     };
     
     /**
      *	@brief	根据 UIImage 上传
      */
         UIImage * image = [UIImage imageNamed:@"navigationbar_more_light.png"];
         [uy uploadFile:image saveKey:[self getSaveKeyWith:@"jpg"]];
     
         [uy uploadFile:image saveKey:@"2016.jpg"];
         [uy uploadImage:image savekey:[self getSaveKeyWith:@"png"]];
}
- (NSString * )getSaveKeyWith:(NSString *)suffix {
    /**
     *	@brief	方式1 由开发者生成saveKey
     */
    return [NSString stringWithFormat:@"/%@.%@", [self getDateString], suffix];
    /**
     *	@brief	方式2 由服务器生成saveKey
     */
    //    return [NSString stringWithFormat:@"/{year}/{mon}/{filename}{.suffix}"];
    /**
     *	@brief	更多方式 参阅 http://docs.upyun.com/api/form_api/#_4
     */
}
- (NSString *)getDateString {
    NSDate *curDate = [NSDate date];//获取当前日期
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy/MM/dd"];//这里去掉 具体时间 保留日期
    NSString * curTime = [formater stringFromDate:curDate];
    curTime = [NSString stringWithFormat:@"%@/%.0f", curTime, [curDate timeIntervalSince1970]];
    return curTime;
}

-(void)function2{
         NSString * name = @"pheromone";
         NSInteger num = 520;//准备传去给JS的参数
         [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"bbb('%@','%ld');",name,num]];
     }

- (void)clicked:(UIButton *)btn{
    
    NSLog(@"右上角按钮触发的方法---%@",self.method);
    //aaa换成要调用的方法名
//    [_webView stringByEvaluatingJavaScriptFromString:@"aaa()"];
//    SecondViewController *second = [SecondViewController new];
//    [self.navigationController pushViewController:second animated:NO];
    

}


- (void)addPayActionWithContext:(JSContext *)context
{
    context[@"payAction"] = ^() {
        NSArray *args = [JSContext currentArguments];
        
        if (args.count < 4) {
            return ;
        }
        
        NSString *orderNo = [args[0] toString];
        NSString *channel = [args[1] toString];
        long long amount = [[args[2] toNumber] longLongValue];
        NSString *subject = [args[3] toString];
        
        // 支付操作
        NSLog(@"orderNo:%@---channel:%@---amount:%lld---subject:%@",orderNo,channel,amount,subject);
        
        // 将支付结果返回给js
//                NSString *jsStr = [NSString stringWithFormat:@"payResult('%@')",@"支付成功"];
//                [[JSContext currentContext] evaluateScript:jsStr];
        [[JSContext currentContext][@"payResult"] callWithArguments:@[@"支付成功"]];
    };
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"----%ld",(long)buttonIndex);
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if (buttonIndex == 0) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else if(buttonIndex == 1) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable:sourceType] ) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        [self presentImagePickerControllerWithSourceType:sourceType];
    }

}
- (void)presentImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = sourceType;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
    
    self.imagePickerController = imagePicker;
    
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}


#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _pv.frame = CGRectMake(0, 20, 300, 5);
    [self.view addSubview:_pv];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self uploadImage:image];
//        UIImageView *iView = [UIImageView new];
//        iView.frame = CGRectMake(100, 100, 120, 200);
//        iView.image = image;
//        [self.view addSubview:iView];
        if (image.size.width > 512) {
//            image = [image scaleToSize:CGSizeMake(512, image.size.height * 512 / image.size.width)];
        }
//        NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
//        image = [UIImage imageWithData:imageData];
        
//
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private

- (void)observeJSContext
{
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    
    // This is a idle mode of RunLoop, when UIScrollView scrolls, it jumps into "UITrackingRunLoopMode"
    // and won't perform any cache task to keep a smooth scroll.
    CFStringRef runLoopMode = kCFRunLoopDefaultMode;
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler
    (kCFAllocatorDefault, kCFRunLoopBeforeWaiting, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity _) {
        JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        if (![_context isEqual:context]) {
            CFRunLoopRemoveObserver(runLoop, observer, runLoopMode);
            _context = context;
            _context[@"disMissVc"] = _legend;
           
        }
    });
    
    CFRunLoopAddObserver(runLoop, observer, runLoopMode);
}


#pragma -mark 又拍云上传图片
- (void)uploadImage:(UIImage *)Upimage
{
    [UPYUNConfig sharedInstance].DEFAULT_BUCKET = @"test654123";
    [UPYUNConfig sharedInstance].DEFAULT_PASSCODE = @"0/8/1gPFWUQWGcfjFn6Vsn3VWDc=";
    __block UpYun *uy = [[UpYun alloc] init];
    uy.successBlocker = ^(NSURLResponse *response, id responseData) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"上传成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        NSLog(@"response body %@", responseData);
    };
    uy.failBlocker = ^(NSError * error) {
        NSString *message = error.description;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"message" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        NSLog(@"error %@", error);
    };
    uy.progressBlocker = ^(CGFloat percent, int64_t requestDidSendBytes) {
        [_pv setProgress:percent];
    };
    
    /**
     *	@brief	根据 UIImage 上传
     */
    UIImage * image = Upimage;
    [uy uploadFile:image saveKey:[self getSaveKeyWith:@"jpg"]];
    
    [uy uploadFile:image saveKey:@"2016.jpg"];
    [uy uploadImage:image savekey:[self getSaveKeyWith:@"png"]];
}
@end
