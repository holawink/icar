//
//  IcarSDK_Defs.h
//  IcarSDK_IdCloud
//
//  Created by Enric Vergara on 24/11/14.
//  Copyright (c) 2014 IcarVision. All rights reserved.
//

#ifndef IcarSDK_IdCloud_IcarSDK_Defs_h
#define IcarSDK_IdCloud_IcarSDK_Defs_h


//---Define new types:----------------
typedef NS_ENUM(NSInteger, ICAR_CaptureProcess)
{
    CaptureProcess_CAPTURE_IMAGE            = 0,
    CaptureProcess_CAPTURE_MRZ              = 1,
    CaptureProcess_CAPTURE_PDF417           = 2,
    CaptureProcess_CAPTURE_FACE_DETECTION   = 3,
    CaptureProcess_CAPTURE_CREDIT_CARD      = 4,
    CaptureProcess_NONE                     = 5
};
//------------------------------------

//---Define new types:----------------
typedef NS_ENUM(NSInteger, ICAR_CaptureResult)
{
    CaptureResult_CANCELED_BY_USER          = 0,
    CaptureResult_NO_CREDIT                 = 1,
    CaptureResult_ERROR                     = 2,
    CaptureResult_LICENSE_PDF417_ERROR      = 3,
    CaptureResult_INVALID_ICAR_LICENSE_KEY  = 4,
    CaptureResult_INVALID_PROCESS           = 5,
};
//------------------------------------

#endif
