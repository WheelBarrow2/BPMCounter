//
//  BCOptionsPanel.h
//  BPMCounter
//
//  Created by Johan Lofstad on 30/10/13.
//  Copyright (c) 2013 Johan Lofstad. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BCOptionsPanel : NSPanel
{
    IBOutlet NSTextField *timeField;
    IBOutlet NSButton *enabledButton;
     NSUserDefaults *defaults;
    BOOL firstTime;
}
-(double)getTime;
-(NSInteger)getEnabled;
-(void)setTime:(double)time;
-(void)setEnabled:(NSInteger)stateToBe;
-(void)updateDefaults;
-(void)setDefaults;
-(BOOL)getFirstTime;
-(NSTextField *)getTimeField;
@end
