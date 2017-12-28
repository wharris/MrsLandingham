//
//  PhoneDashController.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 27/09/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "PhoneDashController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "FlowModel.h"
#import "WorkNode.h"
#import "QuestionNode.h"
#import "PickerNode.h"
#import "LogController.h"
@import UserNotifications;

@interface PhoneDashController ()
@property (weak, nonatomic) IBOutlet UILabel *counterString;
@property (weak, nonatomic) IBOutlet UIButton *ExpandButton;
@property (weak, nonatomic) IBOutlet UIButton *timeDisplayButton;
@property (weak, nonatomic) IBOutlet UIButton *taskDisplayButton;


@end


@implementation PhoneDashController {
    SystemSoundID sound1;
    NSString * taskValue;
    int startValue;
    FlowModel * model;
    LogController * logger;
}

//TODO: This should be within the logger (so the watch can use it and we can abstract it out...


- (void) dispatchNode{
    WorkNode *currentNode=[FlowModel getNode];
    [logger log_state:currentNode.message];
    if([currentNode isKindOfClass:[QuestionNode class]])
    {
        [self performSegueWithIdentifier:@"GoToQuestion" sender:self];
    }
    else if([currentNode isKindOfClass:[PickerNode class]])
    {
        [self performSegueWithIdentifier:@"GoToPicker" sender:self];
    }
    else{
        [self activateDoNode];
    }
}

- (void) activateDoNode{
    self.counter = startValue;
    taskValue=[FlowModel getMessage];
    [self sendAlertWith:taskValue];
    if ([FlowModel canExpand]){
        self.ExpandButton.enabled=YES;
        self.ExpandButton.hidden=NO;
    }else{
        self.ExpandButton.enabled=NO;
         self.ExpandButton.hidden=YES;
    }
    
}


- (void) sendAlertWith: (NSString* ) message {
    NSLog(@"Scheduling alert");
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"Actions!" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:message
                                                         arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    
    // Deliver the notification in five seconds.
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:startValue repeats:NO];
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond"
                                                                          content:content trigger:trigger];
    
    // Schedule the notification.
    // Schedule the notification. (from https://useyourloaf.com/blog/local-notifications-with-ios-10/)
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Something went wrong: %@",error);
        }
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
     logger=[[LogController alloc] init];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    startValue=300;
    taskValue=@"Start";
    model=[FlowModel coreBrain];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self
                                   selector:@selector(advanceTimer:)
                                   userInfo:nil
                                    repeats:YES];
    
    //for notifications:
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:options
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (!granted) {
                                  NSLog(@"Something went wrong");
                              }
                          }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self dispatchNode];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ProblemButton:(id)sender {
    [FlowModel problem];
    [self dispatchNode];
}

- (IBAction)DoneButton:(id)sender {
    [self playSoundCalled:@"ring"];
    [FlowModel done];
    [self dispatchNode];
  //  [FlowModel spider];
}

- (IBAction)ExpandButton:(id)sender {
    [FlowModel expand];
    [self dispatchNode];
}


- (IBAction)LogButton:(id)sender {
    [self playSoundCalled:@"air"];
    [self sendAlertWith:taskValue];
    self.counter=startValue;
    [logger log_state:[FlowModel getNode].message];
    
}


- (void) playSoundCalled: (NSString *) nameOfFile{
    AudioServicesPlaySystemSound(sound1);
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:nameOfFile ofType:@"wav"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
    AudioServicesPlaySystemSound(soundID);
}


- (void)advanceTimer:(NSTimer *)timer
{
    self.counter=self.counter-1;
    if (self.counter >=0 ){
        [self.taskDisplayButton setTitle:[NSString stringWithFormat:@"%@", taskValue] forState:UIControlStateNormal ];
        NSString * timeString=[NSString stringWithFormat:@"%d", self.counter];
        [self.timeDisplayButton setTitle:timeString forState:UIControlStateNormal ];
    }
    if (self.counter == 60) { [self playSoundCalled:@"longbeeb"]; }
    if (self.counter == 10) { [self playSoundCalled:@"countdown"]; }
    
}



@end
