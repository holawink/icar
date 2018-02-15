//--------IcarSDK_Capture---------
//
//  IdCloud_Configuration
//
//  Version 1.0.1
//
//  Copyright (c) 2014 IcarVision.
//  All rights reserved.


//---Imports:------------------------
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//-----------------------------------

@interface IdCloud_Configuration : NSObject
{}


//--Read and Write:
@property(nonatomic, copy,      readwrite)  NSString*   server_Port;            //default: ""
@property(nonatomic, copy,      readwrite)  NSString*   server_URL;             //default: ""
@property(nonatomic, assign,    readwrite)  int         server_Timeout;         //default: 60000 (miliseconds)
@property(nonatomic, copy,      readwrite)  NSString*   user;                   //default: ""
@property(nonatomic, copy,      readwrite)  NSString*   password;               //default: ""
@property(nonatomic, copy,      readwrite)  NSString*   company;                //default: ""

//---Extra info
@property(nonatomic, copy,      readwrite)  NSString*   icarProperties;         //default: ""
@property(nonatomic, copy,      readwrite)  NSString*   icarProperties_Image;   //default: ""
@property(nonatomic, copy,      readwrite)  NSString*   icarFaceValidation;     //default: ""
@property(nonatomic, copy,      readwrite)  NSString*   emailToCheck;           //default: ""
@property(nonatomic, copy,      readwrite)  NSString*   phoneNumberToCheck;     //default: ""

@property(nonatomic, copy,      readwrite)  NSString*   icarLicenseKey;         //default: ""

//--Read only:
@property(nonatomic, copy,      readonly)   NSString*   version;                //IdCloud Library Version:




- (void) setFaceValidation:(UIImage*)image;
+ (NSString*) getSdkVersion;

@end
