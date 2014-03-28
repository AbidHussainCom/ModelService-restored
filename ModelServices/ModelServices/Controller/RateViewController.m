//
//  RateViewController.m
//  ModelServices
//
//  Created by Le Abid on 17/02/2014.
//  Copyright (c) 2014 Coeus Solutions GmbH. All rights reserved.
//

#import "RateViewController.h"
#import "ResourceViewController.h"
#import "CurrencyRateService.h"
#import "CurrencyRate.h"

@interface RateViewController () {
    
    CurrencyRate *rate;
    CurrencyRateService *service;
    
    IBOutlet UIView *viewHeader;
    IBOutlet UIView *viewFooter;
    
    IBOutlet UILabel *lblHeader;
    IBOutlet UILabel *lblFooter;
    
}

@end

@implementation RateViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = viewHeader;
    self.tableView.tableFooterView = viewFooter;
    
    service = [[CurrencyRateService alloc] init];
    
    [service getContentsWithSuccessBlock:^(id response) {
        
        NSArray *allObjects = (NSArray*)response[DATA];
        rate = [allObjects firstObject];
        
        lblHeader.text = [NSString stringWithFormat:@"BASE CURRENCY is %@",rate.base];
        lblFooter.text = [NSString stringWithFormat:@"Updated At %@",rate.updatedAt];
        [self.tableView reloadData];
        
    } andFailureBlock:^(id response) {
        rate = nil;
        lblHeader.text = nil;
        lblFooter.text = nil;
        [self.tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return rate.rates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *rateDict = rate.rates[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"CURRENCY CODE : %@",rateDict[@"code"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",rateDict[@"rate"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResourceViewController *detailViewController = [[ResourceViewController alloc] initWithNibName:@"ResourceViewController" bundle:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
