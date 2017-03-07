//
//  AppControl.m
//  RememberIt
//
//  Created by 田中 康治 on 11/05/01.
//  Copyright 2011 日本電産トーソク株式会社. All rights reserved.
//

#import "AppControl.h"

static const int DIALOG_OK      = 128;
static const int DIALOG_CANCEL  = 129;

@implementation AppControl

- (id)init
{

    self = [super init];
    if (self) {
        // Initialization code here.
        regCtrl = nil;
        state = 0;
        srandom((int) time(nil));
        
        NSFileManager *fm = [[NSFileManager alloc] init];
		dictFile = [[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], @"data.dic"];
		NSLog(dictFile);
        if ([fm fileExistsAtPath:dictFile] == true) {
            NSString *str = [[NSString alloc] initWithContentsOfFile:dictFile encoding:NSUTF8StringEncoding error:nil];
            [str retain];
            dict = [str propertyList];
            [dict retain];
        }
        else {
            dict = [[NSMutableArray alloc] init];
        }
        
        if ([dict count] > 0)
            dictNumber = (int) (rand() % [dict count]);
        else
            dictNumber = 0;
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

// ==========================================================
//  delegate
// ==========================================================


- (void)awakeFromNib
{
    [textQuestion setStringValue:@""];
    [textAnswer setStringValue:@""];
    regCtrl = [[RegistController alloc] init];
}

- (void)windowWillClose:(NSNotification *)aNotification
{
    if (regCtrl != nil) {
        [regCtrl release];
    }
}

- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
    return NO;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return(YES);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
//	[self selectDictionary:self];
}

// ==========================================================
//  user method
// ==========================================================
- (IBAction)selectDictionary:(id)sender
{
	NSOpenPanel* opanel = [NSOpenPanel openPanel];
	NSArray* fileTypes = [NSArray arrayWithObjects:@"dic", nil];
	
	long opRet;
	
	[opanel setCanChooseFiles:YES];
	[opanel setCanChooseDirectories:NO];
	[opanel setAllowedFileTypes:fileTypes];
	
//	opRet = [opanel runModalForDirectory:NSHomeDirectory() file:nil types:fileTypes];
//	opRet = [opanel runModal:[[NSBundle mainBundle] bundlePath] file:nil types:fileTypes];
	opRet = [opanel runModal];
	
	if (opRet == NSOKButton) {
		NSLog([[opanel URLs] objectAtIndex:0]);
	}
	else {
		NSLog(@"Cancel");
	}
}

- (IBAction)openDrawer:(id)sender
{
    [drawer open];
}

- (IBAction)closeDrawer:(id)sender
{
    [drawer close];
}

// 登録ボタン（ドローワーのオープン）
- (IBAction)toggleDrawer:(id)sender
{
    NSDrawerState drawerState = [drawer state];
    if (NSDrawerOpeningState == drawerState || NSDrawerOpenState == drawerState) {
        [drawer close];
    }
    else {
        [drawer openOnEdge:NSMinXEdge];
    }
}

// 次へボタン
- (IBAction)onNext:(id)sender
{
    if ([dict count] == 0)
        return;
   
    switch (state) {
        case 0:
            if ([dict count] != 0)
                dictNumber = (int) (rand() % [dict count]);
            else
                dictNumber = 0;
            
            [textQuestion setStringValue:[[dict objectAtIndex:dictNumber] objectAtIndex:QUESTION]];
            [textAnswer setStringValue:@""];
            state = 1;
            break;
            
        case 1:
            [textAnswer setStringValue:[[dict objectAtIndex:dictNumber] objectAtIndex:ANSWER]];
            state = 0;
            break;
            
        default:
            break;
    }
}

// ドローワーの中の登録ボタン
- (IBAction)onRegist:(id)sender
{
    NSArray *item = [[NSArray alloc] initWithObjects:[registQuestion stringValue], [registAnswer stringValue], nil];

    [dict addObject:item];
    [registQuestion setStringValue:@""];
    [registAnswer setStringValue:@""];
    
    [[dict description] writeToFile:dictFile atomically:NO encoding:NSUTF8StringEncoding error:nil];
}

// 登録ウィンドウのオープン(RegistControllerクラス)
- (IBAction)openRegistWindow:(id)sender
{
    [regCtrl open:dict];
}

// ウィンドウの表示
- (IBAction)showTestWindow:(id)sender
{
    [sheetDialog makeKeyAndOrderFront:self];
}

// ウィンドウの非表示
- (IBAction)hideTestsWindow:(id)sender
{
    [sheetDialog orderOut:self];
}

// シートダイアログの表示
- (IBAction)selectDictionary2:(id)sender
{
	NSArray *dictFiles = [[NSFileManager defaultManager] directoryContentsAtPath:@"."];

	[dictionaryList removeAllItems];
	
	for (NSString *element in dictFiles) {
		if ([[element pathExtension] isEqualToString:@"dic"] == true) {
			NSLog(@"Match word is %@", element);
			[dictionaryList addItemWithObjectValue:element];
		}
	}
	
    [NSApp beginSheet:sheetDialog 
	   modalForWindow:myParentWindow 
		modalDelegate:self 
	   didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:)
		  contextInfo:nil];
}

// シートのデリゲート
- (void)sheetDidEnd:(NSWindow *)sheet 
		 returnCode:(int)returnCode 
		contextInfo:(void *)contextInfo
{
	[sheetDialog orderOut:self];
	
	if (returnCode == NSOKButton) {
		NSLog([NSString stringWithFormat:@"%@", [dictionaryList objectValueOfSelectedItem]]);
	}
	else {
		NSLog(@"Sheet is canceled");
	}
}

// シートダイアログのOKボタン
- (IBAction)sheetOk:(id)sender
{
	NSLog([NSString stringWithFormat:@"%@", [dictionaryList objectValueOfSelectedItem]]);
	[NSApp endSheet:sheetDialog returnCode:NSOKButton];
}

// シートダイアログのCancelボタン
- (IBAction)sheetCancel:(id)sendr
{
	[NSApp endSheet:sheetDialog returnCode:NSCancelButton];
}
@end
