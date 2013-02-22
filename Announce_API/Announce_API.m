//
//  Announce_API.m
//  Announce_API
//
//  Created by R MAC on 13/2/19.
//  Copyright (c) 2013年 R MAC. All rights reserved.
//

#import "Announce_API.h"

@implementation Announce_API

+ (NSString *)getAnnounceInfo_Count:(NSInteger)count andType:(NSString *)type andStartDay:(NSInteger) startDay {
    NSString *url = [NSString stringWithFormat:@"dtop.ntou.edu.tw/app1020131.php?count=%@&CLASS=%@&StartDate=%@",count ,type,startDay ];
      url = [url stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(NSASCIIStringEncoding)];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}


@end
