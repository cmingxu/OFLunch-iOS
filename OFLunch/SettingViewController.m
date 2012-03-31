//
//  SettingViewController.m
//  OFLunch
//
//  Created by kevin  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"
#import "About.h"
#import "User.h"

@implementation SettingViewController
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"celll"] autorelease];
 
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text  = @"通知";
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            break;
        case 1:
            cell.textLabel.text = [[User currentUser] email];
        default:
            break;
    }
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (NSInteger) numberOfSectionsInTableView : (UITableView*)tableView {
    return 2;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewWillAppear: (BOOL)animated
{  
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [super viewWillAppear:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
    
    [super viewWillDisappear:YES];
}

- (void)viewDidLoad
{
    self.navigationItem.title = @"设置";

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *result;
    switch (section) {
        case 0:
            result = [[NSString alloc] initWithString:@"通知"];
            break;
            
        case 1:
            result = [[NSString alloc] initWithString:@"账户"];
            break;
            
        default:
            break;
    }
   return [result autorelease];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL deleteAccountAlert = NO;
    switch (indexPath.section) {
        case 0:
            [self.navigationController pushViewController:[[About alloc] initWithNibName:@"About" bundle:nil] animated:YES];
            break;
        case 1:
             deleteAccountAlert = YES;
            break;
         default:
            break;
    }
    if (deleteAccountAlert) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"删除此账户!" delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:@"暂不", nil];
        [alert show];
        [alert release];
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [[User currentUser] clear];
        [self.tableView reloadData];
    }
}

- (void)dealloc {
    [tableView release];
    [super dealloc];
}
@end
