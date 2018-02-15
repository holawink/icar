//
//  IcarParsedPdf417.h
//  IcarSDK_IdCloud
//
//  Created by Enric Vergara on 24/8/15.
//  Copyright (c) 2015 IcarVision. All rights reserved.
//

//---Imports:------------
#import <UIKit/UIKit.h>
//-----------------------



@interface IcarParsedPdf417: NSObject
{}

@property (nonatomic, assign) BOOL      isColombia;
@property (nonatomic, assign) BOOL      allOK;

@property (nonatomic, copy) NSData*     allNSData;
@property (nonatomic, copy) NSString*   allStringData;

@property (nonatomic, copy) NSString*   custom_1;
@property (nonatomic, copy) NSString*   custom_2;
@property (nonatomic, copy) NSString*   custom_3;
@property (nonatomic, copy) NSString*   docnumber;
@property (nonatomic, copy) NSString*   surname;
@property (nonatomic, copy) NSString*   surname2;
@property (nonatomic, copy) NSString*   name;
@property (nonatomic, copy) NSString*   name2;
@property (nonatomic, copy) NSString*   sex;
@property (nonatomic, copy) NSString*   birthdate;
@property (nonatomic, copy) NSString*   custom_4;
@property (nonatomic, copy) NSString*   blood_type;


- (void) parseAllData: (NSData*) _data andString:(NSString*) _string;

- (void) resetData;

@end
