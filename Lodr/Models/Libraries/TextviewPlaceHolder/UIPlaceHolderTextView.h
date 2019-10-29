//
//  UIPlaceHolderTextView.h
//  SallMallClassified
//
//  Created by C68 on 25/12/14.
//  Copyright (c) 2014 pu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;
@end
