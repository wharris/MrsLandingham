//
//  QuestionViewController.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 27/09/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "QuestionViewController.h"
#import "FlowModel.h"

@interface QuestionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *message;

@end

@implementation QuestionViewController{
    FlowModel * model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    model=[FlowModel coreBrain];
    self.message.text=[FlowModel getMessage];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)YesButton:(id)sender {
    self.message.text=@"Yes";
    [FlowModel yes];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)NoButton:(id)sender {
    self.message.text=@"No";
    [FlowModel no];
    [self dismissViewControllerAnimated:YES completion:nil];
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
