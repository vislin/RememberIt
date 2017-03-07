//
//  RegistController.m
//  RememberIt
//
//  Created by 田中 康治 on 11/05/08.
//  Copyright 2011 日本電産トーソク株式会社. All rights reserved.
//

#import "RegistController.h"


@implementation RegistController

- (id)init
{
    self = [super init];
    if (self) {
        windowOpen = false;
    }
    
    return self;
}

- (void)dealloc
{
    if (windowOpen == true) {
        [myParentWindow close];
    }
    
    [super dealloc];
}

- (void)windowWillClose:(NSNotification *)aNotification
{
    windowOpen = false;
}

- (int)numberOfRowsInTableView:(NSTableView *)tv
{
    return (int)[dict count];
}

- (id)tableView:(NSTableView *)tv objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    int col;
   
    if ([[tableColumn identifier] isEqualToString:@"question"])
        col = QUESTION;
    else if ([[tableColumn identifier] isEqualToString:@"answer"])
        col = ANSWER;
    else
        col = QUESTION;
    
    NSString *v = [[dict objectAtIndex:row] objectAtIndex:col];

    return v;
}

- (void)open:(NSMutableArray *)data
{
    if (windowOpen == false) {
        [NSBundle loadNibNamed:@"RegistrationWindow" owner:self];
        [myParentWindow display];
        dict = data;
        windowOpen = true;
        [tableView reloadData];
    }
}

- (BOOL)tableView:(NSTableView *)aTableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSLog(@"shouldEditTableColumn");
    return YES;
}

- (IBAction)onDelete:(id)sender
{
    NSLog(@"%d", (int) [tableView selectedRow]);
    int n = (int) [tableView selectedRow];
    if (n >= 0) {
        [dict removeObjectAtIndex:n];
    }
    [[dict description] writeToFile:@"./data.txt" atomically:NO encoding:NSUTF8StringEncoding error:nil];
    [tableView reloadData];
}

@end
