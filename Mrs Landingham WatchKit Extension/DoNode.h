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
- (void)addStep:(NSString*) step with: (WorkNode *) function;

- (id) initStep: (NSString* ) payload;
- (id) initStep: (NSString* ) payload with: (WorkNode *) function;


@end
