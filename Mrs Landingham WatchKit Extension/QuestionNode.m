//
//  QuestionNode.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 17/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "QuestionNode.h"

@implementation QuestionNode


- (id) initWithQuestion: (NSString* ) payload  yesChild:(WorkNode *) child noChild:(WorkNode *) elseChild {
    self.message=payload;
    self.child=child;
    self.elseChild= _elseChild;
    return self;
}


- (void) activate{
    
    
    
}





@end
