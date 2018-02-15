//--------IcarSDK_Payment---------
//
//  IcarPayment_Configuration
//
//  Version 1.0.1
//
//  Copyright (c) 2014 IcarVision.
//  All rights reserved.



//----Imports:--------------------
#import <Foundation/Foundation.h>
#import "IcarSDK_Defs.h"
//--------------------------------


@interface IcarPayment_Configuration : NSObject
{}


//--Read and Write:
@property(nonatomic, copy,      readwrite)  NSString*           user;                       //default: ""
@property(nonatomic, copy,      readwrite)  NSString*           password;                   //default: ""
@property(nonatomic, copy,      readwrite)  NSString*           company;                    //default: ""
@property(nonatomic, copy,      readwrite)  NSString*           serverURL;                  //default: "http://localhost"
@property(nonatomic, copy,      readwrite)  NSString*           serverPORT;                 //default: "80"
@property(nonatomic, assign,    readwrite)  ICAR_CaptureProcess process;                    //default: CaptureProcess_NONE
@property(nonatomic, assign,    readwrite)  int                 ammount;                    //default: 0
@property(nonatomic, assign,    readwrite)  int                 server_Timeout;             //default: 20000 (milisegundos)
@property(nonatomic, copy,      readwrite)  NSString*           icarLicenseKey;             //default: ""


@end
