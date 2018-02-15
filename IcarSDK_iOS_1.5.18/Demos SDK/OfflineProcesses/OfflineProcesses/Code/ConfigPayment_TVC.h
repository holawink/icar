//
//  ConfigPayment_TVC.h
//  Demo Payment
//
//  Created by Enric Vergara on 05/11/14.
//  Copyright (c) 2014 IcarVision. All rights reserved.
//

//---Imports:------------
#import <UIKit/UIKit.h>
#import <IcarSDK/IcarSDK.h>
//-----------------------

@interface ConfigPayment_TVC : UITableViewController
{
}

//---Params:
@property (weak, nonatomic) IcarPayment_Configuration*  configuration;

//---IBOutlets:
@property (weak, nonatomic) IBOutlet UITextField*   txtf_UserName;
@property (weak, nonatomic) IBOutlet UITextField*   txtf_Password;
@property (weak, nonatomic) IBOutlet UITextField*   txtf_Company;
@property (weak, nonatomic) IBOutlet UITextField*   txtf_ServerTimeout;
@property (weak, nonatomic) IBOutlet UITextField*   txtf_Server_URL;
@property (weak, nonatomic) IBOutlet UITextField*   txtf_Server_Port;
@property (weak, nonatomic) IBOutlet UITextField*   txtf_Amount;


//---IBActions:
//...


//---Functions:

@end
