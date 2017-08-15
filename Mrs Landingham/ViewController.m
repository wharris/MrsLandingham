//
//  ViewController.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 15/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

int calls=0;

NSInteger fib_numbers[100] = {0,0,0,0,0,0,0,0,0,0};

- (void)viewDidLoad {
    [super viewDidLoad];
    
  //  int running_total=[self euler1WithMax:10];
  //  [self printThis:running_total];
    NSLog(@"Hello:");
    int result=[self euler2WithMax: 10];
    [self printThis:result];
    NSString *myStr = [NSString stringWithFormat: @"%d",calls];
    NSLog(@"How many calls?:");
    NSLog(myStr);
    NSLog(@"Done");
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) printThis:(int) running_total{
    NSString *myStr = [NSString stringWithFormat: @"%d",running_total];
    NSLog(@"Final Total is:");
    NSLog(myStr);
    NSLog(@"Done");
}



@end
