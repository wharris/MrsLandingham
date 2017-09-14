//
//  DashController.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 13/09/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "DashController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface DashController ()
@property (weak, nonatomic) IBOutlet UILabel *counterString;
@end

@implementation DashController

//
//  DashController.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 13/09/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//


SystemSoundID sound1;


- (void)viewDidLoad {
    [super viewDidLoad];
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
- (IBAction)playsound:(id)sender {
    AudioServicesPlaySystemSound(sound1);
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"ring" ofType:@"wav"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
    AudioServicesPlaySystemSound(soundID);
//timer
    self.counter = 10;
    self.counterString.text=[NSString stringWithFormat:@"started %d", counter];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self
                                   selector:@selector(advanceTimer:)
                                   userInfo:nil
                                    repeats:YES];

    
}

- (IBAction)startCountdown:(id)sender
{
    self.counter = 10;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self
                                                             selector:@selector(advanceTimer:)
                                                             userInfo:nil
                                                              repeats:YES];
    NSLog(@"Here");
}

- (void)advanceTimer:(NSTimer *)timer
{
    NSLog(@"advance timer");
    NSLog(@"%@", [NSString stringWithFormat:@"counter %d", self.counter]);
    self.counter=self.counter-1;
    self.counterString.text=[NSString stringWithFormat:@"%d", self.counter];
    if (self.counter <= 0) { [timer invalidate]; }
}




@end
