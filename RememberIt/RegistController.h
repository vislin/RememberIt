//
//  RegistController.h
//  RememberIt
//
//  Created by 田中 康治 on 11/05/08.
//  Copyright 2011 日本電産トーソク株式会社. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Define.h"

@interface RegistController : NSObject {
    @private
    IBOutlet NSWindow *myParentWindow;
    IBOutlet NSTableView *tableView;
    NSMutableArray *dict;
    bool windowOpen;
}
- (void)open:(NSMutableArray *)data;
- (IBAction)onDelete:(id)sender;
@end
