//
//  VendorsViewController.m
//  OFLunch
//
//  Created by kevin  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VendorsViewController.h"
#import "MenuViewController.h"
#import "ASIHTTPRequest.h"

@interface VendorsViewController (Private)
- (void)mask;
- (void)unmask;
@end

@implementation VendorsViewController

@synthesize vendors = _vendors;
@synthesize mom = _mom;
@synthesize indicator = _indicator;

- (void)requestFinished:(NSArray *)vendors{
    [self setVendors:vendors];
    [self.tableView reloadData];
}

- (void)mask
{
    if (!_indicator) {
        self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicator.center = CGPointMake(160, 240);
        self.indicator.hidesWhenStopped = YES;
    }
    
    [self.indicator startAnimating];
}
- (void)unmask
{
    [_indicator stopAnimating];
}


- (void) dealloc
{
    [_mom release];
    [_vendors release];
}

- (void)requestFailed:(NSString *) error{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:error
                                                   delegate:self
                                          cancelButtonTitle:@"知道了" otherButtonTitles:nil,  nil];
    
    [alert show];
    [alert release];
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

- (void)viewDidLoad
{
    _mom = [[MoM alloc] init]; 
    _mom.delegate = self;
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [_mom release];
    [super viewDidUnload];
    
  
}

- (void)viewWillAppear:(BOOL)animated
{
    [_mom loadTodayVendors];
    self.navigationItem.title = @"今日菜单";
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (_vendors.count > 0) {
       return _vendors.count; 
    }else{
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSLog(@"count %d", self.vendors.count);
    
    if (self.vendors.count == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"尚无菜单，快催朱雷";
        }
    }else{
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.textLabel.text = [[self.vendors objectAtIndex:[indexPath row]] name];
        cell.detailTextLabel.text = [[self.vendors objectAtIndex:[indexPath row]] telephone];
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
   
    if (_vendors.count > 0) {
        
     MenuViewController *menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    
        menuViewController.vendor = [self.vendors objectAtIndex:[indexPath row]];
     [self.navigationController pushViewController:menuViewController animated:YES];
     [menuViewController release];
    }
  
}


@end
