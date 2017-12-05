//
//  PickerNode.h
//  Mrs Landingham
//
//  Created by Joseph Reddington on 27/09/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "WorkNode.h"

@interface PickerNode : WorkNode


@property NSMutableDictionary *menu;

- (id) initWithDic: (NSMutableDictionary* ) input;
@end


//for each element of input. Run Add on it.  Hmmm.
