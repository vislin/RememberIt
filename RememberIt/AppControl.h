//
//  AppControl.h
//  RememberIt
//
//  Created by 田中 康治 on 11/05/01.
//  Copyright 2011 日本電産トーソク株式会社. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "Define.h"
#import "RegistController.h"

#include <stdlib.h>

@class RegistController;

@interface AppControl : NSObject <NSDrawerDelegate> {
    IBOutlet NSWindow *myParentWindow;
    IBOutlet NSTextField *textQuestion;
    IBOutlet NSTextField *textAnswer;
    IBOutlet NSDrawer *drawer;
    IBOutlet NSTextField *registQuestion;
    IBOutlet NSTextField *registAnswer;
    IBOutlet NSPanel *sheetDialog;
	IBOutlet NSComboBox *dictionaryList;

    RegistController* regCtrl;
	NSString* dictFile;
    NSMutableArray* dict;
    int dictNumber;
    int state;
}

- (IBAction)selectDictionary:(id)sender;
- (IBAction)onNext:(id)sender;
- (IBAction)toggleDrawer:(id)sender;
- (IBAction)onRegist:(id)sender;
- (IBAction)openRegistWindow:(id)sender;
- (IBAction)showTestWindow:(id)sender;
- (IBAction)hideTestsWindow:(id)sender;
- (IBAction)selectDictionary2:(id)sender;
- (IBAction)sheetOk:(id)sender;
- (IBAction)sheetCancel:(id)sendr;

- (void)sheetDidEnd:(NSWindow *)sheet 
		 returnCode:(int)returnCode 
		contextInfo:(void *)contextInfo;

@end
