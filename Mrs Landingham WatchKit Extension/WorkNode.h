//
//  workNode.h
//  Mrs Landingham
//
//  Created by Joseph Reddington on 17/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkNode : NSObject

@property NSString *message;
@property WorkNode *child;


- (void)addNode:(WorkNode*) target;

@end
