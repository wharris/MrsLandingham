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



+ (id)coreBrain;
+ (void) done;
+ (void) yes;
+ (void) no;
+ (NSString *) getMessage;
+ (WorkNode *) getNode;
- (WorkNode *) setup_doghouse;
- (WorkNode *) morning;
- (WorkNode *) questionTest;
- (WorkNode *) enterCoffeeShop;
- (WorkNode *) plan_day;
- (WorkNode *) night;
- (NSMutableDictionary *)make_problem_menu;
- (NSMutableDictionary *)make_initial_menu;
- (WorkNode *) getWorkNodeAt: (int) input;
- (NSMutableArray*) getPickerItems;

@end
