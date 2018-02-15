//
//  ShowSelfie_VC.m
//  CaptureAndSend
//
//  Created by Enric Vergara on 20/1/17.
//  Copyright © 2017 icarvision. All rights reserved.
//

//----Imports:-------
#import "ShowSelfie_VC.h"
#import "IcarCloudResults_TVC.h"
#import "DemoSDK_Constants.h"
//-------------------

@interface ShowSelfie_VC () <IdCloud_Connection_Delegate>
{
    IdCloud_DataResult* dataResult;
    IdCloud_Result*     idCloud_Result;
    UIAlertController*  alert;
}
@property (weak, nonatomic) IBOutlet UIImageView *selfie_img;

@end

@implementation ShowSelfie_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    _selfie_img.image = _localImages.faceDetected;
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
    alert = [UIAlertController alertControllerWithTitle:nil
                                                message:@"Please Wait\n\n\n"
                                         preferredStyle:UIAlertControllerStyleAlert];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(130.5, 65.5);
    spinner.color = [UIColor blackColor];
    [spinner startAnimating];
    [alert.view addSubview:spinner];
    [self presentViewController:alert animated:NO completion:nil];
    
    //Do Connection:
    //Configure the server information:
    IdCloud_Configuration*  idCloud_Conf;
    idCloud_Conf = [[IdCloud_Configuration alloc] init];
    
    idCloud_Conf.user           = DemoSDK_IDCloud_User;
    idCloud_Conf.password       = DemoSDK_IDCloud_Password;
    idCloud_Conf.company        = DemoSDK_IDCloud_Company;
    idCloud_Conf.server_Port    = @"50061";
    idCloud_Conf.server_Timeout = 20000; //in milliseconds
    idCloud_Conf.server_URL     = @"https://demoidcloud.icarvision.com";
    idCloud_Conf.icarLicenseKey = DemoSDK_icarLicenseKey;;
    
    //Configure the images to be sent to the server:
    
    
    [idCloud_Conf setFaceValidation:_localImages.faceDetected];
    //Execute the process in the server:
    dataResult = [[IdCloud_DataResult alloc] init];
    
    IdCloud_Connection* m_IdCloud_Connection = [[IdCloud_Connection alloc] init];
    [m_IdCloud_Connection processIdCloudWithConf:idCloud_Conf
                                          images:_localImages
                                        delegate:self
                                   andDataResult:dataResult];
}


- (IBAction)retake:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark - IdCloud_Connection_Delegate
- (void) connectionDidCancel:(IdCloud_Result*)_result
{
    [alert dismissViewControllerAnimated:YES completion:^{
        NSString* title     = @"";
        NSString* message   = @"";
        
        message = [NSString stringWithFormat:@"IdCloud Process Error: %@ (Code %@)",_result.error_desc, _result.error_code];
        title   = @"IdCloud Process Connection";
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:title
                                              message:message
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                   }];
        
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:NO completion:nil];
    }];
    
    
    
}
- (void) connectionDidComplete:(IdCloud_Result*)_result
{
    idCloud_Result = _result;
    [alert dismissViewControllerAnimated:YES completion:nil];
    [self performSegueWithIdentifier:@"FromShowSelfie2ShowCloudResults" sender:nil];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FromShowSelfie2ShowCloudResults"])
    {
        IcarCloudResults_TVC* _vc = [segue destinationViewController];
        _vc.idCloud_DataResult = dataResult;
        _vc.idCloud_Result = idCloud_Result;
        _vc.localImages = _localImages;
    }
}

@end
