//
//  PickerNode.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 27/09/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "PickerNode.h"
#import "WorkNode.h";

@implementation PickerNode

- (id) initWithDic: (NSMutableDictionary* ) input {
    self.menu=input;
    self.child=NULL;
    return self;
}

- (void)addNode:(WorkNode*) target  {
    for(id key in self.menu) {
        WorkNode * value = [self.menu objectForKey:key];
        [value addNode:target];
    }
}


@end
