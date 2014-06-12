//
//  ExperienceList.h
//  Mana
//
//  Created by Scott Shebby on 6/12/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ExperienceList;

@protocol ExperienceListDelegate <NSObject>

- (void) experienceListDidFinishLoading:(ExperienceList*)e;

@end

@interface ExperienceList : NSObject<UICollectionViewDataSource>
@property(nonatomic) id<ExperienceListDelegate> delegate;
- (id) initWithDelegate:(id<ExperienceListDelegate>)del;
@end
