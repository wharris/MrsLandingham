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
+ (void) problem;
+ (void) expand;
+ (void) picked: (WorkNode *) input;
+ (void) spider;
+ (BOOL) canExpand;
+ (NSString *) getMessage;
+ (WorkNode *) getNode;
+ (NSMutableDictionary *)make_problem_menu;
+ (NSMutableDictionary *)make_initial_menu;

@end
