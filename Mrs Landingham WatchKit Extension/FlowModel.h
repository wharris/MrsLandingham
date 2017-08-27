//
//  FlowModel.h
//  Mrs Landingham
//
//  Created by Joseph Reddington on 27/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkNode.h"

@interface FlowModel : NSObject

- (WorkNode *) setup_doghouse;
- (WorkNode *) morning;
- (WorkNode *) questionTest;
- (WorkNode *) enterCoffeeShop;
- (WorkNode *) plan_day;
- (WorkNode *) night;

@end
