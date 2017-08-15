//
//  InterfaceController.h
//  Mrs Landingham WatchKit Extension
//
//  Created by Joseph Reddington on 15/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *mylabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTimer *joetimer;
@property (nonatomic, strong) NSDate * targetTime;

@end
