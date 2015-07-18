//
//  NSTableViewCell.m
//
//
//  Created by Kevin Zhang on 11/19/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "NSTableViewCell.h"

@implementation NSTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setup];
    [self.textLabel styleTableViewRowContent];
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

-(void)setup {
    self.backgroundColor = [UIColor whiteColor];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
