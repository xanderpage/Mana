//
//  ExperienceList.m
//  Mana
//
//  Created by Scott Shebby on 6/12/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ExperienceList.h"
#import "ExperienceCard.h"

@interface ExperienceList()
@property(nonatomic) NSArray * keys;
@property(nonatomic) NSDictionary * snapshot;
@end

@implementation ExperienceList

- (id) initWithDelegate:(id<ExperienceListDelegate>)del{
    self = [super init];
    self.delegate = del;
    if( self ){
        Firebase * fb = [[Firebase alloc] initWithUrl:@"https://glowing-fire-7751.firebaseio.com/experiences"];
        [fb observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            self.snapshot = snapshot.value;
            self.keys = self.snapshot.allKeys;
            [self.delegate experienceListDidFinishLoading:self];
        }];
    }
    return self;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.keys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExperienceCard * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExperienceCard" forIndexPath:indexPath];
    

    NSString * key = [self.keys objectAtIndex:indexPath.row];
    NSDictionary * dic = self.snapshot[key];
    ExperienceSnapshot * e = [[ExperienceSnapshot alloc] initWithSnapshotValue:dic ];
    [cell setExperienceSnapshot:e];
    return cell;
}



@end
