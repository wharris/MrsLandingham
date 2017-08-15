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

@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    self.mylabel.text =@"99";
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)up {
    x++;
    NSString *myStr = [NSString stringWithFormat: @"%d",x];
    NSLog(@"Yo");
    self.mylabel.text =myStr;
    
}
- (IBAction)down {
    x--;
    NSString *myStr = [NSString stringWithFormat: @"%d",x];
    NSLog(@"No");
    self.mylabel.text =myStr;
}

@end



