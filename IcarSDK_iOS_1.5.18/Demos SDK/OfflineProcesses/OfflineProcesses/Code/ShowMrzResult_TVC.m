//
//  ShowMrzResult_TVC.m
//  Demo IdCloud
//
//  Created by Enric Vergara on 7/4/15.
//  Copyright (c) 2015 IcarVision. All rights reserved.
//

#import "ShowMrzResult_TVC.h"

@interface ShowMrzResult_TVC ()

@end

@implementation ShowMrzResult_TVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    _lbl_fieldsIntegrity.text   = _fieldsIntegrity;
    _lbl_globalIntegrity.text   = _globalIntegrity;
    _lbl_mrzLines.text          = _mrzLines;
    _lbl_fields.text            = _fields;
    
    NSInteger _numLines = [self numLines:_mrzLines];
    if ( _numLines > 2)
    {
        UIFont *altFont = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:15.0];
        [_lbl_mrzLines setFont:altFont];
    }else{
        UIFont *altFont = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:11.0];
        [_lbl_mrzLines setFont:altFont];
    }
    
    if ([_globalIntegrity isEqualToString:@"OK"])
    {
        _lbl_globalIntegrity.textColor = [UIColor greenColor];
    }else{
        _lbl_globalIntegrity.textColor = [UIColor redColor];
    }
}

- (NSInteger) numLines:(NSString*) _lines
{
    NSScanner *mainScanner = [NSScanner scannerWithString:_lines];
    NSString *temp;
    NSInteger numberOfChar=0;
    while(![mainScanner isAtEnd])
    {
        [mainScanner scanUpToString:@"\n" intoString:&temp];
        numberOfChar++;
        [mainScanner scanString:@"\n" intoString:nil];
    }
    return numberOfChar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
