//
//  IdCloud_DataResult
//
//  Version 1.0.1
//
//  Copyright (c) 2014 IcarVision.
//  All rights reserved.


//-----Imports:--------------------
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//---------------------------------




#pragma mark - Delegates and notifications (IdCloud_DataResult_Delegate)
//----------------IDCLOUD CONNECTION DELEGATE--------------------
@protocol IdCloud_DataResult_Delegate <NSObject>
@optional
- (void) fieldsContentDidComplete:(NSDictionary*)_results;
- (void) imagesContentDidComplete:(NSDictionary*)_results;
- (void) imagesContentDidCancel:(NSString*)_errorDesc;
- (void) fieldsContentDidCancel:(NSString*)_errorDesc;
@end


#pragma mark - IdCloud_DataResult
//----------------IDCLOUD_ DATA RESULT------------------------
@interface IdCloud_DataResult : NSObject
{}



//---Properties:
@property (nonatomic, copy) NSString*   xml;
@property (nonatomic, copy) NSData*     xmlData;
@property (nonatomic, copy) NSString*   result;


//---Functions:-------------------------------------------------
- (void) getAllFields:(id<IdCloud_DataResult_Delegate>) _delegate;

- (void) getFieldsContent:(NSArray*)_codes
              andDelegate:(id<IdCloud_DataResult_Delegate>) _delegate;

- (void) getResultImages:(NSArray*)_codes
             andDelegate:(id<IdCloud_DataResult_Delegate>) _delegate;
@end
//--------------------------------------------------------------








