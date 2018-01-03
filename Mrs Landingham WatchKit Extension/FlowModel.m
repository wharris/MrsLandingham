    //
//  FlowModel.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 27/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
// TODOs:
// Take the algorithms into a superclass, or another class at least.
// Make the menus all return a picker node rather than a dictionary.

#import "FlowModel.h"
#import "WorkNode.h"
#import "DoNode.h"
#import "QuestionNode.h"
#import "PickerController.h"
#import "PickerNode.h"

@implementation FlowModel

WorkNode *activeNode;
NSMutableArray *saveNodes; /*this should be a stack*/

+ (int) getTime{
    if (activeNode.timeallowed != NULL)
        return activeNode.timeallowed;
    return 200;
}


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
    activeNode=[[DoNode alloc] initStep:@"Deep breath" withTime: 5];
    [activeNode addNode:[[PickerNode alloc] initWithDic: [self make_initial_menu]]];
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
    //We should do this: https://stackoverflow.com/a/24500696/170243
    //In practice - WorkNode has an 'expand' that gives an error, and Do note overrides it.
    DoNode *hope=activeNode;
    if (hope.expansion!=NULL){
    activeNode=hope.expansion;
    }
    else{
        NSLog(@"expand called in error");
    }
}

+ (BOOL) canExpand{
    //We should do this: https://stackoverflow.com/a/24500696/170243
    //In practice - WorkNode has an 'expand' that gives an error, and Do note overrides it.
    DoNode *hope=activeNode;
    if (hope.expansion!=NULL){
        return TRUE;
    }
    else{
        return FALSE;
    }
}


+ (void) yes{
    //We should do this: https://stackoverflow.com/a/24500696/170243
    //In practice - WorkNode has an 'yes' that gives an error, and question node overrides it. 
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
    PickerNode *picker=[[PickerNode alloc] initWithDic: [self make_exception_menu]];
    activeNode=picker;
}



+ (void) spider{
    NSLog(@"%@", activeNode);
}


+ (NSString *) getMessage{
    return activeNode.message;
}

+ (WorkNode *) getNode{
    return activeNode;
}




+ (WorkNode *)badfoodchoices {
    DoNode *local=[[DoNode alloc] initStep:@"Stop chewing"];
   /*  Leave house and go and buy fruit.  Fruit is fine.  Also buy nuts of a type you haven't had in a while.
    Drink a full liter of water.
    Prepare the food for the next meal now.
    */
    return local;
}


+ (WorkNode *)email {
    DoNode *local=[[DoNode alloc] initStep:@"Open the inbox"];
    /* First pass*/
    [local addStep: @"1st pass: read, archive, transfer or unsubscribe"];
    [local addStep: @"Check that you didn't send anthing in the first pass"];
    [local addStep: @"Send confirmations about meetings tomorrow."];
    [local addStep: @"Keystrokes - move responses to blog/wiki"];
    /* Only unsubscribe, archive, or transfer tasks*/
    [local addStep: @"2nd Pass: process the top email until there are none."];
    
    /*TODO: add a thing about the different types of email.*/
    /* Second pass */
    return local;
}



+ (WorkNode *)climbing {
    /* written for bouldering first */
    DoNode *local=[[DoNode alloc] initStep:@"5minutes - Warm up skipping"];
    [local addStep: @"Streaching >5min include glutes"];
    [local addStep: @"More warmup - Chinups"];
    [local addStep: @"Find a problem you have done before and warm up on it a couple of times."];
    [local addStep: @"Pick a new problem."];
    [local addStep: @"Work out the hand sequence."];
    [local addStep: @"Do it."];
    [local addStep: @"Do it again."];
    [local addStep: @"and again."];
    [local addStep: @"find another project."];
    /*TODO: add a thing about the different types of email.*/
    /* Second pass */
    return local;
}

+ (WorkNode *)red_line {
    DoNode *local=[[DoNode alloc] initStep:@"Open next Actions"];
    /* First pass*/
    [local addStep: @"Check the prioirty of all the red tasks"];
    [local addStep: @"Move all the 5/and6 tasks to projects"];
    [local addStep: @"Draft text updating people on the the tasks"];
    [local addStep: @"Free up calendar time to work on next actions more"];
    return local;
}



+ (WorkNode *) nextAction {
    NSMutableDictionary *menu= [[NSMutableDictionary alloc] init];
    menu[@"Plan Day"  ] = [self plan_day];
    menu[@"Email"  ] = [self email];
    menu[@"Red Line"  ] = [self red_line];
    menu[@"Map Project"  ] = [self map_project];
    menu[@"Project sprint"  ] = [self project_sprint];
    menu[@"Project Review"  ] = [self project_review];
    menu[@"Clean the house"  ] = [self house_cleaning];
    menu[@"Meeting"] = [self meeting];
    menu[@"Simple Task"]=[[DoNode alloc] initStep:@"Do the task"];
    menu[@"Other"]=[[DoNode alloc] initStep:@"Extend Mrs Landingham for this. "];
    menu[@"0-priority task"]=[[DoNode alloc] initStep:@"Rewrite task and sort again"];
    menu[@"Map Project"  ] = [self map_project];
    menu[@"Project Review"  ] = [self project_review];
    PickerNode *picker=[[PickerNode alloc] initWithDic: menu];
    return picker;
    
}


+ (WorkNode *) exercise_menu {
    PickerNode *picker=[[PickerNode alloc] initWithDic: [self exercise]];
    return picker;
    
}



+ (NSMutableDictionary *)make_initial_menu {
    //should only be thinks that aren't in 'next actions' sometimes.
    NSLog(@"making the menu");
    NSMutableDictionary *menu= [[NSMutableDictionary alloc] init];
    menu[@"Full Day" ] = [self morning];
    menu[@"Night" ] = [self night] ;
    menu[@"Coffee Shop" ] = [self enterCoffeeShop];
    menu[@"Email"  ] = [self email];
    menu[@"Clean the house"  ] = [self house_cleaning];
    menu[@"Meeting"  ] = [self meeting];
    menu[@"Next actions"  ] =  [[QuestionNode alloc] initLoop: @"Is there a next action to do?" yesChild: [self nextAction]];
    menu[@"Alarm goes off" ] = [self alarm_has_gone_off];
    menu[@"Climbing" ] = [self climbing];
    return menu;
}


+ (WorkNode *) interuption {
    PickerNode *picker=[[PickerNode alloc] initWithDic: [self make_interupt_menu]];
    return picker;
    
}

+ (NSMutableDictionary* )make_interupt_menu {
    NSMutableDictionary *menu= [[NSMutableDictionary alloc] init];
    menu[@"Phone call" ] = [self phone_in] ;
    menu[@"Heart" ] = [[DoNode alloc] initStep:@"Listen to he  r and do what she says" with:[self heart_interupt]] ;
    menu[@"Message" ] = [[DoNode alloc] initStep:@"Triage: do, or holding reply and action"] ;
    return menu;
}



+ (NSMutableDictionary* )exercise {
    NSMutableDictionary *menu= [[NSMutableDictionary alloc] init];
    menu[@"Cycling" ] = [[DoNode alloc] initStep:@"Cycling" with:[self home_workout]];
    menu[@"Climbing" ] = [[DoNode alloc] initStep:@"Climbing." with:[self climbing] ];
    menu[@"Push/Pull ups" ] = [[DoNode alloc] initStep:@"Write push/pull-ups algorithm"] ;
    return menu;
}


+ (NSMutableDictionary* )make_exception_menu {
    NSMutableDictionary *menu= [[NSMutableDictionary alloc] init];
    //This is far all the times when I reach a step and feel like doing something else.
    menu[@"I feel resistence" ] = [[DoNode alloc] initStep:@"Write down the smallest physical step on the notes file"] ;
    /*This is simply to keep me going and focused on the details */
    menu[@"Today is different" ] = [[DoNode alloc] initStep:@"Post to Social, then act as if done."] ;
    /*Sometimes I feel like 'not today', which is fine, as long as I can admit it on social media. */
    menu[@"Made progress and want to rewrite." ] = [[DoNode alloc] initStep:@"Keep working, write the smallest action."];
    /* Sometimes I think "i've given this a fair whack, let's do something else".  But if we're working in prioity order, I'm working on the most important thing, so I should keep working on that*/
    menu[@"Cron Needs a resource" ] = [[DoNode alloc] initStep:@"Order it online, mark as done"];
    /* For things like floss and other things we're I'm like, oh, I need to buy something before that*/
    menu[@"This tasks needs email" ] = [[DoNode alloc] initStep:@"Write as much of it as you can, and then put an event in the calendar"];
    menu[@"Getting food?" ] = [[DoNode alloc] initStep:@"Small, slow, bites and leave some"];
    menu[@"Unplanned Interuption" ] = [self interuption];
    menu[@"Alarm goes off" ] = [self alarm_has_gone_off];
    menu[@"Two tasks in a row" ] = [[DoNode alloc] initStep:@"Rewrite Mrs Landingham to cover this two in a row."];
    menu[@"I don't know why I should do this" ] = [[DoNode alloc] initStep:@"Remember this was writen by you in a good place."];
    menu[@"Waiting for a resource" ] = [[DoNode alloc] initStep:@"Tidy things up while you wait"];
    menu[@"Small handy task" ] = [[DoNode alloc] initStep:@"300 seconds on it..."] ;
    menu[@"Other: DELORES is incomplete" ] = [[DoNode alloc] initStep:@"Do it, then 300 seconds editing xcode if laptop, screenshot otherwise" with:[self scarface_rewrite] ] ;
    menu[@"I have a task to record" ] = [[DoNode alloc] initStep:@"Melta if possible, otherwise reminders, otherwise voicmail"] ;
    /* These things need answers... */
    return menu;
}


+ (WorkNode *) heart_interupt {
    DoNode *local=[[DoNode alloc] initStep:@"Listen"];
    [local addStep: @"Find the heart list"];
  
    return local;
}

+ (WorkNode *) phone_in {
    DoNode *local=[[DoNode alloc] initStep:@"\"Joe Reddington\""];
    [local addStep: @"Triage"];
    [local addStep: @"To let you know, I only have five minutes."];
    [local addStep: @"Save number"];
    [local addStep: @"Follow up text message"];
    return local;
}


+ (WorkNode *) clean_bathroom {
     DoNode *local=[[DoNode alloc] initStep:@"Pee"];
    [local addStep: @"Put bleach in toilet"];
    [local addStep: @"Replace towels"];
    [local addStep: @"Sink items into bath"];
    [local addStep: @"Get Pink dustclothe"];
    [local addStep: @"Wipe tops of toliet, tiles, and roll holder"];
    [local addStep: @"Clean mirrors"];
    return local;
}



+ (WorkNode *)house_cleaning {
    DoNode *local=[[DoNode alloc] initStep:@"Replace bathroom bin"];
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
    DoNode *local=[[DoNode alloc] initStep:@"Create Issue"];
    [local addStep: @"Write down SMART goal"];
    [local addStep: @"Write down WHY you do it"];
    [local addStep: @"Write down a list of steps to take(not in order)" ];
     [local addStep: @"Think about the TAS version" ];
     [local addStep: @"Put it in the projects list and assign"];
     [local addStep: @"Write down the next action" ];
    return local;
}

+ (WorkNode *)setup_workspace {
    DoNode *local=[[DoNode alloc] initStep:@"Get water bottle"];
    [local addStep: @"Put Phone on charge"];
    [local addStep: @"Pen and something to brainstorm on nearby"];
    [local addStep: @"Tell phone Instramental music" ];
    [local addStep: @"Glasses" ];
    return local;
}


+ (WorkNode *)project_review {
    DoNode *local=[[DoNode alloc] initStep:@"Check and respond to project notifications."];
    [local addStep: @"Open EQT Projects Board"];
    [local addNode:[self project_normal_form]];
    [local addStep: @"Open Personal Projects Board"];
    [local addNode:[self project_normal_form]];
    return local;
    
}

+ (WorkNode *)project_normal_form {
    DoNode *local=[[DoNode alloc] initStep:@"Make sure all issues have been imported to the board."];
    [local addStep: @"Removed closed issues"];
    QuestionNode *start=[[QuestionNode alloc] initLoop: @"Are there any unprocessed projects?" yesChild: [self check_project]];
    [local addNode:start];
    [local addStep:@"All done. Take a breath"];
    return local;
    
}

+ (WorkNode *)check_project {
    QuestionNode *start=[[QuestionNode alloc] initBranch: @"Does it need mapping?" yesChild: [self map_project]];
    [start addStep: @"Check it has the right priority"];
    [start addStep: @"Check it has a next action in github"];
    [start addStep: @"Check there is a next action in melta"];
    return start;
}

+ (WorkNode *)project_sprint {
    //what do we really want/
    DoNode *local=[[DoNode alloc] initStep:@"Open issue"];
    [local addStep: @"Set timer for stop - give enought time for SE question writing."];
    [local addStep: @"(Re)map if necessary." with:[self map_project]];
    //Work on the first step.
    DoNode *bulletpoint=[[DoNode alloc] initStep:@"Work on the first incomplete step"];
    [bulletpoint addStep: @"Write down any resources you used."];
    [bulletpoint addStep: @"Commit if possible."];
    [bulletpoint addStep: @"Remap if necessary." with:[self map_project]];
    QuestionNode *start=[[QuestionNode alloc] initLoop: @"Is the project incomplete?" yesChild: bulletpoint];
    [local addNode:start];
    [local addStep: @"close issue"];
    [local addStep: @"draft blog on project"];
    return local;
}


+ (WorkNode *) melta_normal_form {
    DoNode *local=[[DoNode alloc] initStep:@"Process reminders"];
    [local addStep: @"Check Shared reminder list"];
    [local addStep: @"Add tasks from phone screenshots."];
    [local addStep: @"Check Voicemail and add any messages to Tasks."];
    [local addStep: @"Check notebook/brainstorms for tasks"];
    [local addStep: @"Sort the next actions file alphabetically, this will put the least defined tasks at the top."];
    [local addStep: @"Fill in the priority, and time (mark off done tasks)"];
    [local addStep: @"Messsage Kat a list of the ones relevent to her"];
    [local addStep: @"Note now much time for the full list"];
    [local addStep: @"Do (or calendar if before 9am) all phone call tasks"];
    [local addStep: @"Check if some tasks have already been done"];
    [local addStep: @"Rewrite tasks thinking about how public they are" with: [self rewrite_for_public]];
  //  [local addStep: @"Go thought all tasks and adjust the deadline for an urgent ones"];
    return local;
}


+ (WorkNode *)rewrite_for_public {
    /* Plan day goes before normal form because Plan day generates small, urgent actions from the calendar wheres reminders rarely generate calendar entries*/
    DoNode *local=[[DoNode alloc] initStep:@"Each action starts with verb"];
    [local addStep: @"Sprints have links"];
    [local addStep: @"Actions start with captial letters"];
    return local;
}

+ (WorkNode *)setup_digital_workspace {
    /* Plan day goes before normal form because Plan day generates small, urgent actions from the calendar wheres reminders rarely generate calendar entries*/
    DoNode *local=[[DoNode alloc] initStep:@"Open a journal page, plan your dayl" with: [self journaling]];
    [local addStep: @"Close other programs (not terminal)"];
    [local addStep: @"Plan Day" with:[self plan_day]];
    [local addStep: @"Gather and sort action points" with:[self melta_normal_form]];
    [local addStep: @"Update Charts" with:[self update_charts]];
    return local;
}


+ (WorkNode *)journaling {
    DoNode *local=[[DoNode alloc] initStep:@"What are you grateful for"];
    [local addStep: @"have you planned fun things?"];
    [local addStep: @"what made you smile yesterday?"];
    return local;
}

+ (WorkNode *)update_charts {
    DoNode *local=[[DoNode alloc] initStep:@"Move heartrate into dropbox"];
    [local addStep: @"Sync DELORES records"];
    [local addStep: @"Sync Flair and Dreamhost"];
    [local addStep: @"run watson"];
    [local addStep: @"Open Prioirty and Time Chart (for flow)"];
    return local;
}

+ (WorkNode *)alarm_has_gone_off {
    DoNode *local=[[DoNode alloc] initStep:@"Stand up"];
    [local addStep: @"Write the 'context stack' down on a log if you have one"];
    [local addStep: @"Do the thing" with: [self nextAction]];
    return local;
}

+ (DoNode *)process_apointment {
  DoNode *yesNode=[[DoNode alloc] initStep:@"Change to Skype"];
    [yesNode addStep: @"Think of a way to make it awesome"];
    [yesNode addStep: @"Email/call to confirm"];
    [yesNode addStep: @"Add any tasks about appointment"];//which wil have prioirt 0 and happen first
    [yesNode addStep: @"Send (or write) adenda"];
    [yesNode addStep: @"Set Alarm for travel"];
    [yesNode addStep: @"Set Alarm for ending the apointment"];
  return yesNode;
}

+ (DoNode *)scarface_rewrite {
    DoNode *yesNode=[[DoNode alloc] initStep:@"Open Xcode"];
    [yesNode addStep: @"Itterate screenshots until finnished"];
    return yesNode;
}

+ (WorkNode *)plan_day {
    DoNode *local=[[DoNode alloc] initStep:@"Open Calendar."];
    [local addStep: @"Block out time for any events that you know are happening"];
    QuestionNode *start=[[QuestionNode alloc] initLoop: @"Are there any unprocessed apointments (72 hours)?" yesChild: [self process_apointment]];
    [local addNode:start];
    [local addStep: @"Block out time for any events you'd like to do in between apointments"];
    [local addStep: @"Set Alarm for exercise"];
    [local addStep: @"Set Alarm for email"];
    [local addStep: @"Do some food prep"];
    [local addStep: @"Add any blocked off time you like to calendar and set alarms"];
    
    [local addStep: @"Look at the sleep records for the last few days to see if any adjustments are needed"];
    return local;
}




+ (WorkNode *)morning {
    DoNode *local=[[DoNode alloc] initStep:@"Feel the genius" withTime: 30];
    [local addStep: @"Weight self using app" withTime: 60];
    [local addStep: @"Exercise" with:[self home_workout]];
    [local addStep: @"Charge watch" withTime: 20];
    [local addStep: @"Morning Bathroom" with:[self morning_bathroom]];
    [local addStep: @"clothes in wash bag" withTime: 10];
    [local addStep: @"Go to office" withTime: 20];
    [local addStep: @"Meditation" withTime: 90];
    [local addStep: @"Setup Physical Workspace" with:[self setup_workspace]];
    [local addStep: @"Setup Digital Workspace" with:[self setup_digital_workspace]];
    QuestionNode *q=[[QuestionNode alloc] initBranch: @"Is there a redline?" yesChild: [self red_line]];
    [local addNode: q];
    QuestionNode *start=[[QuestionNode alloc] initLoop: @"Is there a next action to do?" yesChild: [self nextAction]];
    [local addNode:start];
//ends here.
    
    return local;
}

+ (WorkNode *) morning_bathroom{
    DoNode *local=[[DoNode alloc] initStep:@"Pause, remember to thank each element" withTime: 10];
    [local addStep: @"Shower (including face)" withTime: 400];
    [local addStep: @"Deodorant" withTime: 20];
    [local addStep: @"Dress" withTime: 50];
    [local addStep: @"consider face strip" withTime: 300];
    [local addStep: @"shave" withTime: 250];
    [local addStep: @"shave head" withTime: 250];
    [local addStep: @"teeth" withTime: 150];
    [local addStep: @"floss" withTime: 300];
    [local addStep: @"Vitimin Tablet" withTime: 15];
    return local;
}


+ (WorkNode *) home_workout{
    DoNode *local=[[DoNode alloc] initStep:@"clothes" withTime: 60];
    [local addStep: @"Get keys" withTime: 30];
    [local addStep: @"Get Water bottle" withTime: 30];
    [local addStep: @"Check for washing to dry" withTime: 60];
    [local addStep: @"Unload dishwasher" withTime: 200];
    [local addStep: @"Take rubbish/recycling out" withTime: 120];
    [local addStep: @"Garage" withTime: 15];
    [local addStep: @"Streach"];
    [local addStep: @"on Bike/run/walk: Focus on your intensity" withTime: 2000];
    [local addStep: @"Thank bike/trainer" withTime: 10];
    [local addStep: @"empty dryer to take back" withTime: 60];
    [local addStep: @"Drink a full pint of water"];
  
    return local;
    
}

+ (WorkNode *) enterCoffeeShop{
    DoNode *local=[[DoNode alloc] initStep:@"Smile"];
    [local addStep: @"Remember you probably have a loyalty card"];
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
    DoNode *local=[[DoNode alloc] initStep:@"put water in bedroom" withTime: 60];
    [local addStep:@"Bed: Get tomorrow's clothes from bedroom" withTime: 30];
    [local addStep:@"Remember - thank each item as you put it away" withTime: 10];
    [local addStep: @"FR:Glasses in bag" withTime: 20];
    [local addStep: @"FR:Keys in bag" withTime: 60];//60 because we may have to find them
    [local addStep: @"FR:Wallet has two bank cards" withTime: 30];
    [local addStep: @"FR:Laptop on charge" withTime: 20];
    [local addStep: @"FR:Phone on charge" withTime: 20];
    [local addStep: @"Kitch:Food in bag" withTime: 60];
    [local addStep: @"FR:Pens and notebook in bag" withTime: 30];
    [local addStep: @"FR: Spare battery" withTime: 10];
    [local addStep: @"FR:MacBook charger" withTime: 10];
    [local addStep: @"FR:folding plug" withTime: 10];
    [local addStep: @"down:clothes in washing machine"];
    [local addStep: @"down:switch dishwasher on"];
    [local addStep: @"down:Lock Door" withTime: 20];
    [local addStep: @"down:Setup tea and water bottles" withTime: 60];
    [local addStep: @"down:Workout jumper on aga" withTime: 60];
    [local addStep: @"down:Lights out" withTime: 20];
    [local addStep: @"Bath: Teeth" withTime: 150];
    [local addStep: @"Bath:Leave good clothes in bathroom" withTime: 60];
    [local addStep: @"office:Headphones on charge" withTime: 30];
    [local addStep: @"bed:watch on charge"];
    return local;
    
}

+ (WorkNode *) meeting{
    DoNode *local=[[DoNode alloc] initStep:@"Find out other people's ending time"];
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
