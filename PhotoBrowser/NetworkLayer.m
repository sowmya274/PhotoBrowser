//
//  NetworkLayer.m
//  PhotoBrowser
//
//  Created by Sowmya Srinivasan on 07/05/18.
//  Copyright © 2018 Wipro. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NetworkLayer.h"
@implementation NetworkLayer

-(void)downloadDatacompletionBlock:(void (^)(BOOL succeeded, NSString * title, NSArray *details))completionBlock
{
    NSError * error;
    NSString * urlString = @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json";
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(!error)
        {
            NSError *jsonError = nil;
            NSString *responseString = [[[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] stringByReplacingOccurrencesOfString:@"\t" withString:@""] stringByReplacingOccurrencesOfString:@"\0" withString:@""];
            NSData *resData = [responseString dataUsingEncoding:NSUTF8StringEncoding];

            NSMutableDictionary *factDetails = [NSJSONSerialization JSONObjectWithData:resData options:0 error:&jsonError];
            if (jsonError) {
                completionBlock(NO, @"", nil);
            }
            else {
                NSArray * rows = [factDetails valueForKey:@"rows"];
                NSString * title = [factDetails valueForKey:@"title"];
                completionBlock(YES,title,rows);
            }
        }
        else
        {
            completionBlock(NO,@"",nil);
        }
    
    
    }];
    
    [dataTask resume];
}

-(void)downloadImage:(NSString *)urlString completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    if(urlString.length > 0)
    {
        NSLog(@"URL String = %@",urlString);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if ( !error )
                {
                    data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    UIImage *image = [[UIImage alloc] initWithData:data];
                    completionBlock(YES,image);
                    
                }
                else
                {
                    completionBlock(NO,[UIImage imageNamed:@"placeholder.png"]);
                }
                
            }];
            [dataTask resume];
        });
        
    }
    else
    {
        completionBlock(NO,[UIImage imageNamed:@"placeholder.png"]);
    }

}

@end
