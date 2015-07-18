//
//  CountryPickerView.h
//  ishopping
//
//  Created by Kevin Zhang on 5/24/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListValuePickerView : UIPickerView <UIPickerViewDataSource, UIPickerViewDelegate>

@property(strong,nonatomic)NSMutableArray* values;

@end
