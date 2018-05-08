//
//  TableViewController.m
//  PhotoBrowser
//
//  Created by Sowmya Srinivasan on 07/05/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import "TableViewController.h"
#import "CustomTableViewCell.h"
#import "NetworkLayer.h"
#import "Model.h"

@interface TableViewController ()
@property (strong) NSString * tableViewTitle;
@end

@implementation TableViewController

@dynamic refreshControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = [[NSMutableArray alloc] init];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewDidAppear:(BOOL)animated
{
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.activityIndicator.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
    self.activityIndicator.center = self.view.center;
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator bringSubviewToFront:self.view];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    self.tableView.rowHeight=UITableViewAutomaticDimension;

    
    [self getData];
}

-(void)getData
{
    NetworkLayer * nl = [[NetworkLayer alloc] init];
    [self.data removeAllObjects];
    [self.activityIndicator startAnimating];
    [nl downloadDatacompletionBlock:^(BOOL succeeded, NSString *title, NSArray *details){

        if(succeeded)
        {
            for(NSDictionary * item in details)
            {
                Model * model = [[Model alloc] init];
                if([item valueForKey:@"title"]!= [NSNull null])
                {
                    model.title = [item valueForKey:@"title"];
                }
                else
                {
                    model.title = @"";
                    
                }
                if([item valueForKey:@"description"] != [NSNull null])
                {
                    model.details = [item valueForKey:@"description"];
                }
                else
                {
                    model.details = @"";
                }
                if([item valueForKey:@"imageHref"]!= [NSNull null])
                {
                   
                    model.imageURL = [item valueForKey:@"imageHref"];
                    [nl downloadImage:model.imageURL completionBlock:^(BOOL succeeded, UIImage *image){
                        model.image = image;
                        dispatch_async(dispatch_get_main_queue(),^{
                            [self.tableView reloadData];
                        });
                    }];
                }
                else
                {
                    model.imageURL = @"";
                }
                [self.data addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(),^{
                [self.activityIndicator stopAnimating];
                self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                self.tableViewTitle = title;
                [self.tableView reloadData];
                [self.refreshControl endRefreshing];
                
            });
        }
        else
        {
            dispatch_sync(dispatch_get_main_queue(),^{
                [self.refreshControl endRefreshing];
                [self.activityIndicator stopAnimating];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Error" message:@"Unable to connect to the Network" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                }];
                [alert addAction:okButton];
                [self presentViewController:alert animated:YES completion:nil];

            });
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.title.text = [(Model*)self.data[indexPath.row] title];
    cell.details.text = [(Model*)self.data[indexPath.row] details];
    [cell.image setImage:[(Model*)self.data[indexPath.row] image]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.tableViewTitle;
}

@end
