//--------IcarSDK---------
//
//  IcarCapture_VC
//
//  Version 1.0.1
//
//  Copyright (c) 2014 IcarVision.
//  All rights reserved.


//---Imports:------------
#import <UIKit/UIKit.h>
#import "IdCloud_Configuration.h"
#import "IdCloud_LocalImages.h"
#import "IcarSDK_Defs.h"
//-----------------------




#pragma mark - Delegates and notifications
@protocol IcarCapture_Delegate <NSObject>
@required
- (void) captureDidCancel:(ICAR_CaptureResult) _result;
- (void) captureDidComplete;

@end




//-----ICAR CAPTURE VC----------------------
@interface IcarCapture_VC : UIViewController
{}

- (id)initWithDelegate:(id<IcarCapture_Delegate>)_delegate
      andConfiguration:(IcarCapture_Configuration*) _conf
         andLocalImage:(IdCloud_LocalImages*)_images
           andPosImage:(int) _imgPos;



@end
