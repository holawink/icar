//
//  IcarCloudResults_TVC.m
//  CaptureAndSend
//
//  Created by Enric Vergara on 20/1/17.
//  Copyright © 2017 icarvision. All rights reserved.
//


//---Imports:------
#import "IcarCloudResults_TVC.h"
#import <MessageUI/MessageUI.h>
//-----------------

@interface IcarCloudResults_TVC () <IdCloud_DataResult_Delegate, MFMailComposeViewControllerDelegate>
{
    NSString* reportString;
}

//---IBOutlets:
@property (weak, nonatomic) IBOutlet UILabel*       lbl_Side;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_Expeditor;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_Nationality;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_Name;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_Surename;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_Address;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_Birthplace;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_Birthdate;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_ExpeditionDate;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_Sex;
@property (weak, nonatomic) IBOutlet UIImageView*   img_Signature;
@property (weak, nonatomic) IBOutlet UIImageView*   img_Cut1;
@property (weak, nonatomic) IBOutlet UIImageView*   img_Cut2;
@property (weak, nonatomic) IBOutlet UIImageView*   img_Photo;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_Result;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_ResultValue;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_Warning;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_QualityImageSize;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_CompareResult;
@property (weak, nonatomic) IBOutlet UIImageView*   img_FaceDetection;

//---IBActions:
- (IBAction)backToMain:(id)sender;
@end

@implementation IcarCloudResults_TVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //First of all we check the value from IdCloud_Result.result:
    if (_idCloud_Result.result == IdCloudResult_OK)
    {
        _lbl_ResultValue.text = @"OK";
        _lbl_Warning.text = @"";
    }
    else if (_idCloud_Result.result == IdCloudResult_NOT_CORRECT)
    {
        //In case of NotCorrect we have more info in the warning field
        _lbl_ResultValue.text = @"Not Correct";
        _lbl_Warning.text = [NSString stringWithFormat:@"Warning: %@", _idCloud_Result.warning];
    }
    else if (_idCloud_Result.result == IdCloudResult_NOT_PROCESSED)
    {
        //In case of NotCorrect we have more info in the warning field
        _lbl_ResultValue.text = @"Not Processed";
        _lbl_Warning.text = [NSString stringWithFormat:@"Warning: %@", _idCloud_Result.warning];
    }
    
    [self.navigationItem setTitle:@"Show Data Results"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    NSMutableArray* array = [[NSMutableArray alloc] init];
    [array addObject:@"ImageSignature"];
    [array addObject:@"Image1cut"];
    [array addObject:@"Image2cut"];
    [array addObject:@"ImagePhoto"];
    
    //1. First we parse the xml file looking for the following images: ImageSignature, Image1cut, Image2cut and ImagePhoto.
    [_idCloud_DataResult getResultImages:array andDelegate:self];
    
    //...we will obtain the data using the delegate imagesContentDidComplete
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - IdCloud_DataResult_Delegate
- (void) fieldsContentDidComplete:(NSDictionary*)_results
{
    reportString = @"";
    for (NSString* key in _results) {
        NSString* value = [_results objectForKey:key];
        reportString = [NSString stringWithFormat:@"%@-%@: %@\n",reportString, key, value];
    }
    
    
    //4. Finally we save the values in every uilabel.
    _lbl_Side.text              = [_results objectForKey:@"SIDE"];
    _lbl_Expeditor.text         = [_results objectForKey:@"EXPEDITOR"];
    _lbl_Nationality.text       = [_results objectForKey:@"NATIONALITY"];
    _lbl_Name.text              = [_results objectForKey:@"NAME"];
    _lbl_Surename.text          = [_results objectForKey:@"SURNAME"];
    _lbl_Address.text           = [_results objectForKey:@"ADDRESS"];
    _lbl_Birthplace.text        = [_results objectForKey:@"BIRTHPLACE"];
    _lbl_Birthdate.text         = [_results objectForKey:@"BIRTHDATE"];
    _lbl_ExpeditionDate.text    = [_results objectForKey:@"EXPEDITION_DATE"];
    _lbl_Sex.text               = [_results objectForKey:@"SEX"];
    _lbl_QualityImageSize.text  = [_results objectForKey:@"QUALITY_IMAGE_SIZE"];
    
    //NSString* faceRecognitionValue = [_results objectForKey:@"TEST_FACE_RECOGNITION_VALUE"];
    NSString* faceRecognitionRatio = [_results objectForKey:@"TEST_FACE_RECOGNITION_RATIO"];
    if (faceRecognitionRatio != NULL)
    {
        float _value = [faceRecognitionRatio floatValue];
        _lbl_CompareResult.text = [NSString stringWithFormat:@"%d%%",(int)(_value*100.0f)];
        _lbl_CompareResult.hidden = NO;
    }else{
        _lbl_CompareResult.hidden = YES;
    }
    
    //5. We reload the uitableview to show the new data.
    [self.tableView reloadData];
}

- (void) imagesContentDidComplete:(NSDictionary*)_results
{
    //2. First we save the images inside every uiimageview
    if( [_results objectForKey:@"ImageSignature"] != [NSNull null])
    {
        _img_Signature.image = [_results objectForKey:@"ImageSignature"];
    }
    
    if( [_results objectForKey:@"Image1cut"] != [NSNull null])
    {
        _img_Cut1.image = [_results objectForKey:@"Image1cut"];
    }
    
    if( [_results objectForKey:@"Image2cut"] != [NSNull null])
    {
        _img_Cut2.image = [_results objectForKey:@"Image2cut"];
    }
    
    
    if( [_results objectForKey:@"ImagePhoto"]!= [NSNull null])
    {
        _img_Photo.image = [_results objectForKey:@"ImagePhoto"];
    }
    
    if(  _localImages.faceDetected!= NULL)
    {
        _lbl_CompareResult.hidden = YES;
        _lbl_CompareResult.text = @"";
        _img_FaceDetection.image = _localImages.faceDetected;
    }
    else
    {
        _lbl_CompareResult.hidden = YES;
        _img_FaceDetection.hidden = YES;
        
    }
    //3. Then we parse the xml file looking for the following fields: TYPE, SIDE, EXPEDITOR NATIONALITY, ..., SEX
    [_idCloud_DataResult getAllFields:self];
    
    //...we will obtain the data using the delegate fieldsContentDidComplete
}




- (IBAction)reportClicked:(id)sender
{
    
    if (![MFMailComposeViewController canSendMail])
    {
        NSLog(@"This device cannot send email");
        
        [self dismissViewControllerAnimated:NO completion:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"CANNOT_SEND_EMAIL",nil)
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"CONTINUE",nil)
                                              otherButtonTitles:nil, nil];
        alert.tag = 30;
        [alert show];
        
        
        return;
    }
    
    // Email Subject
    NSString *emailTitle = @"DemoSDK_iOS_ReportIdCloud";
    
    
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:reportString isHTML:NO];
    
    
    NSString * imageBase64 = [_localImages getImage_base64:0];
    
    NSData *fileData = [imageBase64 dataUsingEncoding:NSUTF8StringEncoding];
    
    // Determine the MIME type
    NSString *mimeType =  @"text/html";
    
    // Add attachment
    [mc addAttachmentData:fileData mimeType:mimeType fileName:@"localImages_base64_image1.txt"];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}


#pragma mark - MFMailComposeViewControllerDelegate
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    bool show = false;
    NSString* message_email = @"";
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            message_email = NSLocalizedString(@"EMAIL_CANCELLED",nil);
            break;
        case MFMailComposeResultSaved:
            message_email = NSLocalizedString(@"EMAIL_SAVED",nil);
            break;
        case MFMailComposeResultSent:
            show = true;
            message_email = NSLocalizedString(@"EMAIL_SENT",nil);
            break;
        case MFMailComposeResultFailed:
            message_email = [NSString stringWithFormat:NSLocalizedString(@"EMAIL_SENT_FAILURE",nil), [error localizedDescription]];
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if (show)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"ALERT", @"")
                              message:message_email
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:NSLocalizedString(@"OK", @""),nil];
        [alert show];
    }
    else
    {
        NSLog(@"%@", message_email);
    }
}

- (IBAction)backToMain:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
