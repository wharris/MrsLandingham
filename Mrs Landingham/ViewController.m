//
//  ViewController.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 15/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//


#import "ViewController.h"
#import "WatchConnectivity/WatchConnectivity.h"
#import <AudioToolbox/AudioToolbox.h>
@interface ViewController ()

@end

@implementation ViewController





NSString *counterValue;

WCSession *session;
SystemSoundID sound1;

- (void)viewDidLoad {
    [super viewDidLoad];
   self.display.text = @"Hope";
    if ([WCSession isSupported]) {
        session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    counterValue=@"start";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary *)message replyHandler:(nonnull void (^)(NSDictionary * __nonnull))replyHandler {
    NSLog(@"Getting");

    counterValue = [message objectForKey:@"counterValue"];
    self.display.text
    =counterValue;
}

- (IBAction)clipboardcopying:(id)sender {
   
    AudioServicesPlaySystemSound(sound1);
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"ring" ofType:@"wav"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
    AudioServicesPlaySystemSound(soundID);
    
  //  [UIPasteboard generalPasteboard].string = counterValue;
    self.display.text=@"played sound";
    
}



@end
