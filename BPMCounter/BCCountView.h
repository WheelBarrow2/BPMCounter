//
//  BCCountView.h
//  BPMCounter
//
//  Created by Johan Lofstad on 7/7/13.
//  BPM Counter by Johan Lofstad is licensed under a Creative Commons Attribution 3.0 Unported License.
//

#import <Cocoa/Cocoa.h>
@class BCOptionsPanel;
@interface BCCountView : NSView
{
    NSDate *start;
    NSImage *logo;
    int taps;
    IBOutlet NSTextField *label;
    NSDate *lastTapDate;
    NSTimer *timer;
    IBOutlet BCOptionsPanel *optionsPanel;
    IBOutlet NSTextField *newOptions;
   
}
-(void)updateBpm;
-(IBAction)resetBpm:(id)sender;
-(IBAction)openOptions:(id)sender;
-(IBAction)closeOptions:(id)sender;
@end
