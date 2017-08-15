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
int myindex=0;
const int maxSize=10;
NSString * doing[maxSize];
NSMutableArray * algorithmtree;



@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    self.mylabel.text =@"98";
    for (int i=0;i<10;i++){
        doing[i]=@"";
    }
    algorithmtree = [[NSMutableArray alloc] init];
    [algorithmtree addObject:@"Bathroom"];
    [algorithmtree addObject:@"Imediate Water"];
    [algorithmtree addObject:@"Make Tea (get washing)"];
    [algorithmtree addObject:@"Vitimin Tablet"];
    NSLog(@"We have populated the algorithm tree");
    NSString *myStr = [NSString stringWithFormat: @"%d",algorithmtree.count];
    NSLog(myStr);
 NSLog([algorithmtree objectAtIndex:algorithmtree.count-1]);
    NSLog(@"it might have worked");
    
    _targetTime = [NSDate dateWithTimeInterval:300 sinceDate:[NSDate date]];
    
    [self.joetimer setDate:_targetTime];
    
    [_joetimer start];
    self.mylabel.text=[algorithmtree objectAtIndex:algorithmtree.count-1];
    [algorithmtree removeLastObject];

    
}





- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)Done {
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



