//
//  SHQRCodeVC.m
//  SHTool
//
//  Created by senyuhao on 09/02/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "SHQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SHBaseManager.h"
#import "SHBaseAlert.h"

@interface SHQRCodeVC ()<AVCaptureMetadataOutputObjectsDelegate> {
    int num;
    BOOL upOrDown;
    NSTimer *timer;
    CAShapeLayer *cropLayer;
    UIButton *bnLight;
    
    CGFloat scanLeft;
    CGFloat scanTop;
}

@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic, strong) UIImageView *line;

@end

@implementation SHQRCodeVC

- (void)dealloc {
    [timer invalidate];
    timer = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGRect cropRect = CGRectMake(scanLeft, scanTop, [SHBaseManager shareInstance].scanBounds.size.width, [SHBaseManager shareInstance].scanBounds.size.height);
    [self setCropRect:cropRect];
    [self performSelector:@selector(setupCamera) withObject:nil afterDelay:0.3];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫码用车";
    
    [self configView];
}

-(void)configView{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:[SHBaseManager shareInstance].scanBounds];
    imageView.image = [SHBaseManager shareInstance].scanBackgroudImage;
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    upOrDown = NO;
    num =0;
    
    scanLeft = ([SHBaseManager screenWidth] - [SHBaseManager shareInstance].scanBounds.size.width)/2;
    scanTop = ([SHBaseManager screenHeight] - [SHBaseManager shareInstance].scanBounds.size.height)/2;
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(scanLeft, scanTop, [SHBaseManager shareInstance].scanBounds.size.width, 2)];
    _line.image = [SHBaseManager shareInstance].scanLineImage;
    [self.view addSubview:_line];
    
    bnLight = [[UIButton alloc] initWithFrame:CGRectMake(0, scanTop + [SHBaseManager shareInstance].scanBounds.size.height + 10, [SHBaseManager screenWidth], 30)];
    [bnLight setTitle:@"轻点照亮" forState:UIControlStateNormal];
    [bnLight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bnLight addTarget:self action:@selector(lightAction:) forControlEvents:UIControlEventTouchUpInside];
    bnLight.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:bnLight];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animationScanLine) userInfo:nil repeats:YES];
    
}

- (void)animationScanLine {
    if (upOrDown == NO) {
        num ++;
        _line.frame = CGRectMake(scanLeft, scanTop+2*num, [SHBaseManager shareInstance].scanBounds.size.width, 2);
        if (2*num == [SHBaseManager shareInstance].scanBounds.size.height) {
            upOrDown = YES;
        }
    } else {
        num --;
        _line.frame = CGRectMake(scanLeft, scanTop+2*num, 220, 2);
        if (num == 0) {
            upOrDown = NO;
        }
    }
}

- (void)setCropRect:(CGRect)cropRect{
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, self.view.bounds);
    
    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.8];
    
    [cropLayer setNeedsDisplay];
    [self.view.layer addSublayer:cropLayer];
    
    [self.view bringSubviewToFront:bnLight];
}

- (void)backAction {
    if ([self.navigationController.viewControllers count] > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setupCamera {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        [SHBaseAlert alertConfirm:^{
            [self backAction];
        } title:nil cancel:@"取消" sure:@"确认" content:@"请在iPhone的'设置'-'隐私'-'相机'功能中，找到'共享单车定位'打开相机访问权限"];
        return;
    }
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device == nil) {
        [SHBaseAlert alertConfirm:^{
            [self backAction];
        } title:nil cancel:@"取消" sure:@"确认" content:@"设备没有摄像头"];
        return;
    }
    
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置扫描区域
    CGFloat top = scanTop/[SHBaseManager screenHeight];
    CGFloat left = scanLeft/[SHBaseManager screenWidth];
    CGFloat width = [SHBaseManager shareInstance].scanBounds.size.width*1.0/[SHBaseManager screenWidth];
    CGFloat height = [SHBaseManager shareInstance].scanBounds.size.height*1.0/[SHBaseManager screenWidth];
    ///top 与 left 互换  width 与 height 互换
    [_output setRectOfInterest:CGRectMake(top,left, height, width)];
    
    // Session
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input]) {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output]) {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    [_output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode, nil]];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    // Start
    [_session startRunning];
}

#pragma mark - Action
- (void)lightAction:(UIButton *)sender {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) { // 判断是否有闪光灯
        // 请求独占访问硬件设备
        [device lockForConfiguration:nil];
        if ([sender.titleLabel.text isEqualToString:@"轻点照亮"]) {
            [device setTorchMode:AVCaptureTorchModeOn]; // 手电筒开
            [sender setTitle:@"轻点关闭" forState:UIControlStateNormal];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff]; // 手电筒关
            [sender setTitle:@"轻点照亮" forState:UIControlStateNormal];
        }
        // 请求解除独占访问硬件设备
        [device unlockForConfiguration];
    }
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    if ([metadataObjects count] >0) {
        //停止扫描
        [_session stopRunning];
        [timer setFireDate:[NSDate distantFuture]];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        NSString *stringValue = metadataObject.stringValue;
        if (self.resultBlock) {
            self.resultBlock(stringValue);
        }
        [self backAction];
    }
}



@end
