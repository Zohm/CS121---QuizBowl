//
//  QBTableMenuViewController.m
//  QuizbowlGame
//
//  Created by jarthurcs on 2/23/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBTableMenuViewController.h"
#import <Parse/Parse.h>

@interface QBTableMenuViewController ()
- (NSString *)titleForCellAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)subTitleForCellAtIndexPath:(NSIndexPath *)indexPath;
//- (UIViewController *)viewControllerForSelectedRowAtIndexPath:(NSIndexPath *)indexPath;
@end

typedef enum {
    // Enumerate the rows of the table view starting with zero. The last will be the total number of rows
    TableMenuViewRowPlayGame = 0,
    TableMenuViewRowCreateQuestions,
    TableMenuViewRowDownloadQuestions,
    TableMenuViewRowQuestionLibrary,
    TableMenuViewRowSignOut,
    TableMenuViewNumberOfRows
} TableMenuViewRow;

@implementation QBTableMenuViewController


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Welcome to Quizbowl", nil);
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return TableMenuViewNumberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    [cell.textLabel setText:[self titleForCellAtIndexPath:indexPath]];
    [cell.detailTextLabel setText:[self subTitleForCellAtIndexPath:indexPath]];
    [cell.detailTextLabel setNumberOfLines:2];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here.
    switch (indexPath.row) {
        case TableMenuViewRowSignOut:
            [PFUser logOut];
            [self performSegueWithIdentifier:@"toLaunchMenu" sender:self];
            break;
        case TableMenuViewRowCreateQuestions:
            [self performSegueWithIdentifier:@"toCreateQuestionView" sender:self];
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 63.0f;
}

#pragma mark - ()

- (NSString *)titleForCellAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellText = nil;
    switch (indexPath.row) {
        case TableMenuViewRowPlayGame:
            cellText = NSLocalizedString(@"Play", nil);
            break;
        case TableMenuViewRowCreateQuestions:
            cellText = NSLocalizedString(@"Create Questions", nil);
            break;
        case TableMenuViewRowDownloadQuestions:
            cellText = NSLocalizedString(@"Download Questions", nil);
            break;
        case TableMenuViewRowQuestionLibrary:
            cellText = NSLocalizedString(@"Question Library", nil);
            break;
        case TableMenuViewRowSignOut:
            cellText = NSLocalizedString(@"Sign Out", nil);
            break;
        case TableMenuViewNumberOfRows: // never reached.
        default:
            cellText = NSLocalizedString(@"Unknown", nil);
            break;
    }
	return cellText;
}

- (NSString *)subTitleForCellAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellText = nil;
    switch (indexPath.row) {
        case TableMenuViewRowPlayGame:
            cellText = NSLocalizedString(@"Play a game of Quizbowl with your friends", nil);
            break;
        case TableMenuViewRowCreateQuestions:
            cellText = NSLocalizedString(@"Write and post your own trivia questions", nil);
            break;
        case TableMenuViewRowDownloadQuestions:
            cellText = NSLocalizedString(@"Download questions made by other users", nil);
            break;
        case TableMenuViewRowQuestionLibrary:
            cellText = NSLocalizedString(@"View the questions you have downloaded on your device", nil);
            break;
        case TableMenuViewRowSignOut:
            cellText = NSLocalizedString(@"Sign out of your account", nil);
            break;
        case TableMenuViewNumberOfRows: // never reached.
        default:
            cellText = NSLocalizedString(@"Unknown", nil);
            break;
    }
	return cellText;
}

@end
