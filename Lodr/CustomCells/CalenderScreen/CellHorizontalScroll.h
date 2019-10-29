//
//  CellHorizontalScroll.h
//  PUCalender
//
//  Created by c196 on 08/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Equipments.h"
#import "MyNetwork.h"
#import "Loads.h"
@protocol HorizontalScrollCellDelegate <NSObject>
@optional
-(void)cellSelected_driver:(UITapGestureRecognizer *)recognizer;
-(void)cellSelected_equi:(UITapGestureRecognizer *)recognizer;
-(void)cellSelected_load:(UITapGestureRecognizer *)recognizer;
@end

@interface CellHorizontalScroll : UICollectionViewCell <UIScrollViewDelegate>
{
    CGFloat supW;
    CGFloat off;
    CGFloat diff;
}


@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
-(void)setUpCellWithArray:(NSArray *)array;

@property (nonatomic,strong) id<HorizontalScrollCellDelegate> cellDelegate;
-(void)setUpCellWithDIc:(NSMutableDictionary *)dic :(Equipments *)equi :(NSString *)vwname;
-(void)setUpCellWithDIcDriver:(NSMutableDictionary *)dic :(MyNetwork *)equi;
-(void)setUpCellWithDIcLoad:(NSMutableDictionary *)dic :(Loads *)equi;
-(void)setUpCellWithDIcArr:(NSMutableDictionary *)dic :(NSArray *)arr;
@end
