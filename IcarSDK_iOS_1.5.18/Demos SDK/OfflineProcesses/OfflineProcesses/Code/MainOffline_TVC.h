//
//  Main_TVCTableViewController.h
//  OfflineProcesses
//
//  Created by Enric Vergara on 30/3/17.
//  Copyright © 2017 icarvision. All rights reserved.
//

//---Imports:-----------
#import <UIKit/UIKit.h>
#import <IcarSDK/IcarSDK.h>
//----------------------

@interface MainOffline_TVC : UITableViewController  <IcarCapture_Delegate, IcarPayment_Delegate>
{
    IcarCapture_Configuration*  m_IcarCapture_Config;
    IcarPayment_Manager*        m_Payment_Manager;
    IcarPayment_Configuration*  m_Payment_Configuration;
    IdCloud_LocalImages*        m_IdCloud_LocalImages;
    BOOL                        m_bMRZ_Scanner;
    BOOL                        m_bPDF417_Scanner;
    BOOL                        m_bBuying;
}



//---IBOutlets:
@property (weak, nonatomic) IBOutlet UIButton*      btn_MRZScan;
@property (weak, nonatomic) IBOutlet UIButton*      btn_PDF417Scan;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_Payment_User;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_Payment_Company;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_Payment_Password;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_PaymentTimeout;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_PaymentServerURL;
@property (weak, nonatomic) IBOutlet UILabel*       lbl_PaymentServerPort;
@property (weak, nonatomic) IBOutlet UIButton*      btnChangeValues_Payment;
@property (weak, nonatomic) IBOutlet UISwitch*      switch_Vibration_MRZ;




//---IBActions:
- (IBAction)scanMRZ_Clicked:(id)sender;
- (IBAction)buyMRZ_Clicked:(id)sender;
- (IBAction)returnMRZ_Clicked:(id)sender;
- (IBAction)scanPDF417_Clicked:(id)sender;
- (IBAction)buyPDF417_Clicked:(id)sender;
- (IBAction)returnPDF417_Clicked:(id)sender;
- (IBAction)valueChanged_Vibration_MRZ:(id)sender;
@end
