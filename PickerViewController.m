//
//  PickerViewController.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 27/09/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "PickerViewController.h"
#import "PickerNode.h"
#import "FlowModel.h"

@interface PickerViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *menu;

@end

@implementation PickerViewController{
    
    NSMutableArray * pickerItems;
    NSMutableArray * workNodeItems;
    
    
    NSInteger pickerValue;
    FlowModel * model;
    }

- (void)viewDidLoad {
    NSLog(@"are we nearly there yet");
    [super viewDidLoad];
    model=[FlowModel coreBrain];
    pickerItems=[[NSMutableArray alloc] init];
    workNodeItems=[[NSMutableArray alloc] init];
    PickerNode *focusNode=[[PickerNode alloc] init];
    focusNode=[FlowModel getNode];
    NSMutableDictionary *menu=focusNode.menu;
    for(id key in menu) {
        id value = [menu objectForKey:key];
        NSLog(@"%@", key);
        
        [self makeItemWith: key startNode:value];
    }
    self.menu.dataSource = self;
    self.menu.delegate = self;
    
    
    // Do any additional setup after loading the view.
}


- (void) makeItemWith: (NSString *) input startNode: (WorkNode *) startNode {
    NSLog(@"%@", input);
    [pickerItems addObject: input ];
    [workNodeItems addObject: startNode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;  // Or return whatever as you intend
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component {
    return pickerItems.count;//Or, return as suitable for you...normally we use array for dynamic
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%@", pickerItems[row]];//Or, your suitable title; like Choice-a, etc.
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    pickerValue=row;
}

- (IBAction)doneButton:(id)sender {
    [FlowModel picked:workNodeItems[pickerValue]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
