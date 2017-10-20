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
#import "PickerNode.h"

@implementation FlowModel

WorkNode *activeNode;
NSMutableArray *saveNodes; /*this should be a stack*/

+ (id) coreBrain {
    //from http://www.galloway.me.uk/tutorials/singleton-classes/
    static FlowModel *sharedFlowModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFlowModel = [[self alloc] init];
        [self setup];
    });
    
    return sharedFlowModel;
}

+ (void) setup{
    activeNode=[[DoNode alloc] initWithStep:@"Get ready"];
    [activeNode addNode:[[PickerNode alloc] initWithDic: [self make_initial_menu]]];
  //  activeNode=[[PickerNode alloc] initWithDic: [self make_initial_menu]];
    saveNodes=[[NSMutableArray alloc] init];
    
}

+ (void) done{
    if(activeNode.child!=NULL){
     activeNode=activeNode.child;
    }else{
        /* need a guard in here*/
        activeNode=[saveNodes objectAtIndex:saveNodes.count-1];
        [saveNodes removeLastObject];
    }
}

+ (void) expand{
    DoNode *hope=activeNode;
    if (hope.expansion!=NULL){
    activeNode=hope.expansion;
    }
    else{
        NSLog(@"expand called in error");
    }
}

+ (BOOL) canExpand{
    DoNode *hope=activeNode;
    if (hope.expansion!=NULL){
        return TRUE;
    }
    else{
        return FALSE;
    }
}


+ (void) yes{
    if([activeNode isKindOfClass:[QuestionNode class]])
    {
        QuestionNode *temp = activeNode;
        activeNode=temp.elseChild;
    }
    else{
        NSLog(@"Error, 'yes' has been called on a non question node");
    }
}

+ (void) no{
    if([activeNode isKindOfClass:[QuestionNode class]])
    {
        activeNode=activeNode.child;

    }
    else{
        NSLog(@"Error, 'no' has been called on a non question node");
    }
}

+ (void) picked: (WorkNode*) input{
    activeNode=input;
}

+ (void) save{
    [saveNodes addObject:activeNode];
}

+ (void) problem{
    [self save];
    PickerNode *picker=[[PickerNode alloc] initWithDic: [self make_problem_menu]];
    activeNode=picker;
}


+ (NSString *) getMessage{
    return activeNode.message;
}

+ (WorkNode *) getNode{
    return activeNode;
}


+ (WorkNode *)email {
    DoNode *local=[[DoNode alloc] initWithStep:@"Open the inbox"];
    /* First pass*/
    [local addStep: @"1st pass: read, archive, transfer or unsubscribe"];
    [local addStep: @"Check that you didn't send anthing in the first pass"];

    [local addStep: @"Keystrokes - move responses to blog/wiki"];
    /* Only unsubscribe, archive, or transfer tasks*/
    [local addStep: @"2nd Pass: process the top email until there are none."];
    /*TODO: add a thing about the different types of email.*/
    /* Second pass */
    return local;
}


+ (WorkNode *)red_line {
    DoNode *local=[[DoNode alloc] initWithStep:@"Open next Actions"];
    /* First pass*/
    [local addStep: @"Check the prioirty of all the red tasks"];
    [local addStep: @"Move all the 5/and6 tasks to projects"];
    [local addStep: @"Draft text updating people on the the tasks"];
    [local addStep: @"Free up calendar time to work on next actions more"];
    return local;
}



+ (WorkNode *) nextAction {
    PickerNode *picker=[[PickerNode alloc] initWithDic: [self make_na_menu]];
    return picker;
    
}

+ (NSMutableDictionary *)make_na_menu {
    NSLog(@"making the menu");
    NSMutableDictionary *menu= [[NSMutableDictionary alloc] init];
    menu[@"Plan Day"  ] = [self plan_day];
    menu[@"Email"  ] = [self email];
    menu[@"Red Line"  ] = [self red_line];
    menu[@"Map Project"  ] = [self map_project];
    menu[@"Project work"  ] = [self work_on_project];
    menu[@"Project Review"  ] = [self project_review];
    menu[@"Clean the house"  ] = [self house_cleaning];
    menu[@"Meeting"] = [self meeting];
    return menu;
}



+ (NSMutableDictionary *)make_initial_menu {
    NSLog(@"making the menu");
    NSMutableDictionary *menu= [[NSMutableDictionary alloc] init];
    menu[@"Morning" ] = [self morning];
    menu[@"Night" ] = [self night] ;
    menu[@"Coffee Shop" ] = [self enterCoffeeShop];
    menu[@"Plan Day"  ] = [self plan_day];
    menu[@"Email"  ] = [self email];
    menu[@"Red Line"  ] = [self red_line];
    menu[@"Map Project"  ] = [self map_project];
    menu[@"Project Review"  ] = [self project_review];
    menu[@"Clean the house"  ] = [self house_cleaning];
    menu[@"Meeting"  ] = [self meeting];
    return menu;
}


+ (WorkNode *) interuption {
    PickerNode *picker=[[PickerNode alloc] initWithDic: [self make_interupt_menu]];
    return picker;
    
}

+ (NSMutableDictionary* )make_interupt_menu {
    NSMutableDictionary *menu= [[NSMutableDictionary alloc] init];
    menu[@"Phone call" ] = [[DoNode alloc] initWithStep:@"Rewrite Mrs Landingham to cover this"] ;
    menu[@"Food" ] = [[DoNode alloc] initWithStep:@"Rewrite Mrs Landingham to cover this instance." ];
    menu[@"Heart" ] = [[DoNode alloc] initWithStep:@"Rewrite Mrs Landingham to cover this"] ;
    return menu;
}



+ (NSMutableDictionary* )make_problem_menu {
    NSMutableDictionary *menu= [[NSMutableDictionary alloc] init];
    //This is far all the times when I reach a step and feel like doing something else.
    menu[@"I feel resistence" ] = [[DoNode alloc] initWithStep:@"Write down the smallest physical step on the notes file"] ;
    /*This is simply to keep me going and focused on the details */
    menu[@"Other" ] = [[DoNode alloc] initWithStep:@"Rewrite Mrs Landingham to cover this instance." ];
    /*Needed during the overall process of building and modifying the algorithm */
    menu[@"Today is different" ] = [[DoNode alloc] initWithStep:@"Post to Social, then act as if done."] ;
    /*Sometimes I feel like 'not today', which is fine, as long as I can admit it on social media. */
    menu[@"Made progress and want to rewrite." ] = [[DoNode alloc] initWithStep:@"Keep working, write the smallest action."];
    /* Sometimes I think "i've given this a fair whack, let's do something else".  But if we're working in prioity order, I'm working on the most important thing, so I should keep working on that*/
    menu[@"Cron Needs a resource" ] = [[DoNode alloc] initWithStep:@"Order it online, mark as done"];
    /* For things like floss and other things we're I'm like, oh, I need to buy something before that*/
   
    
    menu[@"Interuption" ] = [self interuption];
    menu[@"Two tasks in a row" ] = [[DoNode alloc] initWithStep:@"Rewrite Mrs Landingham to cover this two in a row."];
    /* These things need answers... */
    return menu;
}


+ (WorkNode *) clean_bathroom {
     DoNode *local=[[DoNode alloc] initWithStep:@"Pee"];
    [local addStep: @"Put bleach in toilet"];
    [local addStep: @"Replace towels"];
    [local addStep: @"Sink items into bath"];
    [local addStep: @"Get Pink dustclothe"];
    [local addStep: @"Wipe tops of toliet, tiles, and roll holder"];
    [local addStep: @"Clean mirrors"];
    return local;
}

+ (WorkNode *)expansion_test {
    DoNode *local=[[DoNode alloc] initWithStep:@"Replace bathroom bin"];
    [local addStep: @"Empty Recycling"];
    [local addStep: @"Empty rubbish bin"];
    [local addStep: @"Do all three bin liners" ];
    [local addStep: @"Laundary Box - take things into the right room" ];
    [local addStep: @"Bathroom" with:[self clean_bathroom]];
    [local addStep: @"Bedroom"];
    [local addStep: @"Strip sheets, put in washing machine"];
    [local addStep: @"New sheets on bed"];
    [local addStep: @"All bedside stuff on bed"];
    [local addStep: @"Don't be pooky"];
    [local addStep: @"Wipe bedside tablets and window sill"];
    [local addStep: @"Clean bedroom mirros"];
    [local addStep: @"Arrange sofa cusions"];
    [local addStep: @"Fold blankets"];
    [local addStep: @"Clean ash from fire"];
    return local;
}



+ (WorkNode *)house_cleaning {
    DoNode *local=[[DoNode alloc] initWithStep:@"Replace bathroom bin"];
    [local addStep: @"Empty Recycling"];
    [local addStep: @"Empty rubbish bin"];
    [local addStep: @"Do all three bin liners" ];
    [local addStep: @"Laundary Box - take things into the right room" ];
    [local addStep: @"Bathroom"];
    [local addStep: @"Pee"];
    [local addStep: @"Put bleach in toilet"];
    [local addStep: @"Replace towels"];
    [local addStep: @"Sink items into bath"];
    [local addStep: @"Get Pink dustclothe"];
    [local addStep: @"Wipe tops of toliet, tiles, and roll holder"];
    [local addStep: @"Clean mirrors"];
    [local addStep: @"Bedroom"];
    [local addStep: @"Strip sheets, put in washing machine"];
    [local addStep: @"New sheets on bed"];
    [local addStep: @"All bedside stuff on bed"];
    [local addStep: @"Don't be pooky"];
    [local addStep: @"Wipe bedside tablets and window sill"];
    [local addStep: @"Clean bedroom mirros"];
    [local addStep: @"Arrange sofa cusions"];
    [local addStep: @"Fold blankets"];
    [local addStep: @"Clean ash from fire"];
    [local addStep: @"Clean mirror and tv"];
    [local addStep: @"Wipe table"];
    [local addStep: @"Scrub sink"];
    [local addStep: @"Wipe edge of bath"];
    [local addStep: @"wipe top of toilet (again)"];
    [local addStep: @"rince cloth"];
    [local addStep: @"wipe next bit of toilet"];
    [local addStep: @"rince cloth"];
    [local addStep: @"wipe next bit of toilet"];
    [local addStep: @"rince cloth again"];
    [local addStep: @"Put bin on side of bath (for hoovering)"];
    [local addStep: @"Put wash on line"];
    [local addStep: @"throw out any old fruit in basket"];
    [local addStep: @"rince both parts of compost bin"];
    [local addStep: @"shot glass of bleech in compost bleech"];
    [local addStep: @"compost bin outside"];
    [local addStep: @"Washing up"];
    [local addStep: @"clear away everything on the drainer"];
    [local addStep: @"wipe down drainer"];
    [local addStep: @"spray kitchen cleaner on drainer"];
    [local addStep: @"put dirtest item in sink to soak"];
    [local addStep: @"turn on hot top"];
    [local addStep: @"wash cleanest item"];
    [local addStep: @"put sponge in microwave 60 sec"];
    [local addStep: @"clean surfaces"];
    [local addStep: @"Get vacume"];
    [local addStep: @"Longue, including moving table and chairs"];
    [local addStep: @"Bedroom"];
    [local addStep: @"Hall, inc shared with S&C"];
    [local addStep: @"Bathroom"];
    [local addStep: @"Kitchen inc mat"];
    [local addStep: @"Use vaccuum extension"];
    [local addStep: @"sirting boards including behind doors."];
    [local addStep: @"under stove"];
    [local addStep: @"around wood pile"];
    [local addStep: @"floorboards under sofa"];
    [local addStep: @"Gooves of hall cuboards"];
    [local addStep: @"behind sink and toilet"];
    [local addStep: @"bedhind bedside table"];
    [local addStep: @"edges in kitchen"];
    [local addStep: @"Mopping"];
    [local addStep: @"Run hot tab in bath"];
    [local addStep: @"teaspoons-woth of bleech in bucket"];
    [local addStep: @"Half fill bucket"];
    [local addStep: @"Mop kitchen, bathroom and hallway"];
    return local;
}




+ (WorkNode *)map_project {
    DoNode *local=[[DoNode alloc] initWithStep:@"Create Issue"];
    [local addStep: @"Write down SMART goal"];
    [local addStep: @"Write down WHY you do it"];
    [local addStep: @"Write down a list of steps to take(not in order)" ];
     [local addStep: @"Think about the TAS version" ];
     [local addStep: @"Put it in the projects list and assign"];
     [local addStep: @"Write down the next action" ];
    return local;
}

+ (WorkNode *)setup_doghouse {
    DoNode *local=[[DoNode alloc] initWithStep:@"Setup laptop"];
    [local addStep: @"Get water bottle"];
    [local addStep: @"Put Phone on charge"];
    [local addStep: @"Tell phone Instramental music" ];
    [local addStep: @"Put everything on one side of the desk and process it" ];
    return local;
}


+ (WorkNode *)project_review {
    DoNode *local=[[DoNode alloc] initWithStep:@"Check and respond to project notifications."];
    [local addStep: @"Open EQT Projects Board"];
    [local addNode:[self project_normal_form]];
    [local addStep: @"Open Personal Projects Board"];
    [local addNode:[self project_normal_form]];
    return local;
    
}

+ (WorkNode *)project_normal_form {
    DoNode *local=[[DoNode alloc] initWithStep:@"Make sure all issues have been imported to the board."];
    [local addStep: @"Removed closed issues"];
    [local addStep: @"Check that every card is assigned"];
    QuestionNode *start=[[QuestionNode alloc] initLoop: @"Are there any unprocessed projects?" yesChild: [self check_project]];
    [local addNode:start];
    [local addStep:@"All done. Take a breath"];
    return local;
    
}

+ (WorkNode *)check_project {
    QuestionNode *start=[[QuestionNode alloc] initBranch: @"Does it need mapping?" yesChild: [self map_project]];
    [start addStep: @"Check it has the right priority"];
    [start addStep: @"Check it has a next action"];
    [start addStep: @"Check there is a next action in melta"];
    return start;
}

+ (WorkNode *)work_on_project {
    DoNode *local=[[DoNode alloc] initWithStep:@"Remap it"];
    QuestionNode *start=[[QuestionNode alloc] initLoop: @"Is there an obvious next action?" yesChild: [[DoNode alloc] initWithStep:@"Do it"]];
    [local addNode:start];
    [local addStep: @"Define a next action."];
    
    return start;
}


+ (WorkNode *) melta_normal_form {
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

+ (WorkNode *)start_laptop {
    DoNode *local=[[DoNode alloc] initWithStep:@"Open livenotes, make an entry"];
    [local addStep: @"Open Prioirty and Time Chart (for flow)"];
    [local addStep: @"Close other programs (not terminal)"];
    [local addStep: @"Put the thing you are most worried abotu in next actions"];
    [local addNode:[self melta_normal_form]];
    return local;
}

+ (WorkNode *)alarm_has_gone_off {
    DoNode *local=[[DoNode alloc] initWithStep:@"Stand up"];
    [local addStep: @"Write the 'context stack' down on a log if you have one"];
    [local addStep: @"Do the thing"];
    return local;
}

+ (DoNode *)process_apointment {
  DoNode *yesNode=[[DoNode alloc] initWithStep:@"Change to Skype"];
    [yesNode addStep: @"Change to Skype"];
    [yesNode addStep: @"Think of a way to make it awesome"];
    [yesNode addStep: @"Email/call to confirm"];
    [yesNode addStep: @"Add any tasks about appointment"];//which wil have prioirt 0 and happen first
    [yesNode addStep: @"Set Alarm for travel"];
  return yesNode;
}

+ (WorkNode *)plan_day {
    QuestionNode *start=[[QuestionNode alloc] initLoop: @"Are there any unprocessed apointments (72 hours)?" yesChild: [self process_apointment]];
    [start addStep: @"Set Alarm for exercise"];
    [start addStep: @"Set Alarm for email"];
    [start addStep: @"Set Alarm for food"];
    [start addStep: @"Check for redline protocal"];
    return start;
}



+ (WorkNode *)morning {
    DoNode *local=[[DoNode alloc] initWithStep:@"Exercise"];
    [local addStep: @"Morning Bathroom" with:[self morning_bathroom]];
    [local addStep: @"Kitc: clothes in wash"];
    [local addStep: @"Kitc:Vitimin Tablet"];
 //   [local addStep: @"Kitc:Make Tea"];
    [local addStep: @"Go To Doghouse"];
    [local addStep: @"Setup Doghouse" with:[self setup_doghouse]];
    [local addStep: @"Setup Laptop" with:[self start_laptop]];
    [local addStep: @"Plan Day" with:[self plan_day]];
    [local addStep: @"Move heartrate from phone to dropbox"];
    QuestionNode *start=[[QuestionNode alloc] initLoop: @"Is there a next action to do?" yesChild: [self nextAction]];
    [local addNode:start];
//ends here.
    
    return local;
}

+ (WorkNode *) morning_bathroom{
    DoNode *local=[[DoNode alloc] initWithStep:@"Bathroom"];
    [local addStep: @"Bath: shower"];
    [local addStep: @"Bath: deodorant"];
    [local addStep: @"Bath: Dress"];
    [local addStep: @"Bath: exfoliate"];
    [local addStep: @"Bath: consider face strip"];
    [local addStep: @"Bath: shave"];
    [local addStep: @"Bath: shave head"];
    [local addStep: @"Bath: teeth"];
    [local addStep: @"Bath: floss"];
    return local;
}


+ (WorkNode *) enterCoffeeShop{
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

+ (WorkNode *) night{
    DoNode *local=[[DoNode alloc] initWithStep:@"Bed: Get tomorrow's clothes from bedroom"];
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
    [local addStep: @"Kitch:Headphones on charge"];
    [local addStep: @"Kitch:Sleep mask on head"];
    [local addStep: @"Kitch:What is the next thing in the memory palace?"];
    [local addStep: @"Kitch:Lights out"];
    [local addStep: @"Kitch:watch on charge"];
    return local;
    
}

+ (WorkNode *) meeting{
    DoNode *local=[[DoNode alloc] initWithStep:@"Find out other people's ending time"];
    [local addStep: @"Quietly set alarm for ending time"];
    [local addStep: @"I don't know if there is an adenda, I have some things to add"];
    [local addStep: @"Move on when there is a next action only"];
    [local addStep: @"Be Patient"];
    [local addStep: @"Be Patient"];
    [local addStep: @"Be Patient"];
    [local addStep: @"Be Patient"];
    return local;
    
}






@end
