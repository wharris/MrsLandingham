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



- (int) fib:(int) innumber{
    calls++;
    NSLog(@"Here");
    if (fib_numbers[innumber]>0){
        return fib_numbers[innumber];
  
    }
    if (innumber<=2){
        return innumber;
    }
    
    
    int result= [self fib:innumber-1]+[self fib:innumber-2];
    fib_numbers[innumber]=result;
    return result;
}

- (int) euler2WithMax:(int) max{
    for (int i=0;i<max;i++){
        fib_numbers[i]=0;
        
    }
    int result=[self fib:max];
    return result;
}


- (int) euler1WithMax:(int) max{
    //If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
    //Find the sum of all the multiples of 3 or 5 below 1000.
    
    // Do any additional setup after loading the view, typically from a nib.
    
    int running_total=0;
    for (int i=0;i<max;i++){
        if ((i % 3==0) ||  (i % 5 ==0)){
            running_total+=i;
        }
     }
     return running_total;
}

@end
