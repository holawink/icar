//
//  ShowSelfie_VC.h
//  CaptureAndSend
//
//  Created by Enric Vergara on 20/1/17.
//  Copyright © 2017 icarvision. All rights reserved.
//

//---Imports:------
#import <UIKit/UIKit.h>
#import <IcarSDK/IcarSDK.h>
//-----------------

@interface ShowSelfie_VC : UIViewController


@property (nonatomic, strong) IdCloud_LocalImages*          localImages;
@property (nonatomic, strong) IcarCapture_Configuration*    captureConfig;

@end
