//
//  ShowMrzResult_TVC.h
//  Demo IdCloud
//
//  Created by Enric Vergara on 7/4/15.
//  Copyright (c) 2015 IcarVision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowMrzResult_TVC : UITableViewController
{
    
}

//---Params:
@property (weak, nonatomic) NSString*  mrzLines;
@property (weak, nonatomic) NSString*  globalIntegrity;
@property (weak, nonatomic) NSString*  fieldsIntegrity;
@property (weak, nonatomic) NSString*  fields;

//---IBOutlets:
@property (weak, nonatomic) IBOutlet UILabel *lbl_mrzLines;
@property (weak, nonatomic) IBOutlet UILabel *lbl_globalIntegrity;
@property (weak, nonatomic) IBOutlet UILabel *lbl_fieldsIntegrity;
@property (weak, nonatomic) IBOutlet UILabel *lbl_fields;

@end
