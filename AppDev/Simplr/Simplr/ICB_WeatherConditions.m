//
//  ICB_WeatherConditions.m
//  LocalWeather
//
//  Created by Matt Tuzzolo on 9/28/10.
//  Copyright 2010 iCodeBlog. All rights reserved.
//

#import "ICB_WeatherConditions.h"
#import "RXMLElement.h"

@implementation ICB_WeatherConditions

@synthesize currentTemp, location;

- (ICB_WeatherConditions *)initWithQuery:(NSString *)query
{
    if (self = [super init])
    {
          NSURL *queryURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://weather.service.msn.com/data.aspx?weadegreetype=F&culture=en-US&weasearchstr=%@", query]];
        
        RXMLElement *rootXML = [[RXMLElement alloc]initFromURL:queryURL];
        RXMLElement *weather = [rootXML child:@"weather"];
        RXMLElement *current = [weather child:@"current"];
        
        NSLog(@"Root xml tag is %@", rootXML.tag);
        NSLog(@"Weather xml tag is %@", weather.tag);
        NSLog(@"Weather's WLN is %@", [weather attribute:@"weatherlocationname"]);
        NSLog(@"Weather's CT is %@",[current attribute:@"temperature"]);
        
        currentTemp = [[current attribute:@"temperature"]integerValue];
        location = [weather attribute:@"weatherlocationname"] ;
        
        /*find next 2 days, get skycode image*/
    }

    return self;
}

- (void)dealloc {    

}

@end
