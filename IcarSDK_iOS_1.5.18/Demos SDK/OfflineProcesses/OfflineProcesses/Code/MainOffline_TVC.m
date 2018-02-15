//
//  Main_TVCTableViewController.m
//  OfflineProcesses
//
//  Created by Enric Vergara on 30/3/17.
//  Copyright © 2017 icarvision. All rights reserved.
//

//---Imports:--------
#import "MainOffline_TVC.h"
#import "DemoSDK_Constants.h"
#import "ConfigPayment_TVC.h"
#import "ShowMrzResult_TVC.h"
//---Imports:--------


@interface MainOffline_TVC ()
{
    UIAlertController * m_AlertView;
}
@end

@implementation MainOffline_TVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    m_Payment_Manager           = [[IcarPayment_Manager alloc] init];
    m_Payment_Configuration     = [[IcarPayment_Configuration alloc] init];
    m_IdCloud_LocalImages       = [[IdCloud_LocalImages alloc] init];
    
    m_Payment_Configuration.user            = DemoSDK_Payment_User;
    m_Payment_Configuration.password        = DemoSDK_Payment_Password;
    m_Payment_Configuration.company         = DemoSDK_Payment_Company;
    m_Payment_Configuration.server_Timeout  = 20000; //20 seconds
    m_Payment_Configuration.icarLicenseKey  = icarLicenseKey;
    m_Payment_Configuration.ammount         = 1;
    
    m_bMRZ_Scanner      = NO;
    m_bPDF417_Scanner   = NO;
    
    self.navigationItem.title = [NSString stringWithFormat:@"Sample OfflineProcesses (IcarVision sdk %@)",[IdCloud_Configuration getSdkVersion]];
    
    m_IcarCapture_Config = [[IcarCapture_Configuration alloc] init];
    m_IcarCapture_Config.icarLicenseKey = icarLicenseKey;
    
    
    
    // If you do not want to make an adjustment to the captured image, you can assign the following value to -1:
    //m_IcarCapture_Config.maxImageSize = -1;
    
    
    
    
    //NSString* pdf417_default_key    = @"U5IAZRYS-JGIUGFT5-YTM2RZTP-QENMGXOR-P5HOEVU3-UZNN4GJR-DLBV3UL7-J3RAOBU3";
    //NSString* pdf417_default_date   = @"1-12-2015";
    //[m_IdCloud_Connection synchronizePDF417WithKey:pdf417_default_key andDate:pdf417_default_date];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
    //Every time we return from the ViewController we must refresh all pucrchases
    IcarPayment_Manager* paymentManager = [[IcarPayment_Manager alloc] init];
    int counter_MRZ = [paymentManager getProcessCounter:CaptureProcess_CAPTURE_MRZ];
    [_btn_MRZScan setTitle:[NSString stringWithFormat:@"MRZ Scan (%d)",counter_MRZ] forState:UIControlStateNormal];
    
    int counter_PDF417 = [paymentManager getProcessCounter:CaptureProcess_CAPTURE_PDF417];
    [_btn_PDF417Scan setTitle:[NSString stringWithFormat:@"PDF417 Scan (%d)",counter_PDF417] forState:UIControlStateNormal];
    
    //Every time we return from the ViewController named ShowDataResult_TVC, we must refresh the labels with IdCloud_Configuration:
    _lbl_Payment_User.text      = [NSString stringWithFormat:@"User: %@",m_Payment_Configuration.user];
    _lbl_Payment_Company.text   = [NSString stringWithFormat:@"Company: %@",m_Payment_Configuration.company];
    _lbl_Payment_Password.text  = [NSString stringWithFormat:@"Password: %@",m_Payment_Configuration.password];
    _lbl_PaymentTimeout.text    = [NSString stringWithFormat:@"Server Timeout: %d", m_Payment_Configuration.server_Timeout];
    _lbl_PaymentServerURL.text  = [NSString stringWithFormat:@"Server URL: %@", m_Payment_Configuration.serverURL];
    _lbl_PaymentServerPort.text = [NSString stringWithFormat:@"Server Port: %@", m_Payment_Configuration.serverPORT];
    
    
    [_switch_Vibration_MRZ setOn:m_IcarCapture_Config.enableVibrationMRZ];
    [_btnChangeValues_Payment setTitle:[NSString stringWithFormat:@"Change Values (%d)",m_Payment_Configuration.ammount] forState:UIControlStateNormal];
    
}


- (IBAction)scanMRZ_Clicked:(id)sender
{
    
    m_bMRZ_Scanner = true;
    [m_IcarCapture_Config setInternalProcess:CaptureProcess_CAPTURE_MRZ];
    //First of all we show the custom view controller IcarCapture_VC to capture the image from  device camera.
    IcarCapture_VC* vc = [[IcarCapture_VC alloc] initWithDelegate:self
                                                 andConfiguration:m_IcarCapture_Config
                                                    andLocalImage:m_IdCloud_LocalImages
                                                      andPosImage:0];
    
    
    
    //We need to use a custom UINavigationController named IcarCapture_NC to present the view controller IcarCapture_VC.
    IcarCapture_NC *nav = [[IcarCapture_NC alloc] init];
    [nav setViewControllers:[NSArray arrayWithObjects:vc, nil]];
    [self presentViewController:nav animated:NO completion:nil];
    
}


- (IBAction)buyMRZ_Clicked:(id)sender
{
    m_bBuying = YES;
    [self showProgress];
    m_Payment_Configuration.process          = CaptureProcess_CAPTURE_MRZ;
    m_Payment_Configuration.server_Timeout   = 20000;
    
    [m_Payment_Manager buyProcess:m_Payment_Configuration andDelegate:self];
}


- (IBAction)returnMRZ_Clicked:(id)sender
{
    m_bBuying = NO;
    [self showProgress];
    m_Payment_Configuration.process          = CaptureProcess_CAPTURE_MRZ;
    m_Payment_Configuration.server_Timeout   = 20000;
    
    [m_Payment_Manager returnProcesses:m_Payment_Configuration andDelegate:self];
}


- (IBAction)scanPDF417_Clicked:(id)sender
{
    m_bPDF417_Scanner = true;
    [m_IcarCapture_Config setInternalProcess:CaptureProcess_CAPTURE_PDF417];
    //First of all we show the custom view controller IcarCapture_VC to capture the image from  device camera.
    IcarCapture_VC* vc = [[IcarCapture_VC alloc] initWithDelegate:self
                                                 andConfiguration:m_IcarCapture_Config
                                                    andLocalImage:m_IdCloud_LocalImages
                                                      andPosImage:0];
    
    
    
    //We need to use a custom UINavigationController named IcarCapture_NC to present the view controller IcarCapture_VC.
    IcarCapture_NC *nav = [[IcarCapture_NC alloc] init];
    [nav setViewControllers:[NSArray arrayWithObjects:vc, nil]];
    [self presentViewController:nav animated:NO completion:nil];
}



- (IBAction)buyPDF417_Clicked:(id)sender
{
    m_bBuying = YES;
    [self showProgress];
    m_Payment_Configuration.process          = CaptureProcess_CAPTURE_PDF417;
    m_Payment_Configuration.server_Timeout   = 20000;
    
    [m_Payment_Manager buyProcess:m_Payment_Configuration andDelegate:self];
}

- (IBAction)returnPDF417_Clicked:(id)sender
{
    m_bBuying = NO;
    [self showProgress];
    m_Payment_Configuration.process          = CaptureProcess_CAPTURE_PDF417;
    m_Payment_Configuration.server_Timeout   = 20000;
    
    
}

- (IBAction)valueChanged_Vibration_MRZ:(id)sender {
    m_IcarCapture_Config.enableVibrationMRZ = _switch_Vibration_MRZ.isOn;
}



//---Auxiliar funcitinos to show and hide loading info
- (void) hideProgress
{
    
    [m_AlertView dismissViewControllerAnimated:YES completion:nil];
}

- (void) showProgress
{
    
    
    m_AlertView = [UIAlertController
                   alertControllerWithTitle:@"Connecting to Icar Server..."
                   message:@""
                   preferredStyle:UIAlertControllerStyleAlert];

    
    
    UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.color = [UIColor blackColor];
    indicator.translatesAutoresizingMaskIntoConstraints=NO;
    [m_AlertView.view addSubview:indicator];
    NSDictionary * views = @{@"pending" : m_AlertView.view, @"indicator" : indicator};
    
    NSArray * constraintsVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[indicator]-(20)-|" options:0 metrics:nil views:views];
    NSArray * constraintsHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[indicator]|" options:0 metrics:nil views:views];
    NSArray * constraints = [constraintsVertical arrayByAddingObjectsFromArray:constraintsHorizontal];
    [m_AlertView.view addConstraints:constraints];
    [indicator setUserInteractionEnabled:NO];
    [indicator startAnimating];
    [self presentViewController:m_AlertView animated:YES completion:nil];
}




#pragma mark - IcarCapture_Delegate
- (void) captureDidCancel:(ICAR_CaptureResult) _result;
{
    BOOL dismiss = NO;
    BOOL showDialog = NO;
    NSString* errorMsg = @"Unknown error";
    //Once we finish the process from IcarCapture, it's very important to call the function dismissViewControllerAnimated
    //this way we can hide the custom view controller IcarCapture_VC
    if (_result == CaptureResult_CANCELED_BY_USER)
    {
        m_bMRZ_Scanner = false;
        m_bPDF417_Scanner = false;
        dismiss = YES;
        showDialog = NO;
    }
    else if (_result == CaptureResult_ERROR)
    {
        if (m_bPDF417_Scanner)
        {
            m_bPDF417_Scanner = false;
            errorMsg = @"PDF417 License Error!";
            dismiss = NO;
            showDialog = NO;
        }
    }
    else if (_result == CaptureResult_NO_CREDIT)
    {
        m_bMRZ_Scanner = false;
        m_bPDF417_Scanner = false;
        dismiss = NO;
        showDialog = NO;
    }
    else if (_result == CaptureResult_LICENSE_PDF417_ERROR)
    {
        m_bPDF417_Scanner = false;
        dismiss = YES;
        showDialog = YES;
        errorMsg = @"ICAR_CaptureResult = CaptureResult_LICENSE_PDF417_ERROR";
    }
    else if (_result == CaptureResult_INVALID_ICAR_LICENSE_KEY)
    {
        dismiss = YES;
        showDialog = YES;
        errorMsg = @"ICAR_CaptureResult = CaptureResult_INVALID_ICAR_LICENSE_KEY";
    }
    else if (_result == CaptureResult_INVALID_PROCESS)
    {
        dismiss = YES;
        showDialog = YES;
        errorMsg = @"ICAR_CaptureResult = CaptureResult_INVALID_PROCESS";
    }
    
    
    
    if (dismiss)
    {
        [self dismissViewControllerAnimated:YES completion:^{
            if (showDialog)
                [self showMsg:errorMsg withTitle:@"Capture Did Cancel"];
        }];
    }
    else if (showDialog){
        [self showMsg:errorMsg withTitle:@"Capture Did Cancel"];
    }
    
}

- (void) showMsg:(NSString*) msg withTitle:(NSString*) title
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:msg
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction* btnContinue = [UIAlertAction
                                  actionWithTitle:@"Continue"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action) {
                                      //Handle your yes please button action here
                                  }];
    
    
    [alert addAction:btnContinue];
    
    [self presentViewController:alert animated:YES completion:nil];

}

- (void) captureDidComplete
{
    //It's very important once we receive the image from the IcarCapture_VC to call the funcion dismissViewControllerAnimated
    [self dismissViewControllerAnimated:NO completion:^{
        [self processCaptureComplete];
    }];
}

- (void) processCaptureComplete
{
    if (m_bMRZ_Scanner)
    {
        m_bMRZ_Scanner = false;
        
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"MRZ:"
                                     message:m_IdCloud_LocalImages.parsedMRZ.mrzLines
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        UIAlertAction* btnContinue = [UIAlertAction
                                    actionWithTitle:@"Continue"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        
        UIAlertAction* btnViewInfo = [UIAlertAction
                                   actionWithTitle:@"View Info"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       NSLog(@"You have clicked View More info");
                                       [self performSegueWithIdentifier:@"ShowMrzResult" sender:nil];

                                   }];
        
        [alert addAction:btnContinue];
        [alert addAction:btnViewInfo];
        
        [self presentViewController:alert animated:YES completion:nil];
        
            }
    else if (m_bPDF417_Scanner)
    {
        m_bPDF417_Scanner = false;
        
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"PDF417:"
                                     message:m_IdCloud_LocalImages.parsedPDF417.allStringData
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        UIAlertAction* btnContinue = [UIAlertAction
                                      actionWithTitle:@"Continue"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action) {
                                          //Handle your yes please button action here
                                      }];
        
        [alert addAction:btnContinue];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}



#pragma IcarPayment_Delegate
- (void) paymentDidCancel:(IcarPayment_Result*)_result
{
    [self hideProgress];
    
    NSString* errorTitle    = @"";
    NSString* errorMesg     = @"";
    
    switch (_result.error)
    {
        case PaymentError_ConnectionNull:
            errorTitle = @"Error: Connection Null";
            break;
            
        case PaymentError_InvalidConfig:
            errorTitle = @"Error: Invalid Configuration";
            break;
            
        case PaymentError_ServerConnection:
            errorTitle = @"Error: Server Connection";
            errorMesg = _result.error_desc;
            break;
            
        case PaymentError_LastPurchasedCompleted:
            errorTitle = @"Error: Last Purchased Completed";
            errorMesg = _result.error_desc;
            break;
            
        case PaymentError_InvalidIcarLicenseKey:
            errorTitle = @"Error: Ivalid Icar License Key";
            errorMesg = _result.error_desc;
            break;
            
        default:
            break;
    }
    
    IcarPayment_Manager* paymentManager = [[IcarPayment_Manager alloc] init];
    int counter_MRZ = [paymentManager getProcessCounter:CaptureProcess_CAPTURE_MRZ];
    [_btn_MRZScan setTitle:[NSString stringWithFormat:@"MRZ Scan (%d)",counter_MRZ] forState:UIControlStateNormal];
    
    int counter_PDF417 = [paymentManager getProcessCounter:CaptureProcess_CAPTURE_PDF417];
    [_btn_PDF417Scan setTitle:[NSString stringWithFormat:@"PDF417 Scan (%d)",counter_PDF417] forState:UIControlStateNormal];
    
    
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:errorTitle
                                 message:errorMesg
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction* btnContinue = [UIAlertAction
                                  actionWithTitle:@"Continue"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action) {
                                      //Handle your yes please button action here
                                  }];

    
    UIAlertAction* btnRetry = [UIAlertAction
                                  actionWithTitle:@"Retry"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action) {
                                      if (m_bBuying==true)
                                      {
                                          [m_Payment_Manager retryBuyProcess:self];
                                      }
                                      else
                                      {
                                          [m_Payment_Manager retryReturnProcesses:self];
                                      }
                                  }];

    [alert addAction:btnContinue];
    [alert addAction:btnRetry];
    
    [self presentViewController:alert animated:YES completion:nil];
}



- (void) paymentDidComplete:(IcarPayment_Result*)_result
{
    [self hideProgress];
    IcarPayment_Manager* paymentManager = [[IcarPayment_Manager alloc] init];
    int counter_MRZ = [paymentManager getProcessCounter:CaptureProcess_CAPTURE_MRZ];
    [_btn_MRZScan setTitle:[NSString stringWithFormat:@"MRZ Scan (%d)",counter_MRZ] forState:UIControlStateNormal];
    
    int counter_PDF417 = [paymentManager getProcessCounter:CaptureProcess_CAPTURE_PDF417];
    [_btn_PDF417Scan setTitle:[NSString stringWithFormat:@"PDF417 Scan (%d)",counter_PDF417] forState:UIControlStateNormal];
}



#pragma mark - Table view data source

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FromMainToConfigPaymentServer"])
    {
        ConfigPayment_TVC* _vc = [segue destinationViewController];
        _vc.configuration = m_Payment_Configuration;
    }
    else if ([[segue identifier] isEqualToString:@"ShowMrzResult"])
    {
        ShowMrzResult_TVC* _vc = [segue destinationViewController];
        
        _vc.mrzLines = m_IdCloud_LocalImages.parsedMRZ.mrzLines;
        _vc.globalIntegrity = m_IdCloud_LocalImages.parsedMRZ.globalIntegrity;
        _vc.fieldsIntegrity = m_IdCloud_LocalImages.parsedMRZ.fieldsIntegrity;
        _vc.fields = m_IdCloud_LocalImages.parsedMRZ.fields;
    }
    
}

@end
