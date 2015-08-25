//
//  Document.m
//  TahDoodle
//
//  Created by John Leonard on 8/24/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

#import "Document.h"

@interface Document ()

@end

@implementation Document


#pragma mark - Document overrides

#pragma mark - Actions
- (void)addTask:(id)sender
{
  // if there i sno array, create one
  if(!self.tasks)
  {
    self.tasks = [NSMutableArray array];
  }
  
  [self.tasks addObject:@"New Item"];
  
  // refresh the display with new data and note unsaved change
  [self.taskTable reloadData];
  [self updateChangeCount:NSChangeDone];
} // addTask()

#pragma mark - Data Source methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tv
{
  // only one section so just return the number of tasks in the array
  return [self.tasks count];
} // numberOfRowsInTableView()

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
  // return the item from the task that corresponds to the cell to display
  return[self.tasks objectAtIndex:row];
} // objectValueForTableColumn()

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
  // when user chnges a task on the tableView, update the array
  [self.tasks replaceObjectAtIndex:row withObject:object];
  
  // flag the document as having unsaved changes
  [self updateChangeCount:NSChangeDone];
} // setObjectValue()

- (instancetype)init {
    self = [super init];
    if (self) {
    // Add your subclass-specific initialization here.
    }
    return self;
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
  [super windowControllerDidLoadNib:aController];
  // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace {
  return YES;
}

- (NSString *)windowNibName {
  // Override returning the nib file name of the document
  // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
  return @"Document";
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
  // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
  // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
  [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
  return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
  // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
  // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
  // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
  [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
  return YES;
}

@end
