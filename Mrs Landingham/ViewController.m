//
//  ViewController.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 15/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//


#import "ViewController.h"
#import "WatchConnectivity/WatchConnectivity.h"
@interface ViewController ()

@end

@implementation ViewController

NSString *counterValue;

WCSession *session;

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
    [UIPasteboard generalPasteboard].string = counterValue;
    
}



@end
