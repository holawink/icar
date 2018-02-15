//
//  Main_VC.m
//  CaptureAndSend
//
//  Created by Enric Vergara on 20/1/17.
//  Copyright © 2017 icarvision. All rights reserved.
//

//---Imports:---------
#import "Main_VC.h"
#import <IcarSDK/IcarSDK.h>
#import "DemoSDK_Constants.h"
#import "ShowBack_VC.h"
//--------------------

@interface Main_VC () <IcarCapture_Delegate>
{
    IdCloud_LocalImages*        localImages;
    IcarCapture_Configuration*  captureConfig;
}
@end

@implementation Main_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)startClicked:(id)sender
{
    //Capture BACK DOCUMENT:
    localImages = [[IdCloud_LocalImages alloc] init]; //alloc-->Quick way to reset the structure in charge of storing the captured images
    captureConfig  = [[IcarCapture_Configuration alloc] init];
    captureConfig.enableVibrationAutoFoto = YES;
    captureConfig.captureDocWithAutoFoto = YES;
    [captureConfig setInternalProcess:CaptureProcess_CAPTURE_IMAGE];
    captureConfig.icarLicenseKey = DemoSDK_icarLicenseKey;
    captureConfig.customized_AutoFoto.text_Toolbar = @"[ Place the ID <strong>(BACK)</strong> within the Box ]";
    
    IcarCapture_VC* vc = [[IcarCapture_VC alloc] initWithDelegate:self
                                                 andConfiguration:captureConfig
                                                    andLocalImage:localImages
                                                      andPosImage:0];
    
    IcarCapture_NC *nav = [[IcarCapture_NC alloc] init];
    [nav setViewControllers:[NSArray arrayWithObjects:vc, nil]];
    [self presentViewController:nav animated:NO completion:nil];
}



#pragma mark - IcarCapture_Delegate
- (void) captureDidCancel:(ICAR_CaptureResult) _result
{
    //Once we finish the process from IcarCapture, it's very important to call the function dismissViewControllerAnimated
    //this way we can hide the custom view controller IcarCapture_VC
    [self dismissViewControllerAnimated:NO completion:nil];
    
    
    //TODO: Manage possible cancellation cases
    if (_result == CaptureResult_CANCELED_BY_USER)
    {
        //...
        
    }
}

- (void) captureDidComplete
{
    //It's very important once we receive the image from the IcarCapture_VC to call the funcion dismissViewControllerAnimated
    [self dismissViewControllerAnimated:NO completion:^
    {
        [self performSegueWithIdentifier:@"FromStart2ShowBack" sender:nil];
    }];
}


 #pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"FromStart2ShowBack"])
    {
        ShowBack_VC* _vc = [segue destinationViewController];
        _vc.localImages     = localImages;
        _vc.captureConfig   = captureConfig;
    }
}




@end
