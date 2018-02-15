//
//  IcarPaymentManager.h
//  IcarSDK_IdCloud
//
//  Created by Enric Vergara on 03/11/14.
//  Copyright (c) 2014 IcarVision. All rights reserved.
//


//---Imports:--------------------
#import <Foundation/Foundation.h>
#import "IcarPayment_Result.h"
#import "IcarPayment_Configuration.h"
#import "IcarSDK_Defs.h"
//-------------------------------



#pragma mark - Delegates and notifications
//------ICAR PAYMENT DELEGATE---------
@protocol IcarPayment_Delegate <NSObject>
@required
- (void) paymentDidCancel:(IcarPayment_Result*)_result;
- (void) paymentDidComplete:(IcarPayment_Result*)_result;
@end


//-------ICAT PAYMENT MANAGER----------
@interface IcarPayment_Manager : NSObject
{}



- (int) getProcessCounter:(ICAR_CaptureProcess) _type;

- (void) buyProcess:(IcarPayment_Configuration*) _conf
        andDelegate:(id<IcarPayment_Delegate>)_delegate;

- (void) retryBuyProcess:(id<IcarPayment_Delegate>)_delegate;


- (void) returnProcesses:(IcarPayment_Configuration*) _conf
             andDelegate:(id<IcarPayment_Delegate>)_delegate;

- (void) retryReturnProcesses:(id<IcarPayment_Delegate>)_delegate;

- (void) clearLocalProcesses:(IcarPayment_Configuration*) _conf;

@end
