//
//  ViewController.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 15/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//


#import "ViewController.h"
#import "WatchConnectivity/WatchConnectivity.h"
#import "LogController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *ancButton;

@end

@implementation ViewController{


NSString *counterValue;

WCSession *session;
NSString *logString;
    UIDocumentInteractionController *docController;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    logString = [message objectForKey:@"log"];
    
    self.display.text
    =counterValue;
}

- (IBAction)printlog:(id)sender {
    LogController * logger;
    logger=[[LogController alloc] init];
    NSString * temp =@"hello";
    temp=[logger getLog];
    
    //try the open file
    NSString * filePath = [logger get_filePath];
    docController = [UIDocumentInteractionController
                     interactionControllerWithURL:[NSURL fileURLWithPath:filePath]];
    docController.delegate = self;
    docController.UTI = @"com.adobe.pdf";
    [docController presentOpenInMenuFromRect:self.view.frame inView:self.view animated:true];
    NSLog(@"did the thing");
    //end try.
    [UIPasteboard generalPasteboard].string = temp;
}

@end
