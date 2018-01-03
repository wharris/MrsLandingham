//
//  DoNode.h
//  Mrs Landingham
//
//  Created by Joseph Reddington on 17/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "WorkNode.h"

@interface DoNode : WorkNode

@property WorkNode *expansion;

- (void)addStep:(NSString*) step;
- (void)addStep:(NSString*) step withTime: (int) deadline;
- (void)addStep:(NSString*) step with: (WorkNode *) function;
- (void)addStep:(NSString*) step withTime: (int) deadline;
- (void)addStep:(NSString*) step with: (WorkNode *) function withTime: (int) deadline;

- (id) initStep: (NSString* ) payload;
- (id) initStep: (NSString* ) payload withTime: (int) deadline;
- (id) initStep: (NSString* ) payload with: (WorkNode *) function;
- (id) initStep: (NSString* ) payload with: (WorkNode *) function withTime: (int) deadline;
- (id) initStep: (NSString* ) payload withTime: (int) deadline;

@end
