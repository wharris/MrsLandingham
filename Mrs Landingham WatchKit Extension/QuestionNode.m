//
//  QuestionNode.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 17/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "QuestionNode.h"
#import "DoNode.h"


@implementation QuestionNode



- (id) initBranch: (NSString* ) payload  yesChild:(WorkNode *) yesChild  {
    self.message=payload;
    self.elseChild= yesChild;
    self.result=-1;
    return self;
}

- (id) initLoop: (NSString* ) payload  yesChild:(WorkNode *) yesChild  {
    [yesChild addNode:self];
    self.message=payload;
    self.elseChild= yesChild;
    self.result=-1;
    return self;
}




- (void)addStep:(NSString*) step{
    DoNode *node=[[DoNode alloc] initWithStep:step];
    [self addNode: node];
}





@end
