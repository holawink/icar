//--------IcarSDK---------
//
//  IcarParsedMrz.h
//
//  Version 1.0.1
//
//  Copyright (c) 2014 IcarVision.
//  All rights reserved.


//---Imports:------------
#import <UIKit/UIKit.h>
//-----------------------




@interface IcarParsedMrz: NSObject
{}

@property (nonatomic, copy) NSString*   mrzLines;
@property (nonatomic, copy) NSString*   globalIntegrity;
@property (nonatomic, copy) NSString*   fieldsIntegrity;
@property (nonatomic, copy) NSString*   fields;

- (void) resetData;

@end
