//
//  RSVPCell.m
//  Mana
//
//  Created by Scott Shebby on 5/30/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "RSVPCell.h"

@interface RSVPCell ()
@property(nonatomic) IBOutlet UILabel * counterLabel;
@property(nonatomic) IBOutlet UICollectionView * collectionView;
@end

@implementation RSVPCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void) prepareForReuse{
}
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (void) updateCounter{
    NSIndexPath * indexPath = self.collectionView.indexPathsForVisibleItems.firstObject;
    NSInteger items = [self collectionView:self.collectionView numberOfItemsInSection:indexPath.section];

    self.counterLabel.text = [NSString stringWithFormat:@"%ld of %ld", (indexPath.row+1), items];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self updateCounter];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateCounter];
}
- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [self updateCounter];
    return cell;
}
@end
