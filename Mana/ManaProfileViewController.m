//
//  ManaProfileViewController.m
//  Mana
//
//  Created by Scott Shebby on 5/26/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ManaProfileViewController.h"
#import "NSDate+ShortCuts.h"
#import "UIViewController+MMDrawerController.h"


@interface ManaProfileViewController ()
@property(nonatomic,weak) IBOutlet KIImagePager * profileImageView;
@property(nonatomic,weak) IBOutlet UIImageView * coverImageView;
@property(nonatomic,weak) IBOutlet UILabel      * nameLabel;
@property(nonatomic,weak) IBOutlet UILabel      * locationLabel;
@property(nonatomic) NSMutableArray * profilePhotoUrls;
@property(nonatomic) NSMutableArray * facebookPhotos;
@end

@implementation ManaProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.profilePhotoUrls = [NSMutableArray new];
    self.facebookPhotos   = [NSMutableArray new];
    [FBRequestConnection startWithGraphPath:@"/me?fields=picture.height(961),cover,albums"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  NSLog(@"user events: %@", result);
                                  NSDictionary * picture = result[@"picture"];
                                  NSDictionary * albums  = result[@"albums"];
                                  NSDictionary * data    = picture[@"data"];
                                  NSString     * urls    = data[@"url"];
                                                                    
                                  [self performSelector:@selector(loadAdditionalPhotos:) withObject:albums afterDelay:0.1];
                              } else {
                                  NSLog([error localizedDescription]);
                              }
                          }];

    self.locationLabel.text = [ManaUserManager sharedInstance].facebookUser.location.name;

    NSInteger age = [NSDate ageFromFacebookBirthday:[ManaUserManager sharedInstance].facebookUser.birthday];
    self.nameLabel.text = [NSString stringWithFormat:@"%@, %d",[ManaUserManager sharedInstance].facebookUser.first_name, age];
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
                                          NSDictionary * url = [images firstObject];
                                          [self.facebookPhotos addObject:url];
                                          [self.profilePhotoUrls addObject:url[@"source"]];
                                      }
                                      
                                      [self.profileImageView reloadData];
                                  } else {
                                      NSLog([error localizedDescription]);
                                  }
                              }];
        

    }
    else{
        NSLog(@"Unable to find cover photos");
    }
    
}


- (IBAction)leftBarButtonItemPressed:(id)sender{
    [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImage*) placeHolderImageForImagePager{
    return [[UIImage alloc] init];
}
- (NSArray*) arrayWithImages{

    return self.profilePhotoUrls;
}
- (UIViewContentMode) contentModeForImage:(NSUInteger)image
{
    NSDictionary * entry = self.facebookPhotos[image];
    int height = [entry[@"height"] intValue];
    int width  = [entry[@"width"] intValue];
    
    int vw      = self.profileImageView.frame.size.width;
    int vh      = self.profileImageView.frame.size.height;
    float aspect = (float)width/(float)height;

    if( aspect > 1. ){
        return UIViewContentModeScaleAspectFit;
    }
    
    return UIViewContentModeScaleAspectFill;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
