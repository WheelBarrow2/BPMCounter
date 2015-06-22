//
//  BCOptionsPanel.m
//  BPMCounter
//
//  Created by Johan Lofstad on 30/10/13.
//  Copyright (c) 2013 Johan Lofstad. All rights reserved.
//

#import "BCOptionsPanel.h"

@implementation BCOptionsPanel
-(id)init{
    self = [super init];
    if(self){
        
    }
    return self;
}
-(double)getTime{
    return [timeField doubleValue];
}
-(NSInteger)getEnabled{
    return [enabledButton state];
}
-(void)setTime:(double)time{
    [timeField setDoubleValue:time];
}
-(void)setEnabled:(NSInteger)stateToBe{
    [enabledButton setState:stateToBe];
}
-(void)setDefaults{
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    if(![defaults objectForKey:@"resetTime"]){
        [defaults setObject:[NSNumber numberWithDouble:4] forKey:@"resetTime"];
        [self setTime:4];
    }
    else{
        [self setTime:[[defaults objectForKey:@"resetTime"] doubleValue]];
    }
    if(![defaults objectForKey:@"isTimerEnabled"]){
        [defaults setObject:[NSNumber numberWithInteger:1] forKey:@"isTimerEnabled"];
        [self setEnabled:1];
    }
    else{
        [self setEnabled:[[defaults objectForKey:@"isTimerEnabled"] boolValue]];
    }
    if(![defaults objectForKey:@"firstTime"]){
        [defaults setObject:[NSNumber numberWithBool:YES] forKey:@"firstTime"];
        firstTime = YES;
    }
    else{
        firstTime = NO;
    }
    [defaults synchronize];
}
-(void)updateDefaults{
    [defaults setObject:[NSNumber numberWithDouble:[self getTime]] forKey:@"resetTime"];
    [defaults setObject:[NSNumber numberWithInteger:[self getEnabled]] forKey:@"isTimerEnabled"];
    [defaults synchronize];
    
}
-(BOOL)getFirstTime{
    return firstTime;
}
-(NSTextField *)getTimeField{
    return timeField;
}
@end
