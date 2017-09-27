//
//  PhoneDashController.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 27/09/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "PhoneDashController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface PhoneDashController ()
@property (weak, nonatomic) IBOutlet UILabel *taskString;
@property (weak, nonatomic) IBOutlet UILabel *counterString;

@end

@implementation PhoneDashController {
SystemSoundID sound1;
NSString * taskValue;
int startValue;
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
    self.counterString.text=[NSString stringWithFormat:@"Seconds remaining: %d", self.counter];
    self.taskString.text=[NSString stringWithFormat:@"Task: %@", taskValue];
    if (self.counter == 10) { [self playSoundCalled:@"countdown"]; }
    if (self.counter <= 0) { [timer invalidate]; }
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    startValue=300;
    taskValue=@"Start";
    self.counter = startValue;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self
                                   selector:@selector(advanceTimer:)
                                   userInfo:nil
                                    repeats:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
