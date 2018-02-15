//
//  IdCloud_LocalImages
//
//  Version 1.0.1
//
//  Copyright (c) 2014 IcarVision.
//  All rights reserved.


//---Imports:-------------------------
#import <Foundation/Foundation.h>
#import "IcarCapture_Configuration.h"
#import "IdCloud_Configuration.h"
#import "IcarParsedMrz.h"
#import "IcarParsedPdf417.h"
#import <UIKit/UIKit.h>
//------------------------------------


@interface IdCloud_LocalImages : NSObject
{}

//---Properties:
@property (nonatomic, strong) IcarParsedMrz*    parsedMRZ;
@property (nonatomic, strong) IcarParsedPdf417* parsedPDF417;
@property (nonatomic, strong) UIImage*          faceDetected;

//---Functions:

- (NSString*)   getImage_base64:(int) _imgPos;

- (UIImage*)    getImage:(int) _imgPos;

- (BOOL)        setImage: (UIImage*)_img
                withConf:(IcarCapture_Configuration*) _config
                  andPos:(int) _imgPos;

- (int)         getNumLoadedImages;

- (BOOL)        removeImage: (int) _pos;

- (NSString*)   getDeviceInfo:(int) _imgPos
                     withConf:(IdCloud_Configuration*) _conf;



@end
