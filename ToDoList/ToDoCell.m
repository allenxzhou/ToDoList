//
//  ToDoCell.m
//  ToDoList
//
//  Created by Allen Zhou on 8/18/15.
//  Copyright (c) 2015 Allen Zhou. All rights reserved.
//

#import "ToDoCell.h"

@implementation ToDoCell
@synthesize taskLabel = _taskLabel;
@synthesize daysLeft = _daysLeft;
@synthesize hoursLeft = _hoursLeft;
@synthesize minutesLeft = _minutesLeft;

- (void)awakeFromNib {
    // Initialization code
    self.taskLabel = [[UILabel alloc] init];
    self.daysLeft = [[UILabel alloc] init];
    self.hoursLeft = [[UILabel alloc] init];
    self.minutesLeft = [[UILabel alloc] init];
}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
