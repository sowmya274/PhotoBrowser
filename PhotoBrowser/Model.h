//
//  Model.h
//  PhotoBrowser
//
//  Created by Sowmya Srinivasan on 07/05/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Model : NSObject

@property (strong) NSString * title;
@property (strong) NSString * details;
@property (strong) NSString *imageURL;
@property (strong) UIImage *image;
@end
