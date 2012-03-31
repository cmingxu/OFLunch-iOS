//
//  OrderViewController.m
//  OFLunch
//
//  Created by kevin  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderViewController.h"
#import "AppDelegate.h"
#import "OrderItem.h"

@implementation OrderViewController

@synthesize orderItemsTableview;
@synthesize totalMoneyLabel;
@synthesize order;


- (void)orderSucessfully: (int) statusCode
{   UIAlertView *alert;
    if (statusCode == 201) {
        alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"下单成功" delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    }
    else{
        alert = [[UIAlertView alloc] initWithTitle:@""
                                           message:@"下单失败" delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil, nil];

    }

    [alert show];
    [alert release];
}
- (void)orderFailed: (NSString *)reason
{ 
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                  message:@"下单失败" delegate:self
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:( NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"celll"] autorelease];
    OrderItem *oi = (OrderItem *)[self.order.orderItems objectAtIndex: indexPath.row];
    NSLog(@"%@", [oi menuItemName]);
    cell.textLabel.text = [NSString stringWithFormat:@"%@ x %d", [oi menuItemName], oi.amount];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f￥", oi.totalPrice];
    
    NSLog(@"%d", self.order.orderItems.count);
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.order.orderItems.count;
}


- (void)viewWillAppear:(BOOL)animated
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.order = delegate.order;
    [self.order setDelegate:self];
    [self.orderItemsTableview setDelegate: self];
    [self.orderItemsTableview setDataSource:self];
    totalMoneyLabel.text = [NSString stringWithFormat:@"总价 %.1f￥", [self.order totalPrice]];
   
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    self.order.delegate = nil;
    self.order = nil;
    [self.orderItemsTableview setDelegate: nil];
    [self.orderItemsTableview setDataSource:nil];
}

- (void)viewDidLoad
{
    self.navigationItem.title = @"我的菜单";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下单" style:UIBarButtonItemStyleDone target:self action:@selector(btnClicked)];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setOrderItemsTableview:nil];
    [self setTotalMoneyLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [orderItemsTableview release];
    [totalMoneyLabel release];
    [super dealloc];
}
- (void)btnClicked {
    [self.order pushToServer];
}
@end
