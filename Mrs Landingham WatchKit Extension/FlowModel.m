//
//  FlowModel.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 27/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "FlowModel.h"
#import "WorkNode.h"
#import "DoNode.h"
#import "QuestionNode.h"

@implementation FlowModel

- (WorkNode *)setup_doghouse {
    DoNode *local=[[DoNode alloc] initWithStep:@"Get full water bottle"];
    [local addStep: @"Put Phone on charge"];
    [local addStep: @"Tell phone Instramental music" ];
    [local addStep: @"Put everything on one side of the desk and process it" ];
    return local;
}

- (WorkNode *)start_laptop {
    DoNode *local=[[DoNode alloc] initWithStep:@"Open Jurgen and livenotes"];
    [local addStep: @"Open Prioirty and Time Chart (for flow)"];
    [local addStep: @"Close all other programs"];
    return local;
}



- (WorkNode *)morning {
    DoNode *local=[[DoNode alloc] initWithStep:@"Pick one of streaching, meditation, or chinups"];
    [local addStep: @"Kitchen: Start Kettle boiling"];
    [local addStep: @"Bathroom" ];
    [local addStep: @"Bath: Drink 1L Water" ];
    [local addStep: @"Bath: Shower"];
    [local addStep: @"Bath: Dress"];
    [local addStep: @"Bath: Teeth"];
    [local addStep: @"Bath: Floss"];
    [local addStep: @"Bath: Shave head"];
    [local addStep: @"Bath: Shave"];
    [local addStep: @"Kitc: clothes in wash"];
    [local addStep: @"Kitc:Vitimin Tablet"];
    [local addStep: @"Kitc:Make Tea (get washing)"];
    [local addStep: @"Go To Doghouse"];
    [local addNode: [self setup_doghouse]];
    [local addNode: [self start_laptop]];
    
    return local;
}


- (WorkNode *)questionTest {
    DoNode *local=[[DoNode alloc] initWithStep:@"This is the beginging"];
    [local addStep: @"1"];
    [local addStep: @"2"];
    [local addStep: @"3"];
    DoNode *yesNode=[[DoNode alloc] initWithStep:@"Then Celebrate"];
    DoNode *noNode=[[DoNode alloc] initWithStep:@"Then fix it"];
    QuestionNode *testQ=[[QuestionNode alloc] initWithQuestion: @"Do you want to go back to the begining?" yesChild: local noChild:noNode];
    [local addNode:testQ];
    [noNode addNode: [self morning]];
    NSLog(@"We have populated the algorithm tree");
    return local;
}



- (WorkNode *) enterCoffeeShop{
    DoNode *local=[[DoNode alloc] initWithStep:@"Smile"];
    [local addStep: @"Order a green tea and a glass of tap water"];//No sugar, only peace
    [local addStep: @"Find seat with plug"];
    [local addStep: @"Spread things around table"];
    [local addStep: @"Take off shoes and a layer"];
    [local addStep: @"Everything on charge"];
    [local addStep: @"Set timer for leaving"];
    [local addStep: @"Get a local next actions"];
    return local;
    
}

- (WorkNode *) night{
    DoNode *local=[[DoNode alloc] initWithStep:@"Laptop on charge"];
    [local addStep: @"Glasses in Ospray"];
    [local addStep: @"Headphones on charge"];
    [local addStep: @"Night Glasses On"];
    [local addStep: @"Lock Door"];
    [local addStep: @"Put glass in bathroom (and drink it)"];
    [local addStep: @"Teeth"];
    [local addStep: @"Floss"];
    [local addStep: @"Leave good clothes in bathroom"];
    [local addStep: @"otherclothes in washing machine"];
    [local addStep: @"Get tomorrow's clothes from bedroom"];
    [local addStep: @"Keys in bag"];
    [local addStep: @"Wallet has two bank cards"];
    [local addStep: @"Phone on charge"];
    [local addStep: @"Food in bag"];
    [local addStep: @"Bike lights"];
    [local addStep: @"Pens and notebook in bag"];
    [local addStep: @"Spare battery"];
    [local addStep: @"Other battery on charge"];
    [local addStep: @"MacBook charger"];
    [local addStep: @"folding plug"];
    [local addStep: @"Seal bag"];
    [local addStep: @"Setup tea and water bottles"];
    [local addStep: @"Sleep mask on head"];
    [local addStep: @"Lights out"];
    [local addStep: @"watch on charge"];
    return local;
    
}



@end
