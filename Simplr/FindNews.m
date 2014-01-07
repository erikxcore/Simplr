//
//  FindNews.m
//  Simplr
//
//  Created by Eric on 4/2/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import "FindNews.h"
#import "MD5.h"

NSString * const BASE_URL = @"http://hyperlocal-api.outside.in/v1.1";

@implementation FindNews

@synthesize deals,location,zipCode,stories;

- (NSURL *)sign:(NSString *)relativePath {
    NSString * key = @"xkm8hdbgav99py855a87cfdd";
    NSString * secret = @"pW5Dm4hmFy";

    long time = (long)[[NSDate date] timeIntervalSince1970];
    NSString* sig = [MD5 md5hex:[NSString stringWithFormat:@"%@%@%ld", key, secret, time]];
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?dev_key=%@&sig=%@", BASE_URL, relativePath, key, sig]];
}

- (NSDictionary *)request:(NSString *)relativePath {
    NSDictionary* data = nil;
    NSURL *url = [self sign:relativePath];
    NSLog(@"Requesting %@", url);
    NSError *requestErr = nil;
    NSData *jsondata = [[NSData alloc]initWithContentsOfURL:url];
 //   NSString* str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&requestErr];
    if (requestErr == nil) {
     //   SBJsonParser *parser = [SBJsonParser new];
        NSError *parseErr = nil;
       // data = [parser objectWithString:str error:&parseErr];
        id result = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:&parseErr];
        NSLog(@"result is %@",result);

        if (parseErr != nil) {
            NSLog(@"Parse failed: %@", [parseErr localizedDescription]);
        }
    } else {
        NSLog(@"Request failed: %@", [requestErr localizedDescription]);
    }
    return data;
}

- (NSArray *)fetchStoriesInLocation:(NSString *)theLocation {
    //NSString *escapedLocation = [theLocation stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *locations = [[self request:[NSString stringWithFormat:@"/zipcodes/%@/", theLocation]] objectForKey:@"locations"];
    if ([locations count] == 0) {   
        NSLog(@"No location named %@", theLocation);
        return [NSArray array];
    }
    NSString *uuid = [[locations objectAtIndex:0] objectForKey:@"uuid"];
    NSString *escapedUuid = [uuid stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [[self request:[NSString stringWithFormat:@"/zipcodes/%@/stories", escapedUuid]] objectForKey:@"stories"];
}

- (FindNews *)initWithQuery:(NSString *)query
{
    if (self = [super init])
    {
         self.stories = [self fetchStoriesInLocation:query];
        NSLog(@"stories are %@",stories);
    }
    
    return self;
}

@end
