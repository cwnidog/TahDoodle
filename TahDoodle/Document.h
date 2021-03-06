//
//  Document.h
//  TahDoodle
//
//  Created by John Leonard on 8/24/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Document : NSDocument <NSTableViewDataSource>

@property (nonatomic) NSMutableArray *tasks;
@property (nonatomic) IBOutlet NSTableView *taskTable;

- (IBAction)addTask:(id)sender;
- (IBAction)deleteTask:(id)sender;

@end

