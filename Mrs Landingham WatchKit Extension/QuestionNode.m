//
//  QuestionNode.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 17/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "QuestionNode.h"

@implementation QuestionNode



- (id) initWithQuestion: (NSString* ) payload  yesChild:(WorkNode *) child noChild:(WorkNode *) noChild {
    self.message=payload;
    self.child=child;
    self.elseChild= noChild;
    self.result=-1;
    return self;
}


- (void) activate{
    
    
    
}





@end
