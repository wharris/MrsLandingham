//
//  LogController.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 23/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "LogController.h"

// well this needs to be a proper object in any case.


@implementation LogController{
    NSString *documentsDirectory;
    NSString *filePath;
    
}


- (LogController *) init
{
    self = [super init];
    documentsDirectory = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    filePath = [[documentsDirectory stringByAppendingPathComponent:@"delores_log"] stringByAppendingPathExtension:@"md"];
    return self;
}


//Everything here is from: https://stackoverflow.com/questions/11057510/creating-a-log-file-in-an-ios-app

- (void) writeLogWith: (NSString *) content {
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath])
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    
    //append text to file (you'll probably want to add a newline every write)
    NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    [file seekToEndOfFile];
    [file writeData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    [file closeFile];
    NSLog(@"Wrote to file");
    
    return;
}

- (NSString *) getLog{
    NSError * error;
    //read the whole file as a single string
    NSString * temp =[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (temp==nil)
    {
        NSLog([error localizedFailureReason]);
        return @"Fail";
    }
    return temp;
}

- (void)log_state:(NSString *)message {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // ###### 30/11/17 14:37:
    [dateFormatter setDateFormat:@"\n\n###### dd/MM/YY HH:mm\n"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    [self writeLogWith: dateString];
    [self writeLogWith: message];
}


@end
