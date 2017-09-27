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

@interface PhoneDashController ()
@property (weak, nonatomic) IBOutlet UILabel *taskString;
@property (weak, nonatomic) IBOutlet UILabel *counterString;
@property (weak, nonatomic) IBOutlet UIButton *ExpandButton;

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
        self.ExpandButton.backgroundColor = [UIColor greenColor];
    }else{
        self.ExpandButton.enabled=NO;
        self.ExpandButton.backgroundColor = [UIColor redColor];
    }
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    startValue=300;
    taskValue=@"Start";
    model=[FlowModel coreBrain];
    
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self
                                   selector:@selector(advanceTimer:)
                                   userInfo:nil
                                    repeats:YES];
    
    // Do any additional setup after loading the view.
    
    
}

- (void)viewWillAppear:(BOOL)animated {
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


@end
