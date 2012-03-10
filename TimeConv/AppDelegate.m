//
//  AppDelegate.m
//  TimeConv
//
//  Created by Corsair Sun on 3/9/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "TimeController.h"
#import "TimeConverter.h"
#import "AppDelegate.h"

@implementation AppDelegate
{
    id TimeControl;
    id TimeConv;
}

@synthesize window;
@synthesize SrcTimeView;
@synthesize SrcTimeZoneView;
@synthesize BtnSrcZoneShort;
@synthesize DestTimeView;
@synthesize DestTimeZoneView;
@synthesize BtnDestZoneShort;
@synthesize Seperator;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSImage* BGImage = [[NSImage alloc] initWithContentsOfFile:
                        [[NSBundle mainBundle] pathForResource: @"bg" ofType: @"png"]];
    NSImage* ImageSep = [[NSImage alloc] initWithContentsOfFile:
                        [[NSBundle mainBundle] pathForResource: @"seperator" ofType: @"png"]];

    // Insert code here to initialize your application
    [[window contentView] setWantsLayer:YES];
    [[window contentView] layer].contents = BGImage;
    
    [Seperator setImageScaling: NSScaleProportionally];
    [Seperator setImage: ImageSep];
        
    TimeControl = [[TimeController alloc] init];
    TimeConv = [[TimeConverter alloc] init];
    
    [TimeControl setConverter: TimeConv];
    [TimeConv setSrcView: SrcTimeView srcZoneView: SrcTimeZoneView];
    [TimeConv setDestView: DestTimeView destZoneView: DestTimeZoneView];

    // Build timezone list
    [self onBtnSrcZoneShortClick: self];
    [self onBtnDestZoneShortClick: self];
    
    // Set default time zones
    [TimeConv setSrcZoneToLocal];
    [TimeConv setDestZoneToLocal];
    // [TimeConv setDestZoneViewWithZone: [NSTimeZone localTimeZone]];

    [SrcTimeZoneView setDelegate: TimeControl];
    [DestTimeZoneView setDelegate: TimeControl];
// TODO: get time zone working.  Move timer to controller.
    
    
    [TimeConv updateTimeSrcView];
    [TimeConv startUpdating];

    NSLog(@"Application initialized.");
}

- (IBAction)onBtnSrcZoneShortClick:(id)sender
{
    if([BtnSrcZoneShort state] == NSOnState)
    {
        [TimeControl shortSrcZone: true];
    }
    else
    {
        [TimeControl shortSrcZone: false];
    }
}

- (IBAction)onBtnDestZoneShortClick:(id)sender
{
    if([BtnDestZoneShort state] == NSOnState)
    {
        [TimeControl shortDestZone: true];
    }
    else
    {
        [TimeControl shortDestZone: false];
    }
}

- (IBAction)onZoneSrcChange:(id)sender
{
    [TimeConv setSrcZoneWithStr:
     [SrcTimeZoneView objectValueOfSelectedItem]];
}

- (IBAction)onZoneDestChange:(id)sender
{
    NSLog(@"Zone is changing to %@.", [DestTimeZoneView objectValueOfSelectedItem]);
    [TimeConv setDestZoneWithStr:
     [DestTimeZoneView objectValueOfSelectedItem]];
}
@end
