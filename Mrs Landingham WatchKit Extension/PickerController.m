//
//  PickerController.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 16/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "PickerController.h"
#import "FlowModel.h"

@interface PickerController ()

@end

@implementation PickerController


NSInteger pickerValue =0;
FlowModel * model;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
    
    model=[[FlowModel alloc] init];
    if (context==nil){
   [model make_initial_menu];
    }else
    {
        [model make_problem_menu];
    }
    
    [self.picker setItems: [model getPickerItems]];
}

- (IBAction)picked {
    
    NSLog(@"Before push = %d", pickerValue);
    WorkNode * root = [model getWorkNodeAt: pickerValue];
    [self pushControllerWithName: @"doing"  context: root];
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)Pickertrickers:(NSInteger)value {
    pickerValue=value;
    NSLog(@"value = %d", value);
    
}

@end



