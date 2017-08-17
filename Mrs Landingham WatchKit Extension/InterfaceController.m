//
//  InterfaceController.m
//  Mrs Landingham WatchKit Extension
//
//  Created by Joseph Reddington on 15/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController ()

@end

int x = 0;
NSMutableArray * algorithmtree;
bool firsttime=TRUE;


@implementation InterfaceController


- (void)morning {
  algorithmtree = [[NSMutableArray alloc] init];
    [algorithmtree insertObject:@"Bathroom3" atIndex:0];
    [algorithmtree insertObject:@"Imediate Water" atIndex:0];
    [algorithmtree insertObject:@"Make Tea (get washing)" atIndex:0];
    [algorithmtree insertObject:@"Vitimin Tablet" atIndex:0];
    NSLog(@"We have populated the algorithm tree");
}



- (void)startCountdown {
  _targetTime = [NSDate dateWithTimeInterval:300 sinceDate:[NSDate date]];
    [self.joetimer setDate:_targetTime];
    [_joetimer start];
}

- (void)awakeWithContext:(id)context {
    
    [super awakeWithContext:context];
    self.mylabel.text =@"98";
    NSLog(@"Hey");
    [self morning];
    
    [self startCountdown];
    
    self.mylabel.text=[algorithmtree objectAtIndex:algorithmtree.count-1];
    [algorithmtree removeLastObject];
    int pickerValue=[context integerValue];
    self.mylabel.text=[NSString stringWithFormat:@"%d",pickerValue];
    // Configureinterface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSLog(@"it Visible have worked");
   
    
}





- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)Done {
    
    //TODO: if algoirthmtree is empty then display finnished. 
    self.mylabel.text=[algorithmtree objectAtIndex:algorithmtree.count-1];
    [algorithmtree removeLastObject];
    [_joetimer stop];
    _targetTime = [NSDate dateWithTimeInterval:300 sinceDate:[NSDate date]];
    
    [self.joetimer setDate:_targetTime];
    
    [_joetimer start];
    
}

- (IBAction)Expand {
}
- (IBAction)Problem {
}


@end



