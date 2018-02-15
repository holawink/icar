//
//  IcarCloudResults_TVC.h
//  CaptureAndSend
//
//  Created by Enric Vergara on 20/1/17.
//  Copyright © 2017 icarvision. All rights reserved.
//

//---Imports:------
#import <UIKit/UIKit.h>
#import <IcarSDK/IcarSDK.h>
//-----------------

@interface IcarCloudResults_TVC : UITableViewController 

@property (weak, nonatomic) IdCloud_DataResult*     idCloud_DataResult;
@property (weak, nonatomic) IdCloud_Result*         idCloud_Result;
@property (weak, nonatomic) IdCloud_LocalImages*    localImages;


@end
