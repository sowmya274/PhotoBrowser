//
//  CustomTableViewCell.h
//  PhotoBrowser
//
//  Created by Sowmya Srinivasan on 07/05/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *details;

@end
