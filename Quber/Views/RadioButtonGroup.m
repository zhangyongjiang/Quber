//
//  RadioButtonGroup.m
//
//
//  Created by Kevin Zhang on 2/20/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "RadioButtonGroup.h"

@interface RadioButtonGroup()

@property(strong,nonatomic)NSArray* labels;
@property(strong,nonatomic)NSMutableArray* buttons;

@end

@implementation RadioButtonGroup

-(id)initWithFrame:(CGRect)frame andLabels:(NSArray *)labels  andColumnsPerRow:(int)columns{
    self = [super initWithFrame:frame];
    
    CGFloat width = self.width / columns;
    self.labels = labels;
    self.buttons = [NSMutableArray arrayWithCapacity:3];
    int current = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    for (NSString* optionTitle in labels) {
        x = width * (current % columns);
        y = (current / columns ) * RadioButtonHeight;
        RadioButton* btn = [[RadioButton alloc] initWithFrame:CGRectMake(x, y, width, RadioButtonHeight)];
        [btn h5];[btn book];[btn gray5];
        [btn addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
        [btn setTitle:optionTitle forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        [self addSubview:btn];
        [self.buttons addObject:btn];
        current++;
    }
    
    [self.buttons[0] setGroupButtons:self.buttons]; // Setting buttons into the group

    return self;
}

-(void) onRadioButtonValueChanged:(RadioButton*)sender {
}

-(NSString*)selected {
    for (RadioButton* btn in self.buttons) {
        if (btn.selected) {
            return btn.titleLabel.text;
        }
    }
    return nil;
}

-(void)setSelected:(NSString *)selected {
    for (RadioButton* btn in self.buttons) {
        if ([btn.titleLabel.text isEqualToString:selected]) {
            [btn setSelected:YES];
        }
    }
}
@end
