//
//  ExperienceCard.m
//  Mana
//
//  Created by Scott Shebby on 6/12/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ExperienceCard.h"
#import "UIImageView+WebCache.h"
#import "NSDate+ShortCuts.h"

@interface ExperienceCard ()
@property(nonatomic,weak) IBOutlet UILabel * titleLabel;
@property(nonatomic,weak) IBOutlet UILabel * descriptionLabel;
@property(nonatomic,weak) IBOutlet UILabel * manaCostLabel;
@property(nonatomic,weak) IBOutlet UILabel * locationLabel;
@property(nonatomic,weak) IBOutlet UILabel * dayLabel;
@property(nonatomic,weak) IBOutlet UILabel * timeLabel;
@property(nonatomic,weak) IBOutlet UIImageView * experienceImageView;
@property(nonatomic,weak) ExperienceSnapshot * experience;

@property(nonatomic,weak) IBOutlet UIImageView * profilePhotoImageView_1;
@property(nonatomic,weak) IBOutlet UIImageView * profilePhotoImageView_2;
@property(nonatomic,weak) IBOutlet UIImageView * profilePhotoImageView_3;
@property(nonatomic,weak) IBOutlet UIImageView * profilePhotoImageView_4;
@property(nonatomic,weak) IBOutlet UILabel * profileNameLabel;
@property(nonatomic,weak) IBOutlet UILabel * profileLocationLabel;
@property(nonatomic,weak) IBOutlet UILabel * taglineLabel;

@end

@implementation ExperienceCard


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setExperienceSnapshot:(ExperienceSnapshot*)experience
{
    self.experience = experience;
    self.titleLabel.text = experience.title;
    self.experienceImageView.image = experience.image;
    self.locationLabel.text = experience.location;
    self.manaCostLabel.text = experience.manaCost;
    
    if( experience.isAnytime ){
        self.timeLabel.hidden = YES;
        self.dayLabel.text = @"Anytime!";
    }
    else{
        self.timeLabel.hidden = YES;
        self.dayLabel.text = [experience.startDateTime shortString];
//        self.timeLabel.text = [experience.startDateTime timeString];
    }
    [self loadProfileInformation];
    
    [User meWithCompletion:^(FDataSnapshot * snapshot) {
        self.taglineLabel.text = [FirebaseSnapshot stringField:@"tagline" fromSnapshot:snapshot];
    }];
}

- (void) loadProfileInformation{
    NSString * path = [NSString stringWithFormat:@"/%@?fields=picture.height(961),first_name,birthday,location,albums", self.experience.creator];
    [FBRequestConnection startWithGraphPath:path
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  NSLog(@"user events: %@", result);
                                  NSDictionary * picture = result[@"picture"];
                                  NSDictionary * albums  = result[@"albums"];
                                  NSDictionary * data    = picture[@"data"];
                                  NSString     * urls    = data[@"url"];
                                  self.profileNameLabel.text = result[@"first_name"];
                                  self.profileLocationLabel.text = result[@"location"][@"name"];
                                  [self.profilePhotoImageView_1 setImageWithURL:[NSURL URLWithString:urls]];
                                  [self performSelector:@selector(loadAdditionalPhotos:) withObject:albums afterDelay:0.1];
                              } else {
                                  NSLog([error localizedDescription]);
                              }
                          }];
    

}



- (void) loadAdditionalPhotos:(NSDictionary*)albums{
    NSArray * data = albums[@"data"];
    NSString * album_ide;
    for( int i=0; i< data.count; i++ ){
        NSDictionary * entry = data[i];
        NSString * name = entry[@"name"];
        if( [name isEqualToString:@"Profile Pictures"] ){
            album_ide = entry[@"id"];
            break;
        }
    }
    
    if( album_ide ){
        NSString * graph_request = [NSString stringWithFormat:@"/%@/photos?fields=images", album_ide];
        [FBRequestConnection startWithGraphPath:graph_request
                              completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                  if (!error) {
                                      NSLog(@"user events: %@", result);
                                      NSArray * data    = result[@"data"];
                                      for( int i=0;i< data.count; i++ ){
                                          NSDictionary * entry = data[i];
                                          NSArray * images = entry[@"images"];
                                          NSDictionary * urld = [images firstObject];
                                          NSURL * url = urld[@"source"];
                                        
                                          switch (i) {
                                              case 1:
                                                  [self.profilePhotoImageView_2 setImageWithURL:url];
                                                  break;
                                              case 2:
                                                  [self.profilePhotoImageView_3 setImageWithURL:url];
                                                  break;
                                              case 3:
                                                  [self.profilePhotoImageView_4 setImageWithURL:url];
                                                  break;
                                              default:
                                                  break;
                                          }
                                      }
                                      
                                  } else {
                                      NSLog([error localizedDescription]);
                                  }
                              }];
        
        
    }
    else{
        NSLog(@"Unable to find cover photos");
    }
    
}



@end
