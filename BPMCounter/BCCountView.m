//
//  BCCountView.m
//  BPMCounter
//
//  Created by Johan Lofstad on 7/7/13.
//  BPM Counter by Johan Lofstad is licensed under a Creative Commons Attribution 3.0 Unported License.
//

#import "BCCountView.h"
#import "BCOptionsPanel.h"

@implementation BCCountView
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if(!logo){
           logo = [NSImage imageNamed:@"bpm.png"];
        }
        taps = 0;
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor clearColor]set];
    [NSBezierPath fillRect:[self bounds]];
    NSRect imageRect;
    imageRect.origin = NSZeroPoint;
    imageRect.size = [logo size];
    NSRect drawingRect = [self bounds];
    [logo drawInRect:drawingRect
            fromRect:imageRect
           operation:NSCompositeSourceOver
            fraction:1];
    return;
}
#pragma mark First Responder Methods

- (BOOL)acceptsFirstResponder
{
	return YES;
}
- (BOOL)resignFirstResponder
{
	return NO;
}
- (BOOL)becomeFirstResponder
{
    [optionsPanel setDefaults];
    if([optionsPanel getFirstTime] == NO){
        [newOptions setStringValue:@""];
    }
    [self setNeedsDisplay:YES];
    return YES;
}
#pragma mark keyboard events
-(void)keyDown:(NSEvent *)theEvent{
    taps++;
    [self updateBpm];
    if(!timer && [optionsPanel getEnabled]==YES){
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                 target:self
                                               selector:@selector(resetBpmTimeMeth)
                                               userInfo:nil
                                                repeats:YES];
        [timer fire];
    }
    return;
}
#pragma mark BPM Controller
-(void)updateBpm{
    NSDate *now = [NSDate date];
    lastTapDate = now;
    if(taps==1){
        [label setStringValue:@"First tap"];
        return;
    }
    if(!start){
        start = [NSDate date];
    }
    
    NSTimeInterval interval = [now timeIntervalSinceDate:start]+1;
    float bpm;
    bpm = (60*taps)/interval;
    [label setFloatValue:bpm];
    return;
}
-(IBAction)resetBpm:(id)sender{
    start = nil;
    taps = 0;
    [label setStringValue:@"Tap to start!"];
    return;
}
-(void)resetBpmTimeMeth{
    NSDate *now = [NSDate date];
    NSTimeInterval interval = [now timeIntervalSinceDate:lastTapDate];
    if(interval >= [optionsPanel getTime]){
        [self resetBpm:self];
        [timer invalidate];
        timer = nil;
    }
}
-(IBAction)openOptions:(id)sender{
    [NSApp beginSheet:optionsPanel modalForWindow:(NSWindow *)_window modalDelegate:self didEndSelector:nil contextInfo:nil];
}
-(IBAction)closeOptions:(id)sender{
    if((![self isNumericTextField:[[optionsPanel getTimeField] stringValue]]||([[optionsPanel getTimeField] floatValue]==0))){
        NSAlert *wrongInput = [NSAlert alertWithMessageText:@"Invalid input" defaultButton:@"ok" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Please enter an integer greater than zero"];
        [wrongInput runModal];
        return;
    }
    [newOptions setStringValue:@""];
    [optionsPanel updateDefaults];
    [NSApp endSheet:optionsPanel];
    [optionsPanel orderOut:sender];
    if([optionsPanel getEnabled]==YES){
        if(!timer && [optionsPanel getEnabled]==YES){
            NSDate *now = [NSDate date];
            lastTapDate = now;
            timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                     target:self
                                                   selector:@selector(resetBpmTimeMeth)
                                                   userInfo:nil
                                                    repeats:YES];
            [timer fire];
        }
    }
}
-(BOOL)isNumericTextField:(NSString *)string{
    
    //Returns TRUE if numeric
    
    BOOL valid;
    
    
    NSCharacterSet *okchars = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    NSCharacterSet *stringsFromField = [NSCharacterSet characterSetWithCharactersInString:string];
    valid = [okchars isSupersetOfSet:stringsFromField];
    
    return valid;
    
}
@end
