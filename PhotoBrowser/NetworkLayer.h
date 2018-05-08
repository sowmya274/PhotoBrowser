//
//  NetworkLayer.h
//  PhotoBrowser
//
//  Created by Sowmya Srinivasan on 07/05/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkLayer : NSObject
-(void)downloadDatacompletionBlock:(void (^)(BOOL succeeded, NSString * title, NSArray *details))completionBlock;
-(void)downloadImage:(NSString *)urlString completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock;
@end
