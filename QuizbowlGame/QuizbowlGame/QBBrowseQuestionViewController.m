//
//  QBBrowseQuestionViewController.m
//  QuizbowlGame
//
//  Created by jarthurcs on 2/26/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBBrowseQuestionViewController.h"
#import "QBCreateQuestionViewController.h"
#import "QBModifyQuestionViewController.h"
#import <Parse/Parse.h>

@interface QBBrowseQuestionViewController ()

- (NSString *)titleForCellAtIndexPath:(NSIndexPath *)indexPath;

- (UIViewController *)viewControllerForSelectedRowAtIndexPath:(NSIndexPath *)indexPath;

- (void) loadQuestions;

@end

@implementation QBBrowseQuestionViewController

@synthesize questionArray;

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Your questions", nil);
}

-(void) viewWillAppear:(BOOL)animated
{
    if ([PFUser currentUser]) {
        [self loadQuestions];
    }
}

#pragma mark - Factories

+(id) initWithStoryboard
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:@"browse"];
}

#pragma mark - QBCreateQuestionViewControllerDelegate

-(void) questionSubmitted
{
    [self.navigationController popViewControllerAnimated:YES];
    [self loadQuestions];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [questionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        // Change style to allow users to view subtitles of questions if we want this feature
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    [cell.textLabel setText:[self titleForCellAtIndexPath:indexPath]];
    
    /* Uncomment if you want cells with subtitles
    [cell.detailTextLabel setText:[self subTitleForCellAtIndexPath:indexPath]];
    [cell.detailTextLabel setNumberOfLines:2];*/
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (NSString *)titleForCellAtIndexPath:(NSIndexPath *)indexPath {
    PFObject* question = [questionArray objectAtIndex:indexPath.row];
    return [question objectForKey:@"title"];
}

/*
 - (NSString *)subTitleForCellAtIndexPath:(NSIndexPath *)indexPath {
 NSString *cellText = nil;
 return cellText;
 }*/

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here.
    [self.navigationController pushViewController:[self viewControllerForSelectedRowAtIndexPath:indexPath] animated: YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 63.0f;
}

- (UIViewController*) viewControllerForSelectedRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject* question = [self.questionArray objectAtIndex:indexPath.row];
    QBModifyQuestionViewController* controller = [[QBModifyQuestionViewController alloc] initWithQuestion:question];
    controller.delegate = self;
    return controller;
}

#pragma mark - PFQuery

- (void) loadQuestions
{
    //Create query for all Post object by the current user
    PFQuery *postQuery = [PFQuery queryWithClassName:@"QBQuestion"];
    [postQuery whereKey:@"author" equalTo:[PFUser currentUser]];
    
    // Run the query
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //Save results and update the table
            self.questionArray = objects;
            [self.tableView reloadData];
        }
    }];
}



@end
