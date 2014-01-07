//
//  FindDeals.m
//  Simplr
//
//  Created by Eric on 4/2/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import "FindPlaces.h"
#import "RXMLElement.h"
@implementation FindPlaces
@synthesize zipCode,location,places,address;
- (FindPlaces *)initWithQuery:(NSString *)query
{
        if (self = [super init])
        {
            NSString *key = @"10000004714";
            NSString *rest = @"restaurant";
            RXMLElement *restXML = [[RXMLElement alloc]initFromXMLData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.citygridmedia.com/content/places/v2/search/where?type=%@&where=%@&format=xml&publisher=%@", rest,query,key]]]];
            RXMLElement *items = [restXML child:@"locations"];
            places = [[NSMutableArray alloc]init];
            [items iterate:@"location" usingBlock:^(RXMLElement *item) {
                [places addObject:item];
            }];
            zipCode = query;
    }
    return self;
}
@end
