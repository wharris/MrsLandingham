//
//  PickerController.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 16/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "PickerController.h"

@interface PickerController ()

@end

@implementation PickerController

NSArray * pickerItems;
NSInteger pickerValue =0;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    
    WKPickerItem *pickerItem1 = [WKPickerItem alloc];
    [pickerItem1 setTitle:@"Morning"];
    [pickerItem1 setAccessoryImage:[WKImage imageWithImageName:@"Smile"]];
    
    WKPickerItem *pickerItem2 = [WKPickerItem alloc];
    [pickerItem2 setTitle:@"Night"];
    [pickerItem2 setAccessoryImage:[WKImage imageWithImageName:@"Smile"]];
    
    WKPickerItem *pickerItem3 = [WKPickerItem alloc];
    [pickerItem3 setTitle:@"Coffee Shop"];
    [pickerItem3 setAccessoryImage:[WKImage imageWithImageName:@"Smile"]];
   
    WKPickerItem *pickerItem4 = [WKPickerItem alloc];
    [pickerItem4 setTitle:@"Question Test"];
    [pickerItem4 setAccessoryImage:[WKImage imageWithImageName:@"Smile"]];
  
    WKPickerItem *pickerItem5 = [WKPickerItem alloc];
    [pickerItem4 setTitle:@"Plan Day"];
    [pickerItem4 setAccessoryImage:[WKImage imageWithImageName:@"Smile"]];
    
    
    NSArray * pickerItems = [[NSArray alloc] initWithObjects:pickerItem1, pickerItem2, pickerItem3, pickerItem4, nil];
    [self.picker setItems:pickerItems];
    
}

- (IBAction)picked {
    
    NSLog(@"Before push = %d", pickerValue);
    NSNumber *valuePointer = [NSNumber numberWithInteger:pickerValue];

    int checkValue=[valuePointer integerValue];
    NSLog(@"Check Value = %d", checkValue);
    
    [self pushControllerWithName: @"doing"  context: valuePointer];
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



