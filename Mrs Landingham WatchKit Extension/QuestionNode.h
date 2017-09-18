//
//  QuestionNode.h
//  Mrs Landingham
//
//  Created by Joseph Reddington on 17/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "WorkNode.h"

@interface QuestionNode : WorkNode


@property WorkNode *elseChild;
@property int result;
- (id)  initBranch: (NSString* ) payload  yesChild:(WorkNode *) yesChild;
- (void)addStep:(NSString*) step;

@end
