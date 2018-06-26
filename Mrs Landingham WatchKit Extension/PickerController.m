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

@implementation PickerController{

NSMutableArray * pickerItems;
NSMutableArray * workNodeItems;


NSInteger pickerValue;
FlowModel * model;
    
}

- (void)awakeWithContext:(id)context {
    pickerItems=[[NSMutableArray alloc] init];
    workNodeItems=[[NSMutableArray alloc] init];
    
    NSLog(@"here in awc");
    [super awakeWithContext:context];
    // Configure interface objects here.
    
    model=[[FlowModel alloc] init];
    NSMutableDictionary *menu=[model make_initial_menu];
    if (context!=nil){
       menu= [model make_exception_menu];
    }
   for(id key in menu) {
    id value = [menu objectForKey:key];
    NSLog(@"%@", key);
    
    [self makeItemWith: key startNode:value];

    [self.picker setItems: pickerItems];
   }
}



- (void) makeItemWith: (NSString *) input startNode: (WorkNode *) startNode {
    WKPickerItem *pickerItem4 = [WKPickerItem alloc];
    NSLog(@"%@", input);
    [pickerItem4 setTitle:input];
    [pickerItem4 setAccessoryImage:[WKImage imageWithImageName:@"Smile"]];
    [pickerItems addObject: pickerItem4 ];
    [workNodeItems addObject: startNode];
}




/* TODO: Move this to super class */
- (WorkNode *) getWorkNodeAt: (int) input {
    return [workNodeItems objectAtIndex: input];
}



- (IBAction)picked {
    
    NSLog(@"Before push = %d", pickerValue);
    WorkNode * root = [self getWorkNodeAt: pickerValue];
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



