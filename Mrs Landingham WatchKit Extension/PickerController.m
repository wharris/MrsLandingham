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

NSArray * pickerItems;
NSInteger pickerValue =0;
FlowModel * model;


- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
      WKPickerItem *pickerItem1 = [self makeItemWith:@"Morning"];
      WKPickerItem *pickerItem2 = [self makeItemWith:@"Night"];
     WKPickerItem *pickerItem3 = [self makeItemWith:@"Coff Shop"];
    WKPickerItem *pickerItem4 = [self makeItemWith:@"Question Test"];
    WKPickerItem *pickerItem5 = [self makeItemWith:@"Plan Day"];
    
    NSArray * pickerItems = [[NSArray alloc] initWithObjects:pickerItem1, pickerItem2, pickerItem3, pickerItem4, pickerItem5];
    [self.picker setItems:pickerItems];
    
}

- (WKPickerItem *) makeItemWith: (NSString *) input{
    WKPickerItem *pickerItem4 = [WKPickerItem alloc];
    [pickerItem4 setTitle:input];
    [pickerItem4 setAccessoryImage:[WKImage imageWithImageName:@"Smile"]];
    return pickerItem4;
}

- (IBAction)picked {
    
    model=[[FlowModel alloc] init];
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



