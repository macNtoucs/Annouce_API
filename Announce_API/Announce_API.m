//
//  Announce_API.m
//  Announce_API
//
//  Created by R MAC on 13/2/19.
//  Copyright (c) 2013年 R MAC. All rights reserved.
//

#import "Announce_API.h"

@implementation Announce_API

- (id) init {
    self = [super init];
    if (self != nil) {
        updatePackage = [NSMutableData new];
    }
    return self;
}


- (NSDictionary *)getAnnounceInfo_Count:(int)count andType:(NSString *)type andPage:(int) page {
    NSString *url = [NSString stringWithFormat:@"http://dtop.ntou.edu.tw/app1020311.php?page=%d&count=%d&class=%@",page,count,type];
      url = [url stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(NSUTF8StringEncoding)];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    NSURLConnection * connection = [[NSURLConnection alloc]
                                    initWithRequest:request
                                    delegate:self startImmediately:YES];
    
    [connection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                          forMode:NSDefaultRunLoopMode];
    //NSLog(@"Is%@ main thread", ([NSThread isMainThread] ? @"" : @" NOT"));
    [connection start];
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        return nil;
    }
    NSError * parseError;
    
    NSString * XMLResponse = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    //[connection cancel];
   return [XMLReader dictionaryForXMLString:XMLResponse error:&parseError];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if(httpResponse && [httpResponse respondsToSelector:@selector(allHeaderFields)]){
        NSDictionary *httpResponseHeaderFields = [httpResponse allHeaderFields];
        mFileSize = [[httpResponseHeaderFields objectForKey:@"Content-Length"] longLongValue];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"HTTP DownloadError");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [updatePackage appendData:data];
    
    int t = [updatePackage length]/1024;
    int t2= mFileSize/1024;
    NSString *output = [NSString stringWithFormat:@"正在下载 進度:%dk/%dk .",t,t2];
    NSLog(@"%@",output);
}



@end
