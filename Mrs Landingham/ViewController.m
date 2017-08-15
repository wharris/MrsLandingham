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


NSMutableArray * algorithmtree;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self populateAlgorithm];
  
}

- (void) populateAlgorithm{
    algorithmtree = [[NSMutableArray alloc] init];
    [algorithmtree addObject:@"Bathroom"];
    [algorithmtree addObject:@"Imediate Water"];
    [algorithmtree addObject:@"Make Tea (get washing)"];
    [algorithmtree addObject:@"Vitimin Tablet"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)done:(id)sender {
    self.Task.text=[algorithmtree objectAtIndex:algorithmtree.count-1];
    [algorithmtree removeLastObject];
    
}
- (IBAction)expand:(id)sender {
}
- (IBAction)Problem:(id)sender {
}



@end
