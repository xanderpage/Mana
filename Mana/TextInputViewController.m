//
//  TextInputViewController.m
//  Mana
//
//  Created by Scott Shebby on 6/8/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "TextInputViewController.h"
@interface TextInputViewController ()
@property(nonatomic) IBOutlet UITextView * textView;
@end

@implementation TextInputViewController

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
}
- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSString * text = self.textView.text;
    
    if( [self.field isEqualToString:@"Address"] ){
        [[ManaExperienceCreator sharedInstance].experience setAddress:text];
    }
    
    if( [self.field isEqualToString:@"Description"] ){
        [[ManaExperienceCreator sharedInstance].experience setDescription:text];
    }
    
    if( [self.field isEqualToString:@"Title"] ){
        [[ManaExperienceCreator sharedInstance].experience setTitle:text];
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}


@end
