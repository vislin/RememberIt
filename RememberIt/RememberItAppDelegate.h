//
//  RememberItAppDelegate.h
//  RememberIt
//
//  Created by 田中 康治 on 11/05/01.
//  Copyright 2011 日本電産トーソク株式会社. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RememberItAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
