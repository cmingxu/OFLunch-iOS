//
//  MenuViewController.m
//  OFLunch
//
//  Created by kevin  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuItem.h"
#import "OrderItem.h"

@implementation MenuViewController

@synthesize vendor = _vendor;
@synthesize menus = _menus;

- (void)requestFinished:(NSArray *)menus{
    [self setMenus:menus];
    [self.tableView reloadData];
}


- (void)requestFailed:(NSString *) error{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:error
                                                   delegate:self
                                          cancelButtonTitle:@"知道了" otherButtonTitles:nil,  nil];
    [alert show];
    [alert release];
}


- (void) dealloc
{
    [self setMenus:nil];
    [self setVendor:nil];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) backToVendors
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    self.vendor.delegate = self;
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:self.vendor.name
                                                                            style:UIBarButtonItemStylePlain target:self
                                                                            action:@selector(backToVendors)] autorelease];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    self.navigationItem.title = @"今日菜单";
    [self.vendor loadTodayMenus];
    [super viewWillAppear:animated];
    }

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _menus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
 
    cell.textLabel.text = [[self.menus objectAtIndex:[indexPath row]] name];

    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f￥",[[_menus objectAtIndex:indexPath.row] price]];
    
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if ([delegate.order includeMenuItem: (MenuItem *)[_menus objectAtIndex:indexPath.row]]) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    MenuItem *mi = (MenuItem *)[self.menus objectAtIndex:indexPath.row];
  
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ( [delegate.order includeMenuItem: mi]){
        
        [delegate.order removeFromOrder: mi];
        cell.accessoryType = UITableViewCellAccessoryNone;

    }
    else{
        
        [delegate.order addToOrder: mi];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

    }
}

@end
