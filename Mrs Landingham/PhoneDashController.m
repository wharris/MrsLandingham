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

@interface PhoneDashController ()
@property (weak, nonatomic) IBOutlet UILabel *taskString;
@property (weak, nonatomic) IBOutlet UILabel *counterString;

@end

@implementation PhoneDashController {
SystemSoundID sound1;
NSString * taskValue;
int startValue;
FlowModel * model;
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
    self.counterString.text=[NSString stringWithFormat:@"Seconds remaining: %d", self.counter];
    self.taskString.text=[NSString stringWithFormat:@"Task: %@", taskValue];
    if (self.counter == 10) { [self playSoundCalled:@"countdown"]; }
    if (self.counter <= 0) { [timer invalidate]; }
    
}

- (void) dispatchNode{
    WorkNode *currentNode=[FlowModel getNode];
    if([currentNode isKindOfClass:[QuestionNode class]])
    {
       [self performSegueWithIdentifier:@"GoToQuestion" sender:self];
    }
    else{
       [self activateDoNode];
    }

    
}

- (void) activateDoNode{
    
    self.counter = startValue;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self
                                   selector:@selector(advanceTimer:)
                                   userInfo:nil
                                    repeats:YES];
    taskValue=[FlowModel getMessage];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    startValue=300;
    taskValue=@"Start";
    model=[FlowModel coreBrain];
    
    [self activateDoNode];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ProblemButton:(id)sender {
    
    
}

- (IBAction)DoneButton:(id)sender {
    [self playSoundCalled:@"ring"];
    [FlowModel done];
    [self dispatchNode];
    taskValue=[FlowModel getMessage];
    self.counter=startValue;
}

- (IBAction)ExpandButton:(id)sender {
    
}


- (IBAction)LogButton:(id)sender {
    [self playSoundCalled:@"ring"];
    self.counter=startValue;

}


@end
