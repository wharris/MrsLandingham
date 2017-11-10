//
//  QuestionNode.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 17/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "QuestionNode.h"
#import "DoNode.h"


@implementation QuestionNode{
    BOOL loop;
}



- (id) initBranch: (NSString* ) payload  yesChild:(WorkNode *) yesChild  {
    self.message=payload;
    self.elseChild= yesChild;
    self.result=-1;
    loop=FALSE;
    return self;
}

- (id) initLoop: (NSString* ) payload  yesChild:(WorkNode *) yesChild  {
    [yesChild addNode:self];
    self.message=payload;
    self.elseChild= yesChild;
    self.result=-1;
    loop=TRUE;
    return self;
}

- (void)addStep:(NSString*) step{
    DoNode *node=[[DoNode alloc] initWithStep:step];
    [self addNode:node];
}


- (void)addNode:(WorkNode *) payload{
    //What's the behavioru I want here?
    //If it's a closed loop, it should be closed, and the elsechild is the looping one.
    //If it's an open loop, then what really should happen is that the branch points to the first sucessor node... (so we don't double up...) So, if it isn't a loop, then the first sucessor node should be the successor to both (which I have below). 
    if(!loop){
        if(self.child==NULL){
            [self.elseChild addNode: payload];
        }}
    if(self.child==NULL){
        self.child= payload;
    }else{
    [self.child addNode: payload];
    }
}






@end
