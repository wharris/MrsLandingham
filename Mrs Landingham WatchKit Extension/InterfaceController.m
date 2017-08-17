//
//  InterfaceController.m
//  Mrs Landingham WatchKit Extension
//
//  Created by Joseph Reddington on 15/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController ()

@end

int x = 0;
NSMutableArray * algorithmtree;
bool firsttime=TRUE;


@implementation InterfaceController


- (void) do: (NSString *) task {
    [algorithmtree insertObject:task atIndex:0];
}

- (void)morning {
  algorithmtree = [[NSMutableArray alloc] init];
    [self do: @"Bathroom"];
    [self do: @"Bath: Drink 1L Water" ];
    [self do: @"Bath: Shower"];
    [self do: @"Bath: Dress"];
    [self do: @"Bath: Teeth"];
    [self do: @"Bath: Floss"];
    [self do: @"Bath: Shave head"];
    [self do: @"Bath: Shave"];
    [self do: @"Kitc: clothes in wash"];
    [self do: @"Kitc:Vitimin Tablet"];
    [self do: @"Kitc:Make Tea (get washing)"];
    [self do: @"Kitc:Push Wash on"];
    [self do: @"Kitc:Set Alarm for end of wash"];
    [self do: @"Kitc:Food prep"];
    NSLog(@"We have populated the algorithm tree");
}

- (void) night{
    algorithmtree = [[NSMutableArray alloc] init];
    [self do: @"Laptop on charge"];//so you know you don't have to go to the shed
    [self do: @"Glasses in Ospray"];
    [self do: @"Headphones on charge"];
    [self do: @"Night Glasses On"];
    [self do: @"Lock Door"];
    [self do: @"Put glass in bathroom"];
    [self do: @"Teeth"];
    [self do: @"Floss"];
    [self do: @"Leave good clothes in bathroom"];
    [self do: @"otherclothes in washing machine"];
    [self do: @"Get tomorrow's clothes from bedroom"];
    [self do: @"Keys in bag"];
    [self do: @"Wallet has two bank cards"];
    [self do: @"Phone on charge"];
    [self do: @"Food in bag"];
    [self do: @"Bike lights"];
    [self do: @"Pens and notebook in bag"];
    [self do: @"Spare battery"];
    [self do: @"Other battery on charge"];
    [self do: @"MacBook charger"];
    [self do: @"folding plug"];
     [self do: @"Seal bag"];
     [self do: @"Setup tea and water bottles"];
    [self do: @"Sleep mask on head"];
     [self do: @"Lights out"];
     [self do: @"watch on charge"];
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
    if (pickerValue==0){
        [self morning];
    }
    if (pickerValue==1){
        [self night];
    }
    
    [self startCountdown];
    
    self.mylabel.text=[algorithmtree objectAtIndex:algorithmtree.count-1];
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



