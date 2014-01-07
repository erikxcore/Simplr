//
//  FindDeals.m
//  Simplr
//
//  Created by Eric on 4/2/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import "FindDeals.h"
#import "RXMLElement.h"

@implementation FindDeals


@synthesize zipCode,location,deals;

- (FindDeals *)initWithQuery:(NSString *)query
{
    if (self = [super init])
    {
        
        RXMLElement *rootXML = [[RXMLElement alloc]initFromXMLData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://lesserthan.com/api.getDealsZip/%@/xml", query]]]];
        
        if(![rootXML child:@"items"]){
            NSLog(@"Failed!");
            return nil;
        }
 
        RXMLElement *items = [rootXML child:@"items"];
        
        deals = [[NSMutableArray alloc]init];
        [items iterate:@"item" usingBlock:^(RXMLElement *item) {
            RXMLElement *deal = [[RXMLElement alloc]init];
            deal = [item child:@"deal"];
            [deals addObject:deal];
        }];
        
        zipCode = query;

       //NSLog(@"Items are %@",items);
       // NSLog(@"Deals are %@ \n",deals);
       // NSLog(@"Deal 1 is %@ \n",[[deals objectAtIndex:0] child:@"title"]);
       // NSLog(@"Deal 1 is %@ \n",[[deals objectAtIndex:0] child:@"description"]);
       // NSLog(@"Deal 1 is %@ \n",[[deals objectAtIndex:0] child:@"link"]);
       // NSLog(@"Deal 1 is %@ \n",[[deals objectAtIndex:0] child:@"image_thumb"]);
        //NSLog(@"deals are %@\n",deals);
       
        
    }
    
    return self;
}

- (void)dealloc {
    
}

@end
