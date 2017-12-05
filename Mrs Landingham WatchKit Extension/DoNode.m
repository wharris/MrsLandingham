//
//  DoNode.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 17/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "DoNode.h"

@implementation DoNode



- (id) initStep: (NSString* ) payload {
    self.message=payload;
    self.child=NULL;
    return self;
}


- (id) initStep: (NSString* ) payload with: (WorkNode *) function{
    self.message=payload;
    self.child=NULL;
    self.expansion=function;
    return self;
}


    - (void)addStep:(NSString*) step{
        DoNode *node=[[DoNode alloc] initStep:step];
        [self addNode: node];
    }

- (void)addStep:(NSString*) step with: (WorkNode *) function{
    DoNode *node=[[DoNode alloc] initStep:step];
    node.expansion=function;
    [self addNode: node];
    //hmm, how do we tie this up?
    
}

/* This override is needed because we have to add the child to the extension as well */
- (void)addNode:(WorkNode*) target  {
    if (self.child==NULL){
        self.child=target;
        [self.expansion addNode: target];
    }else{
        [self.child addNode:target];
    }
    
}




@end

