//
//  InterfaceController.m
//  Mrs Landingham WatchKit Extension
//
//  Created by Joseph Reddington on 15/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "InterfaceController.h"
#import "WorkNode.h"
#import "DoNode.h"
#import "QuestionNode.h"
#import "LogController.h"
#import "WatchConnectivity/WatchConnectivity.h"

@interface InterfaceController ()

@end


@implementation InterfaceController

int x = 0;
NSMutableArray * algorithmtree;
bool firsttime=TRUE;
WorkNode * root;
WorkNode * currentNode;
LogController * logger;


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
   // [local addStep: @"Kitc:Push Wash on"];
   // [local addStep: @"Kitc:Set Alarm for end of wash"];
    [local addStep: @"Kitc:Food prep"];
    DoNode *yesNode=[[DoNode alloc] initWithStep:@"Go to Doghouse"];
    DoNode *noNode=[[DoNode alloc] initWithStep:@"Then fix it"];
    QuestionNode *testQ=[[QuestionNode alloc] initWithQuestion: @"Is this a work day?" yesChild: noNode noChild:yesNode];
    
    NSLog(@"We have populated the algorithm tree");
    return local;
}



- (WorkNode *)questionTest {
    DoNode *local=[[DoNode alloc] initWithStep:@"Bathroom"];
    DoNode *yesNode=[[DoNode alloc] initWithStep:@"Then Celebrate"];
    DoNode *noNode=[[DoNode alloc] initWithStep:@"Then fix it"];
    QuestionNode *testQ=[[QuestionNode alloc] initWithQuestion: @"has this worked?" yesChild: noNode noChild:yesNode];
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



- (void)startCountdown {
    _targetTime = [NSDate dateWithTimeInterval:300 sinceDate:[NSDate date]];
    [self.joetimer setDate:_targetTime];
    [_joetimer start];
}

- (void)awakeWithContext:(id)context {
    NSLog(@"enter 'wake with context''");
    [super awakeWithContext:context];
    self.mylabel.text =@"98";
    
    [algorithmtree removeLastObject];
    int pickerValue=[context integerValue];
    self.mylabel.text=[NSString stringWithFormat:@"%d",pickerValue];
    // Configureinterface objects here.
    root = [self morning];
    if (pickerValue==0){
        root = [self morning];
    }
    if (pickerValue==1){
        root = [self night];
    }
    if (pickerValue==2){
        root = [self enterCoffeeShop];
    }
    if (pickerValue==3){
        root = [self questionTest];
    }
    
    [self startCountdown];
    logger=[[LogController alloc] init];

    
    currentNode=root;
    //    self.mylabel.text=currentNode.message;
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSLog(@"enter 'I will activate'");
    [self activateCurrentNode];
    NSLog(@"leave 'i will activate'");
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    

}





- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (void)activateCurrentNode {
    [logger writeLogWith: currentNode.message];
    if([currentNode isKindOfClass:[QuestionNode class]])
    {
        NSLog(@"It's a Question");
        QuestionNode * qn=(QuestionNode *)currentNode;
        if (qn.result==-1){//because it hasn't been asnswered{
            
            [self pushControllerWithName: @"QuestionController"  context: currentNode];
        }else if (qn.result==0){//no
            NSLog(@"Taken NO branch");

            currentNode=qn.elseChild;
            [self activateCurrentNode];
        }else {//yes
            currentNode=qn.child;
            [self activateCurrentNode];
        }
    }
    else{
        NSLog(@"It's a do");
        self.mylabel.text=currentNode.message;
        [self startCountdown];
    }
   
}

- (IBAction)Done {
    currentNode=currentNode.child;
    if (currentNode==NULL){
        self.mylabel.text=@"done";
    }else{
        [self activateCurrentNode];
        
    }
}

- (IBAction)Doneold {
    
    //TODO: if algoirthmtree is empty then display finnished.
    if(algorithmtree.count==0)
    {
        self.mylabel.text=@"done";
        
    }else{
        self.mylabel.text=[algorithmtree objectAtIndex:algorithmtree.count-1];
        [algorithmtree removeLastObject];
        [_joetimer stop];
        _targetTime = [NSDate dateWithTimeInterval:300 sinceDate:[NSDate date]];
        
        [self.joetimer setDate:_targetTime];
        
        [_joetimer start];
    }
}

- (IBAction)Expand {
}
- (IBAction)Problem {
    NSLog(@"Sending");
    NSLog([logger getLog ]);
    NSString *counterString = @"maybe now";
    NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[counterString] forKeys:@[@"counterValue"]];
    
    [[WCSession defaultSession] sendMessage:applicationData
                               replyHandler:^(NSDictionary *reply) {
                                   //handle reply from iPhone app here
                               }
                               errorHandler:^(NSError *error) {
                                   //catch any errors here
                               }
     ];
    NSLog(@"Sent");

}


@end



