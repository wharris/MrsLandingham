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
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    
    NSError *error;
    [content writeToFile:filePath atomically:false encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        NSLog(@"There was an error writing file\n%@", error.localizedDescription);
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSLog(@"File exists :)");
    }
    else {
        NSLog(@"File does not exist :(");
    }
    return;
}


@end
