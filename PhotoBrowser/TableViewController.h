//
//  TableViewController.h
//  PhotoBrowser
//
//  Created by Sowmya Srinivasan on 07/05/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController
@property (strong) NSMutableArray * data;
@property (nonatomic, strong) UIRefreshControl *  refreshControl;
@property (strong) UIActivityIndicatorView * activityIndicator;

@end
