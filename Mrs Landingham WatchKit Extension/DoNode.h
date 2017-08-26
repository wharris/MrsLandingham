//
//  DoNode.h
//  Mrs Landingham
//
//  Created by Joseph Reddington on 17/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "WorkNode.h"

@interface DoNode : WorkNode

- (void)addStep:(NSString*) step;
- (id) initWithStep: (NSString* ) payload;

@end
