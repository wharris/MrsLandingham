//
//  DashController.h
//  Mrs Landingham
//
//  Created by Joseph Reddington on 13/09/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashController : UIViewController
{
    int counter;
}
@property (assign) int counter;
- (IBAction)startCountdown:(id)sender;
@end

