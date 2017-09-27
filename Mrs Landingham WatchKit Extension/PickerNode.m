//
//  PickerNode.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 27/09/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "PickerNode.h"

@implementation PickerNode

- (id) initWithDic: (NSMutableDictionary* ) input {
    self.menu=input;
    self.child=NULL;
    return self;
}

- (void)addNode:(WorkNode*) target  {
    NSLog(@"Method called in error: PickerNode");
}


@end
