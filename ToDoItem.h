//
//  ToDoItem.h
//  ToDoList
//
//  Created by Allen Zhou on 7/30/15.
//  Copyright (c) 2015 Allen Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property NSDate *goal;
@property (readonly) NSDate *creationDate;

@end
