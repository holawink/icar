//
//  ConfigPayment_TVC.m
//  Demo Payment
//
//  Created by Enric Vergara on 05/11/14.
//  Copyright (c) 2014 IcarVision. All rights reserved.
//

#import "ConfigPayment_TVC.h"

@interface ConfigPayment_TVC ()

@end

@implementation ConfigPayment_TVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _txtf_Company.text          = _configuration.company;
    _txtf_Password.text         = _configuration.password;
    _txtf_ServerTimeout.text    = [NSString stringWithFormat:@"%d",_configuration.server_Timeout];
    _txtf_UserName.text         = _configuration.user;
    _txtf_Server_URL.text       = _configuration.serverURL;
    _txtf_Server_Port.text      = _configuration.serverPORT;
    _txtf_Amount.text           = [NSString stringWithFormat:@"%d", _configuration.ammount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidDisappear:(BOOL)animated
{
    
    //Before disappear we save the data from every uilabel in IdCloud_Configuration.
    _configuration.company              = _txtf_Company.text;
    _configuration.user                 = _txtf_UserName.text;
    _configuration.password             = _txtf_Password.text;
    _configuration.serverURL            = _txtf_Server_URL.text;
    _configuration.serverPORT           = _txtf_Server_Port.text;
    _configuration.server_Timeout       = [_txtf_ServerTimeout.text intValue];
    _configuration.ammount              = [_txtf_Amount.text intValue];
    
    [super viewDidDisappear:animated];
}


/*
 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
*/

@end
