//
//  DealsCell.h
//  Simplr
//
//  Created by Eric on 4/2/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealsCell : UITableViewCell


@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *blurbLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

@end
