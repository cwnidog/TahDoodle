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
  // if there is no array, create one
  if(!self.tasks)
  {
    self.tasks = [NSMutableArray array];
  }
  
  [self.tasks addObject:@"New Item"];
  
  // refresh the display with new data and note unsaved change
  [self.taskTable reloadData];
  [self updateChangeCount:NSChangeDone];
} // addTask()

- (void)deleteTask:(id)sender
{
  // can only delete a task if there are tasks
  if (self.tasks)
  {
    // get the selected row number and remove that object from the tasks array
    NSInteger row = [self.taskTable selectedRow];
    [self.tasks removeObjectAtIndex:row];
    
    // refresh the display with new data and note unsaved change
    [self.taskTable reloadData];
    [self updateChangeCount:NSChangeDone];
  } // if there are tasks
  
} // deleteTask

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

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
  // called when document is being saved
  
  // if there's no tasks array, write out an empty array
  if (!self.tasks)
  {
    self.tasks = [NSMutableArray array];
  }
  
  // pack the tasks array into an NSData object
  NSData *data = [NSPropertyListSerialization dataWithPropertyList:self.tasks format:NSPropertyListXMLFormat_v1_0 options:0 error:outError];
  
  return data;
} // dataOfType()

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
  // called when document is being loaded
  self.tasks = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainers format:NULL error:outError];
  
  // return success or failure depending on whether or not there's a tasks array
  return (self.tasks != nil);
}

@end
