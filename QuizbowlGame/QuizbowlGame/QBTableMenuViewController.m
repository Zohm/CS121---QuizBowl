//
//  QBTableMenuViewController.m
//  QuizbowlGame
//
//  Created by jarthurcs on 2/23/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBTableMenuViewController.h"
#import "QBCreateQuestionViewController.h"
#import "QBBrowseQuestionViewController.h"
#import "QBViewController.h"
#import <Parse/Parse.h>

@interface QBTableMenuViewController ()
- (NSString *)titleForCellAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)subTitleForCellAtIndexPath:(NSIndexPath *)indexPath;
//- (UIViewController *)viewControllerForSelectedRowAtIndexPath:(NSIndexPath *)indexPath;
@end

typedef enum {
    // Enumerate the rows of the table view starting with zero. The last will be the total number of rows
    PlayGame = 0,
    CreateQuestions,
    DownloadQuestions,
    QuestionLibrary,
    SignOut,
    NumberOfRows
} TableMenuViewRow;

@implementation QBTableMenuViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Welcome to Quizbowl", nil);
}

#pragma mark - QBCreateQuestionViewControllerDelegate

-(void) questionSubmitted
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return NumberOfRows;
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

- (NSString *)titleForCellAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellText = nil;
    switch (indexPath.row) {
        case PlayGame:
            cellText = NSLocalizedString(@"Play", nil);
            break;
        case CreateQuestions:
            cellText = NSLocalizedString(@"Create Questions", nil);
            break;
        case DownloadQuestions:
            cellText = NSLocalizedString(@"Download Questions", nil);
            break;
        case QuestionLibrary:
            cellText = NSLocalizedString(@"Question Library", nil);
            break;
        case SignOut:
            cellText = NSLocalizedString(@"Sign Out", nil);
            break;
        case NumberOfRows: // never reached.
        default:
            cellText = NSLocalizedString(@"Unknown", nil);
            break;
    }
	return cellText;
}

- (NSString *)subTitleForCellAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellText = nil;
    switch (indexPath.row) {
        case PlayGame:
            cellText = NSLocalizedString(@"Play a game of Quizbowl with your friends", nil);
            break;
        case CreateQuestions:
            cellText = NSLocalizedString(@"Write and post your own trivia questions", nil);
            break;
        case DownloadQuestions:
            cellText = NSLocalizedString(@"Download questions made by other users", nil);
            break;
        case QuestionLibrary:
            cellText = NSLocalizedString(@"View the questions you have downloaded on your device", nil);
            break;
        case SignOut:
            cellText = NSLocalizedString(@"Sign out of your account", nil);
            break;
        case NumberOfRows: // never reached.
        default:
            cellText = NSLocalizedString(@"Unknown", nil);
            break;
    }
	return cellText;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // The if-else control sequence is used here over switch-case due the the necessity of creating
    // instance variables within each case
    
    if (indexPath.row == SignOut) {
        [PFUser logOut];
        [self performSegueWithIdentifier:@"toLaunchMenu" sender:self];
    }
    else if (indexPath.row == CreateQuestions) {
        QBCreateQuestionViewController* controller = [QBCreateQuestionViewController initWithXib];
        controller.delegate = self;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == QuestionLibrary) {
        [self.navigationController pushViewController:[QBBrowseQuestionViewController initWithStoryboard:@"MainStoryboard" andIdentifier:@"browse"] animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 63.0f;
}

@end
