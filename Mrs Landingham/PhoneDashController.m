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

- (void) dispatchNode{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // ###### 30/11/17 14:37:
    [dateFormatter setDateFormat:@"\n\n###### dd/MM/YY HH:mm\n"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"Going to write to file");
    [logger writeLogWith: dateString];
    WorkNode *currentNode=[FlowModel getNode];
    [logger writeLogWith: currentNode.message];
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
    if ([FlowModel canExpand]){
        self.ExpandButton.enabled=YES;
        self.ExpandButton.hidden=NO;
      //  self.ExpandButton.backgroundColor = [UIColor greenColor];
    }else{
        self.ExpandButton.enabled=NO;
         self.ExpandButton.hidden=YES;
      //  self.ExpandButton.backgroundColor = [UIColor redColor];
    }
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
}

- (IBAction)ExpandButton:(id)sender {
    [FlowModel expand];
    [self dispatchNode];
}


- (IBAction)LogButton:(id)sender {
    [self playSoundCalled:@"ring"];
    self.counter=startValue;
    
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
    NSLog(@"advance timer");
    NSLog(@"%@", [NSString stringWithFormat:@"counter %d", self.counter]);
    self.counter=self.counter-1;
    [self.taskDisplayButton setTitle:[NSString stringWithFormat:@"%@", taskValue] forState:UIControlStateNormal ];
    NSString * timeString=[NSString stringWithFormat:@"%d", self.counter];
    [self.timeDisplayButton setTitle:timeString forState:UIControlStateNormal ];
    if (self.counter == 10) { [self playSoundCalled:@"countdown"]; }
    if (self.counter <= 0) { [timer invalidate]; }
    
}



@end
