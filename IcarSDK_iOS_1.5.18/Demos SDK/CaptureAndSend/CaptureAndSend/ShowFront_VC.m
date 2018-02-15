//
//  ShowFront_VC.m
//  CaptureAndSend
//
//  Created by Enric Vergara on 20/1/17.
//  Copyright © 2017 icarvision. All rights reserved.
//

//---Imports:------
#import "ShowFront_VC.h"
#import "ShowSelfie_VC.h"
#import "DemoSDK_Constants.h"
//-----------------

@interface ShowFront_VC () <IcarCapture_Delegate>
{

}
@property (weak, nonatomic) IBOutlet UIImageView *front_img;

@end

@implementation ShowFront_VC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _front_img.image = [_localImages getImage:1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelProcess:(id)sender
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)next_Clicked:(id)sender
{
    //Capture FACE:
    [_captureConfig setInternalProcess:CaptureProcess_CAPTURE_FACE_DETECTION];
    _captureConfig.icarLicenseKey = DemoSDK_icarLicenseKey;
    _captureConfig.enableVibrationFaceDetection = YES;
    _captureConfig.liveness = YES;
    IcarCapture_VC* vc = [[IcarCapture_VC alloc] initWithDelegate:self
                                                 andConfiguration:_captureConfig
                                                    andLocalImage:_localImages
                                                      andPosImage:-1];
    
    IcarCapture_NC *nav = [[IcarCapture_NC alloc] init];
    [nav setViewControllers:[NSArray arrayWithObjects:vc, nil]];
    [self presentViewController:nav animated:NO completion:nil];
}


- (IBAction)retake:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
         [self performSegueWithIdentifier:@"FromShowFront2ShowSelfie" sender:nil];
     }];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FromShowFront2ShowSelfie"])
    {
        ShowSelfie_VC* _vc = [segue destinationViewController];
        _vc.localImages     = _localImages;
        _vc.captureConfig   = _captureConfig;
    }
}

@end
