//
//  QuestionInterfaceController.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 18/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "QuestionInterfaceController.h"
#import "QuestionNode.h"

@interface QuestionInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *questionstring;

@end


@implementation QuestionInterfaceController

QuestionNode *currentQuestionNode;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    currentQuestionNode=context;
    self.questionstring.text=currentQuestionNode.message;
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)noPress {
    NSLog(@"Nopressed");
    currentQuestionNode.result=0;
    [self popController];
}
- (IBAction)yesPress {
    NSLog(@"Yespressed");
    currentQuestionNode.result=1;
    [self popController];
}


@end



