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

#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

@interface PhoneDashController ()
@property (weak, nonatomic) IBOutlet UILabel *counterString;
@property (weak, nonatomic) IBOutlet UIButton *ExpandButton;
@property (weak, nonatomic) IBOutlet UIButton *timeDisplayButton;
@property (weak, nonatomic) IBOutlet UIButton *taskDisplayButton;
@property (weak, nonatomic) IBOutlet UIButton *previewButton;


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
    WorkNode *currentNode=[model getNode];
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
    self.counter = [model getTime];
    taskValue=[model getMessage];
    //taking off in case that is what's causing the swlosown. [self sendAlertWith:taskValue];
    if ([model canExpand]){
        self.ExpandButton.enabled=YES;
        self.ExpandButton.hidden=NO;
    }else{
        self.ExpandButton.enabled=NO;
         self.ExpandButton.hidden=YES;
    }
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:taskValue];
    AVSpeechSynthesizer *syn = [[AVSpeechSynthesizer alloc] init];
    [syn speakUtterance:utterance];
    
}


- (void) sendAlertWith: (NSString* ) message {
    //Sends an alert to the user when they are on a differnt screen.
    NSLog(@"Scheduling alert");
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"Actions!" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:message
                                                         arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:startValue repeats:NO];
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"DELORES action"
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
    _taskDisplayButton.layer.cornerRadius = 10;
    _taskDisplayButton.clipsToBounds = true;
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
    [model problem];
    [self dispatchNode];
}

- (IBAction)DoneButton:(id)sender {
    [self playSoundCalled:@"ring"];
    [model done];
    [self dispatchNode];
  //  [model spider];
}

- (IBAction)ExpandButton:(id)sender {
    [model expand];
    [self dispatchNode];
}


- (IBAction)LogButton:(id)sender {
    [self playSoundCalled:@"air"];
    [self sendAlertWith:taskValue];
    self.counter=[model getTime];
    [logger log_state:[model getNode].message];
    
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
         [self.previewButton setTitle:[NSString stringWithFormat:@"%@", [model getPreview]] forState:UIControlStateNormal ];
        NSString * timeString=[NSString stringWithFormat:@"%d", self.counter];
        [self.timeDisplayButton setTitle:timeString forState:UIControlStateNormal ];
    }
    if (self.counter % 30 ==10)
    {
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:taskValue];
    AVSpeechSynthesizer *syn = [[AVSpeechSynthesizer alloc] init];
    [syn speakUtterance:utterance];
    }
    if (self.counter == 60) { [self playSoundCalled:@"longbeeb"]; }
    if (self.counter == 10) { [self playSoundCalled:@"countdown"]; }
    if (self.counter == 0) { [model outoftime];[self dispatchNode]; }
    // if (self.counter == 1) { [logger log_state:@"Deadline passed!"]; }
    
}



@end
