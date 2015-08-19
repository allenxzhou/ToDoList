//
//  ToDoCell.h
//  ToDoList
//
//  Created by Allen Zhou on 8/18/15.
//  Copyright (c) 2015 Allen Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *minutesLeft;
@property (strong, nonatomic) IBOutlet UILabel *hoursLeft;
@property (strong, nonatomic) IBOutlet UILabel *daysLeft;
@property (strong, nonatomic) IBOutlet UILabel *taskLabel;

@end
