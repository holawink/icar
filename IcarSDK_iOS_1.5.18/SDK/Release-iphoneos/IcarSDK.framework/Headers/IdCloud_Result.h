//
//  IdCloud_Result
//
//  Version 1.0.1
//
//  Copyright (c) 2014 IcarVision.
//  All rights reserved.


//---Imports:----------------------
#import <Foundation/Foundation.h>
//---------------------------------


//---Define new types:----------------
typedef NS_ENUM(NSInteger, IC_Result)
{
    IdCloudResult_OK            = 0,
    IdCloudResult_NOT_PROCESSED = 1,
    IdCloudResult_NOT_CORRECT   = 2,
    IdCloudResult_ERROR         = 3,
    IdCloudResult_NONE          = 4,
};

typedef NS_ENUM(NSInteger, IC_Error)
{
    IdCloudError_InvalidConfig          = 0,
    IdCloudError_InvalidImages          = 1,
    IdCloudError_InvalidXML             = 2,
    IdCloudError_InvalidJSON            = 3,
    IdCloudError_ConnectionNull         = 4,
    IdCloudError_ServerConnection       = 5,
    IdCloudError_ServerTimeOut          = 6,
    IdCloudError_InvalidIcarLicenseKey  = 7,
    IdCloudError_None                   = 8,
};
//------------------------------------



//------IDCLOUD_RESULT----------------
@interface IdCloud_Result : NSObject
{}

@property(nonatomic, assign, readwrite) IC_Result       result;
@property(nonatomic, assign, readwrite) IC_Error        error;
@property(nonatomic, copy, readwrite) NSString*         error_desc;
@property(nonatomic, copy, readwrite) NSString*         error_code;
@property(nonatomic, copy, readwrite) NSString*         warning;
@property(nonatomic, assign, readwrite) unsigned long   sizeResponse;
@property(nonatomic, assign, readwrite) unsigned long   sizeRequest;


- (id)initWithError:(IC_Error) icError;
@end
