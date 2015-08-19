//
//  ToDoListTableViewController.m
//  ToDoList
//
//  Created by Allen Zhou on 7/30/15.
//  Copyright (c) 2015 Allen Zhou. All rights reserved.
//

#import "ToDoListTableViewController.h"
#import "ToDoItem.h"
#import "ToDoCell.h"
#import "AddToDoItemViewController.h"

@interface ToDoListTableViewController ()

@property NSMutableArray *toDoItems;
@property NSTimer *updater;

@end

@implementation ToDoListTableViewController

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    AddToDoItemViewController *source = [segue sourceViewController];
    ToDoItem *item = source.toDoItem;
    
    if (item != nil) {
        [self.toDoItems addObject:item];
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ToDoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ToDoCell"];
    // Also unnecessary because I put the actual cell into the storyboard
    //[self.tableView registerClass: [ToDoCell class] forCellReuseIdentifier:@"ToDoCell"];
    self.toDoItems = [[NSMutableArray alloc] init];
    [self loadInitialData];
}

- (void)loadInitialData {
    ToDoItem *item1 = [[ToDoItem alloc] init];
    item1.itemName = @"Trim the tree branches.";
    ToDoItem *item2 = [[ToDoItem alloc] init];
    item2.itemName = @"Clean up my work area.";
    ToDoItem *item3 = [[ToDoItem alloc] init];
    item3.itemName = @"Become an iOS master!";
    [self.toDoItems addObject:item1];
    [self.toDoItems addObject:item2];
    [self.toDoItems addObject:item3];
    
    // Added so that it will update the time even if you leave the app open - potential overhead though
    if (self.updater == nil) {
        self.updater = [NSTimer timerWithTimeInterval:1.0 target:self.tableView selector:@selector(reloadData) userInfo:nil repeats:YES];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:self.updater forMode:NSRunLoopCommonModes];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.toDoItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ToDoCell";
    ToDoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    // Unnnecessary
//    if (cell == nil) {
//        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"ToDoCell" owner:self options:nil];
//        cell = [nibArray objectAtIndex:0];
//    }
    
    ToDoItem *toDoItem = [self.toDoItems objectAtIndex:indexPath.row];
    NSString *itemText = [[NSString alloc] initWithString:toDoItem.itemName];
    NSDictionary *timeText = [self dateConverter:toDoItem.goal];
    
    cell.taskLabel.text = itemText;
    cell.daysLeft.text = [NSString stringWithFormat:@"%d Days", [[timeText objectForKey: @"Days"] intValue]];
    cell.hoursLeft.text = [NSString stringWithFormat:@"%d Hours", [[timeText objectForKey: @"Hours"] intValue]];
    cell.minutesLeft.text = [NSString stringWithFormat:@"%d Minutes", [[timeText objectForKey: @"Minutes"] intValue]];
    // Alternative: cell.minutesLeft.text = [NSString stringWithFormat:@"%@ Minutes", [timeText objectForKey: @"Minutes"]];
    
//    NSLog(@"Fudge Monkeys: %@", cell.taskLabel.text);
//    cell.detailTextLabel.text = timeText;
    if (toDoItem.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ToDoItem *tappedItem = [self.toDoItems objectAtIndex:indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (NSDictionary *)dateConverter:(NSDate *)date {
    int seconds = date.timeIntervalSinceNow;
    BOOL wasNegative = false;
    if (seconds < 0) {
        seconds *= -1;
        wasNegative = true;
    }
    int days = seconds / 86400;
    int hours = (seconds - days * 86400) / 3600;
    int minutes = (seconds - days * 86400 - hours * 3600) / 60;
    seconds %= 60;
    
    NSString *past = [[NSString alloc] init];
    if (wasNegative) {
        past = @" Ago";
    } else {
        past = @"";
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
                [NSNumber numberWithInt:days], @"Days",
                [NSNumber numberWithInt:hours], @"Hours",
                [NSNumber numberWithInt:minutes], @"Minutes",
                [NSNumber numberWithInt:seconds], @"Seconds", nil];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
