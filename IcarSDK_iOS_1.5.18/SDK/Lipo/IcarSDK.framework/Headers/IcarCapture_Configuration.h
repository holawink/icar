//
//  IcarCapture_Configuration.h
//  Demo_IdCloud
//
//  Created by Enric Vergara on 01/10/14.
//  Copyright (c) 2014 IcarVision. All rights reserved.
//

//---Imports:---------------------
#import <Foundation/Foundation.h>
#import "IcarSDK_Defs.h"
#import <UIKit/UIKit.h>
//--------------------------------




@interface Customized_AutoFoto : NSObject
{}

//---Properties:
@property(nonatomic, copy,      readwrite)  UIColor*    color_BackgroundLayout;
@property(nonatomic, assign,    readwrite)  float       alpha_BackgroundLayout;     //[0.0f - 1.0f]
@property(nonatomic, copy,      readwrite)  UIColor*    color_Toolbar;              //Color y transparencia del background color.
@property(nonatomic, assign,    readwrite)  float       alpha_Toolbar;              //[0.0f - 1.0f]
@property(nonatomic, copy,      readwrite)  NSString*   text_Toolbar;
@property(nonatomic, copy,      readwrite)  UIColor*    color_text_Toolbar;
@property(nonatomic, assign,    readwrite)  bool        show_HelpButton;
@property(nonatomic, assign,    readwrite)  bool        show_logoIcar;
@property(nonatomic, copy,      readwrite)  NSString*   resource_Template;
@property(nonatomic, copy,      readwrite)  NSString*   resource_btnCancel;
@property(nonatomic, assign,    readwrite)  float       time_ToDisappear_Template; //in seconds.
@property(nonatomic, assign,    readwrite)  bool        hide_detectorRectangle;


//deprectaed
@property(nonatomic, copy,      readwrite)  UIColor*    color_DetectedFrames;
@property(nonatomic, copy,      readwrite)  UIColor*    color_NotDetectedFrames;

@end


@interface IcarCapture_Configuration : NSObject
{}

@property(nonatomic, assign,    readwrite)  float       maxImageSize;                   //default: 2
@property(nonatomic, assign,    readwrite)  bool        enableVibrationMRZ;             //default: true
@property(nonatomic, assign,    readwrite)  bool        enableVibrationAutoFoto;        //default: true
@property(nonatomic, assign,    readwrite)  bool        enableVibrationFaceDetection;   //default: true

//---Config MRZ Capture:
@property(nonatomic, assign,    readwrite)  bool        enableAutoFocusOnTouch; //default: true
@property(nonatomic, assign,    readwrite)  int         mrzNumHelpView;         //default: -1. (0: never, -1: infinite)
@property(nonatomic, assign,    readwrite)  float       mrzTimerHelpView;       //defualt 3f seconds

//--Configu PDF417 Capture:
@property(nonatomic, copy,      readwrite) NSString*    pdf417LicenseKey;
@property(nonatomic, copy,      readwrite) NSString*    icarLicenseKey;

//---Config Face Detection:
@property(nonatomic, assign,    readwrite)  bool        liveness;                   //default: true
@property(nonatomic, assign,    readwrite)  bool        faceWithManualButton;       //default: false. Enable only if liveness = false

//---Config Auto Foto:
@property(nonatomic, assign,    readwrite)  bool        captureDocWithAutoFoto;     //default: true
@property(nonatomic, assign,    readwrite)  bool        autofotoWithManualButton;   //default: false. Enable only if captureDocWithAutoFoto = true
@property(nonatomic, copy,      readwrite)  Customized_AutoFoto*    customized_AutoFoto;



//--Read and Write:
@property(nonatomic, assign, readwrite)  BOOL    videoMode;      //default: NO

- (BOOL) isVideoMode;
- (void) setInternalProcess:(ICAR_CaptureProcess) internalProcess;
- (ICAR_CaptureProcess) getInternalProcess;


@end
