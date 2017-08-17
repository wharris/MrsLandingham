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
@interface InterfaceController ()

@end

int x = 0;
NSMutableArray * algorithmtree;
bool firsttime=TRUE;
WorkNode * root;
WorkNode * currentNode;

@implementation InterfaceController


- (void) do: (NSString *) task {
    [algorithmtree insertObject:task atIndex:0];
}

- (WorkNode *)morning {
    DoNode *local=[[DoNode alloc] initWithStep:@"Bathroom"];
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
    [local addStep: @"Kitc:Push Wash on"];
    [local addStep: @"Kitc:Set Alarm for end of wash"];
    [local addStep: @"Kitc:Food prep"];
    QuestionNode *testQ=[[QuestionNode alloc] initWithQuestion: @"has this worked" yesChild: NULL noChild:NULL];
    [local addNode:testQ];
    [local addStep: @"now?"];
    

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
    [local addStep: @"Put glass in bathroom"];
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
    
    [self startCountdown];
    
    self.mylabel.text=[algorithmtree objectAtIndex:algorithmtree.count-1];
    
    
    ///Sandbox
    
    
    currentNode=root;
    self.mylabel.text=currentNode.message;
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSLog(@"it Visible have worked");
   
    
}





- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)Done {
    currentNode=currentNode.child;
    
    if (currentNode==NULL){
        self.mylabel.text=@"done";
    }else{
        self.mylabel.text=currentNode.message;
        [self startCountdown];
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
}


@end



