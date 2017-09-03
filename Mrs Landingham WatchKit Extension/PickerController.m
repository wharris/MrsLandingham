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

NSMutableArray * pickerItems;
NSMutableArray * workNodeItems;
NSInteger pickerValue =0;
FlowModel * model;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
    pickerItems = [[NSMutableArray alloc] init];
    workNodeItems = [[NSMutableArray alloc] init];
    model=[[FlowModel alloc] init];
    
    [self makeItemWith:@"Morning" startNode: [model morning] ];
    [self makeItemWith:@"Night" startNode: [model night]] ;
    [self makeItemWith:@"Coff Shop" startNode: [model enterCoffeeShop] ];
    [self makeItemWith:@"Question Test" startNode: [model questionTest]];
    [self makeItemWith:@"Plan Day"  startNode: [model plan_day]];
    [self.picker setItems:pickerItems];
}

- (void) makeItemWith: (NSString *) input startNode: (WorkNode *) startNode {
    WKPickerItem *pickerItem4 = [WKPickerItem alloc];
    [pickerItem4 setTitle:input];
    [pickerItem4 setAccessoryImage:[WKImage imageWithImageName:@"Smile"]];
    [pickerItems addObject: pickerItem4 ];
    [workNodeItems addObject: startNode];
    
    
}

- (IBAction)picked {
    
    
    WorkNode * root = [model morning];
    if (pickerValue==0){
        root = [model morning];
    }
    if (pickerValue==1){
        root = [model night];
    }
    if (pickerValue==2){
        root = [model enterCoffeeShop];
    }
    if (pickerValue==3){
        root = [model questionTest];
    }
    if (pickerValue==4){
        root = [model plan_day];
    }
    NSLog(@"Before push = %d", pickerValue);
    NSNumber *valuePointer = [NSNumber numberWithInteger:pickerValue];
    
    int checkValue=[valuePointer integerValue];
    NSLog(@"Check Value = %d", checkValue);
    
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



