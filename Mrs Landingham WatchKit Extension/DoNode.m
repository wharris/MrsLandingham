//
//  DoNode.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 17/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "DoNode.h"

@implementation DoNode



- (id) initWithStep: (NSString* ) payload {
    self.message=payload;
    self.child=NULL;
    return self;
}


- (void) activate{
    
    
    
}

- (void)addNode:(WorkNode*) target  {
    if (self.child==NULL){
        self.child=target;
    }else{
        [self.child addNode:target];
    }
    
}
    - (void)addStep:(NSString*) step{
        DoNode *node=[[DoNode alloc] initWithStep:step];
        [self addNode: node];
    }
    



@end

