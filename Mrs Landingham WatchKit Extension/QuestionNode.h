//
//  QuestionNode.h
//  Mrs Landingham
//
//  Created by Joseph Reddington on 17/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "WorkNode.h"

@interface QuestionNode : WorkNode

@property WorkNode *child;
@property WorkNode *elseChild;
@property int result;
- (id) initWithQuestion: (NSString* ) payload  yesChild:(WorkNode *) child noChild:(WorkNode *) elseChild;


@end
