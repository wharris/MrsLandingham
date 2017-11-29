//
//  LogController.m
//  Mrs Landingham
//
//  Created by Joseph Reddington on 23/08/2017.
//  Copyright © 2017 Joseph Reddington. All rights reserved.
//

#import "LogController.h"

@implementation LogController
//Everything here is from: https://stackoverflow.com/questions/11057510/creating-a-log-file-in-an-ios-app

- (void) writeLogWith: (NSString *) content {
     
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [[documentsDirectory stringByAppendingPathComponent:@"whathappenedwhen"] stringByAppendingPathExtension:@"md"];
    
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
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:@"whathappenedwhen.md"];
    
    //read the whole file as a single string
    return [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    
}


@end
