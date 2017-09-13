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
#import "PickerController.h"

@implementation FlowModel{
    NSMutableArray * pickerItems;
    NSMutableArray * workNodeItems;
}




- (WorkNode *)email {
    DoNode *local=[[DoNode alloc] initWithStep:@"Open the inbox"];
    /* First pass*/
    [local addStep: @"1st pass: read, archive, transfer or unsubscribe"];
    [local addStep: @"Check that you didn't send anthing in the first pass"];

    /* Only unsubscribe, archive, or transfer tasks*/
    [local addStep: @"2nd Pass: process the top email until there are none."];
    /*TODO: add a thing about the different types of email.*/
    /* Second pass */
    return local;
}


- (WorkNode *)red_line {
    DoNode *local=[[DoNode alloc] initWithStep:@"Open next Actions"];
    /* First pass*/
    [local addStep: @"Check the prioirty of all the red tasks"];
    [local addStep: @"Move all the 5/and6 tasks to projects"];
    [local addStep: @"Draft text updating people on the the tasks"];
    [local addStep: @"Free up calendar time to work on next actions more"];
    return local;
}




/* TODO: Move this to super class */

- (void) makeItemWith: (NSString *) input startNode: (WorkNode *) startNode {
    WKPickerItem *pickerItem4 = [WKPickerItem alloc];
    [pickerItem4 setTitle:input];
    [pickerItem4 setAccessoryImage:[WKImage imageWithImageName:@"Smile"]];
    [pickerItems addObject: pickerItem4 ];
    [workNodeItems addObject: startNode];
}

/* TODO: Move this to super class */
- (WorkNode *) getWorkNodeAt: (int) input {
    return [workNodeItems objectAtIndex: input];
}

- (void)make_initial_menu {
    pickerItems = [[NSMutableArray alloc] init];
    workNodeItems = [[NSMutableArray alloc] init];
    [self makeItemWith:@"Morning" startNode: [self morning] ];
    [self makeItemWith:@"Night" startNode: [self night]] ;
    [self makeItemWith:@"Coffee Shop" startNode: [self enterCoffeeShop] ];
    [self makeItemWith:@"Question Test" startNode: [self questionTest]];
    [self makeItemWith:@"Plan Day"  startNode: [self plan_day]];
    [self makeItemWith:@"Email"  startNode: [self email]];
    [self makeItemWith:@"Red Line"  startNode: [self red_line]];
    [self makeItemWith:@"Map Project"  startNode: [self map_project]];
    [self makeItemWith:@"Project Review"  startNode: [self project_review]];

}


- (void)make_problem_menu {
    pickerItems = [[NSMutableArray alloc] init];
    workNodeItems = [[NSMutableArray alloc] init];
    
    //This is far all the times when I reach a step and feel like doing something else.
    [self makeItemWith:@"I feel resistence" startNode: [[DoNode alloc] initWithStep:@"Write down the smallest physical step on the notes file"] ];
    /*This is simply to keep me going and focused on the details */
    [self makeItemWith:@"Other" startNode: [[DoNode alloc] initWithStep:@"Rewrite Mrs Landingham to cover this instance."] ];
    /*Needed during the overall process of building and modifying the algorithm */
    [self makeItemWith:@"Today is different" startNode: [[DoNode alloc] initWithStep:@"Post to Social, then act as if done."] ];
    /*Sometimes I feel like 'not today', which is fine, as long as I can admit it on social media. */
    [self makeItemWith:@"Made progress and want to rewrite." startNode: [[DoNode alloc] initWithStep:@"Keep working, write the smallest action."] ];
    /* Sometimes I think "i've given this a fair whack, let's do something else".  But if we're working in prioity order, I'm working on the most important thing, so I should keep working on that*/
    [self makeItemWith:@"Cron Needs a resource" startNode: [[DoNode alloc] initWithStep:@"Order it online, mark as done"] ];
    /* For things like floss and other things we're I'm like, oh, I need to buy something before that*/
    
    
    [self makeItemWith:@"Interuption" startNode: [[DoNode alloc] initWithStep:@"Rewrite Mrs Landingham to cover this interuptions."] ];
    [self makeItemWith:@"Two tasks in a row" startNode: [[DoNode alloc] initWithStep:@"Rewrite Mrs Landingham to cover this two in a row."] ];
    /* These things need answers... */
}



- (WorkNode *)map_project {
    DoNode *local=[[DoNode alloc] initWithStep:@"Create Issue"];
    [local addStep: @"Write down SMART goal"];
    [local addStep: @"Write down WHY you do it"];
    [local addStep: @"Write down a list of steps to take(not in order)" ];
     [local addStep: @"Think about the TAS version" ];
     [local addStep: @"Put it in the projects list and assign"];
     [local addStep: @"Write down the next action" ];
    return local;
}

- (WorkNode *)setup_doghouse {
    DoNode *local=[[DoNode alloc] initWithStep:@"Setup laptop"];
    [local addStep: @"Get water bottle"];
    [local addStep: @"Put Phone on charge"];
    [local addStep: @"Tell phone Instramental music" ];
    [local addStep: @"Put everything on one side of the desk and process it" ];
    return local;
}





- (WorkNode *)project_review {
    DoNode *local=[[DoNode alloc] initWithStep:@"Check and respond to project notifications."];
    [local addStep: @"Open EQT Projects Board"];
    [local addNode:[self project_normal_form]];
    [local addStep: @"Open Personal Projects Board"];
    [local addNode:[self project_normal_form]];
    return local;
    
}

- (WorkNode *)project_normal_form {
    DoNode *local=[[DoNode alloc] initWithStep:@"Make sure all issues have been imported to the board."];
    [local addStep: @"Removed closed issues"];
    [local addStep: @"Check that every card is assigned"];
    
    DoNode *yesNode=[[DoNode alloc] initWithStep:@"Check project is mapped."];
    [yesNode addStep: @"Check it has the right priority"];
    [yesNode addStep: @"Check there is a next action in melta"];
    DoNode *noNode=[[DoNode alloc] initWithStep:@"All done. Take a breath"];
    
    return local;
    
}




- (NSMutableArray*) getPickerItems{
    return pickerItems;
    
    
}

- (WorkNode *) melta_normal_form {
    DoNode *local=[[DoNode alloc] initWithStep:@"Process reminders"];
    [local addStep: @"Add tasks from phone screenshots."];
    [local addStep: @"Check Voicemail and add any messages to Tasks."];
    [local addStep: @"Check notebook/brainstorms for tasks"];
    [local addStep: @"Sort the next actions file alphabetically, this will put the least defined tasks at the top."];
    [local addStep: @"Fill in the priority, and time (mark off done tasks)"];
    [local addStep: @"Messsage Kat a list of the ones relevent to her"];
    [local addStep: @"Note now much time for the full list"];
    [local addStep: @"Do any tasks that take less than five minutes (morning power hour!)"];
    [local addStep: @"Check if some tasks have already been done"];
    [local addStep: @"Rewrite tasks thinking about how public they are"];
    [local addStep: @"Go thought all tasks and adjust the deadline for an urgent ones"];    return local;
}

- (WorkNode *)start_laptop {
    DoNode *local=[[DoNode alloc] initWithStep:@"Open Jurgen and livenotes"];
    [local addStep: @"Open Prioirty and Time Chart (for flow)"];
    [local addStep: @"Close other programs (not terminal)"];
    [local addStep: @"Put Bank Balance on livenotes"];
    [local addStep: @"Put the thing you are most worried abotu in next actions"];
    [local addNode:[self melta_normal_form]];
    return local;
}

- (WorkNode *)alarm_has_gone_off {
    DoNode *local=[[DoNode alloc] initWithStep:@"Stand up"];
    [local addStep: @"Write the 'context stack' down on a log if you have one"];
    [local addStep: @"Do the thing"];
    return local;
}

- (WorkNode *)plan_day {
    DoNode *local=[[DoNode alloc] initWithStep:@"Open Calendar"];
    
    DoNode *yesNode=[[DoNode alloc] initWithStep:@"Change to Skype"];
    [yesNode addStep: @"Change to Skype"];
    [yesNode addStep: @"Think of a way to make it awesome"];
    [yesNode addStep: @"Add any tasks about appointment"];//which wil have prioirt 0 and happen first
    [yesNode addStep: @"Set Alarm for travel"];
    
    DoNode *noNode=[[DoNode alloc] initWithStep:@"Set Alarm for exercise"];
    [noNode addStep: @"Set Alarm for email"];
    [noNode addStep: @"Set Alarm for food"];
    
    
    QuestionNode *start=[[QuestionNode alloc] initWithQuestion: @"Are there any unprocessed apointments?"
                                                      yesChild: yesNode noChild:noNode];
    [yesNode addNode: start];
    
    [local addNode:start];
    return local;
}



- (WorkNode *)morning {
    DoNode *local=[[DoNode alloc] initWithStep:@"Exercise"];
    [local addStep: @"Bathroom" ];
    [local addStep: @"Bath: Shower"];
    [local addStep: @"Bath: Dress"];
    [local addStep: @"Bath: Exfoliate"];
    [local addStep: @"Bath: Consider face strip"];
    [local addStep: @"Bath: Shave"];
    [local addStep: @"Bath: Shave head"];
    [local addStep: @"Bath: Teeth"];
    [local addStep: @"Bath: Floss"];
    [local addStep: @"Kitc: clothes in wash"];
    [local addStep: @"Kitc:Vitimin Tablet"];
    [local addStep: @"Kitc:Make Tea"];
    [local addStep: @"Go To Doghouse"];
    [local addNode: [self setup_doghouse]];
    [local addNode: [self start_laptop]];
    [local addNode: [self plan_day]];
    [local addStep: @"Work on next actions"];
//ends here.
    
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
    DoNode *local=[[DoNode alloc] initWithStep:@"Bed: Get tomorrow's clothes from bedroom"];
    
    [local addStep: @"Bed:Headphones on charge"];
    [local addStep: @"Bed:Other battery on charge"];
    [local addStep: @"FR:Empty Ospray of everything and put in shed bag"];
    [local addStep: @"FR:Glasses in Ospray"];
    [local addStep: @"FR:Keys in bag"];
    [local addStep: @"FR:Wallet has two bank cards"];
    [local addStep: @"FR:Laptop on charge"];
    [local addStep: @"FR:Phone on charge"];
    [local addStep: @"Kitch:Food in bag"];
    [local addStep: @"FR:Bike lights"];
    [local addStep: @"FR:Pens and notebook in bag"];
    [local addStep: @"FR: Spare battery"];
    [local addStep: @"FR:MacBook charger"];
    [local addStep: @"FR:folding plug"];
    [local addStep: @"FR:Seal bag"];
    [local addStep: @"Bath: Teeth"];
    [local addStep: @"Bath:Leave good clothes in bathroom"];
    [local addStep: @"Kitch:otherclothes in washing machine"];
    [local addStep: @"Kitch:Lock Door"];
    [local addStep: @"Kitch:Setup tea and water bottles"];
    [local addStep: @"Kitch:Sleep mask on head"];
    [local addStep: @"Kitch:What is the next thing in the memory palace?"];
    [local addStep: @"Kitch:Lights out"];
    [local addStep: @"Kitch:watch on charge"];
    return local;
    
}



@end
