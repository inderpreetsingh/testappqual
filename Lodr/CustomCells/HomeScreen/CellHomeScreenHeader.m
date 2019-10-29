//
//  CellHomeScreenHeader.m
//  Lodr
//
//  Created by Payal Umraliya on 17/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellHomeScreenHeader.h"

@implementation CellHomeScreenHeader

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  [self.cellHomeScreenHeaderDelegate cvHome_numberOfSectionsInCollectionView:collectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.cellHomeScreenHeaderDelegate cvHome_collectionView:collectionView numberOfItemsInSection:section];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  [self.cellHomeScreenHeaderDelegate cvHome_collectionView:collectionView cellForItemAtIndexPath:indexPath];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellHomeScreenHeaderDelegate cvHome_collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellHomeScreenHeaderDelegate cvHome_collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (IBAction)btnPrevClicked:(id)sender 
{
    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.cvCounters scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    [self.cellHomeScreenHeaderDelegate btnPrevClicked:sender];
}
- (IBAction)btnNextClicked:(id)sender {
    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:2 inSection:0];
    [self.cvCounters scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    [self.cellHomeScreenHeaderDelegate btnNextClicked:sender];
}
@end
