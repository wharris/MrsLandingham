//
//  PickerController.h
//  Mrs Landingham
//
//  Created by Joseph Reddington on 16/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface PickerController : WKInterfaceController
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *picker;

@end
