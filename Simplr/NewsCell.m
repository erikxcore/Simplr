//
//  DealsCell.m
//  Simplr
//
//  Created by Eric on 4/2/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell


@synthesize articleTitle,blurbLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
