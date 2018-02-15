//
//  IcarPayment_Result.h
//  IcarSDK_IdCloud
//
//  Created by Enric Vergara on 03/11/14.
//  Copyright (c) 2014 IcarVision. All rights reserved.
//


//---Imports:-------------------------
#import <Foundation/Foundation.h>
//------------------------------------


//---Define new types:----------------
typedef NS_ENUM(NSInteger, IP_Result)
{
    PaymentResult_BOUGHT        = 0,
    PaymentResult_ERROR         = 1,
    PaymentResult_NONE          = 2,
};

typedef NS_ENUM(NSInteger, IP_Error)
{
    PaymentError_InvalidConfig          = 0,
    PaymentError_InvalidAmmount         = 1,
    PaymentError_ConnectionNull         = 2,
    PaymentError_ServerConnection       = 3,
    PaymentError_LastPurchasedCompleted = 4,
    PaymentError_LastReturnCompleted    = 5,
    PaymentError_InvalidIcarLicenseKey  = 6,
    PaymentError_None                   = 7,
};
//------------------------------------



//------ICAR PAYMENT RESULT----------------
@interface IcarPayment_Result : NSObject
{}

@property(nonatomic, assign, readwrite) IP_Result   result;
@property(nonatomic, assign, readwrite) IP_Error    error;
@property(nonatomic, copy,  readwrite) NSString*    error_desc;
@property(nonatomic, assign,  readwrite) int        error_code;


@end
