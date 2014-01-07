//
//  FindNews.h
//  Simplr
//
//  Created by Eric on 4/2/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindNews : NSObject{
    NSString *location;
    NSArray *stories;
}

@property (nonatomic,retain) NSString *location;
@property (nonatomic) NSString *zipCode;
@property (nonatomic) NSMutableArray *deals;
@property (nonatomic, retain) NSArray *stories;


- (FindNews *)initWithQuery:(NSString *)query;

@end
