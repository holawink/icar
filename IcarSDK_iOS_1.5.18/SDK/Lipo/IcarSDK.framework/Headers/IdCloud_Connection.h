//--------IcarSDK_Capture---------
//
//  IdCloud_Connection
//
//  Version 1.0.1
//
//  Copyright (c) 2014 IcarVision.
//  All rights reserved.



//----Imports:--------------------
#import <Foundation/Foundation.h>
#import "IdCloud_Configuration.h"
#import "IdCloud_LocalImages.h"
#import "IdCloud_DataResult.h"
#import "IdCloud_Result.h"
//--------------------------------



#pragma mark - Delegates and notifications
//----------------IDCLOUD CONNECTION DELEGATE--------------------
@protocol IdCloud_Connection_Delegate <NSObject>
@required
- (void) connectionDidCancel:(IdCloud_Result*)_result;
- (void) connectionDidComplete:(IdCloud_Result*)_result;
@end



#pragma mark - IdCloud_Connection
//----------------------------------------------------------------
//-----------------------IDCLOUD CONNECTION-----------------------
@interface IdCloud_Connection : NSObject
{}


//---Functions:
- (void) processIdCloudWithConf:(IdCloud_Configuration*)_config
                         images:(IdCloud_LocalImages*) _images
                       delegate:(id<IdCloud_Connection_Delegate>)_delegate
                  andDataResult:(IdCloud_DataResult*)_dataResult;

- (void) checkIdCloudWithConf:(IdCloud_Configuration*)_config
                     delegate:(id<IdCloud_Connection_Delegate>)_delegate;


- (void) synchronizePDF417WithKey:(NSString*) key andDate:(NSString*) date;

+ (NSString*) xmlDeviceInfo:(int) deviceInfo
             andResolutionX:(int)resX
             andResolutionY:(int)resY
              andPDF417Data:(NSArray*)_data
            andFaceAttached:(BOOL) _faceAttached
             andIdCloudConf:(IdCloud_Configuration*)cloud_conf;


@end
