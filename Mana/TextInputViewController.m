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
@property(nonatomic) IBOutlet UILabel * titleLabel;
@property(nonatomic) IBOutlet UILabel * charactersRemainingLabel;
@property(nonatomic) NSNumber * characterLimit;
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
   
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [self.textView becomeFirstResponder];
    
    if( [self.field isEqualToString:@"Address"] ){
        self.titleLabel.text = @"Address & Directions";
        self.characterLimit = [NSNumber numberWithInt:100];
        self.textView.text = [ManaExperienceCreator sharedInstance].experience.address;
    }
    
    if( [self.field isEqualToString:@"Description"] ){
        self.titleLabel.text = @"Describe Your Experience";
        self.characterLimit = [NSNumber numberWithInt:100];
        self.textView.text = [ManaExperienceCreator sharedInstance].experience.description;
        
    }
    
    if( [self.field isEqualToString:@"Title"] ){
        self.titleLabel.text = @"Title For Your Experience";
        self.characterLimit = [NSNumber numberWithInt:100];
        self.textView.text = [ManaExperienceCreator sharedInstance].experience.title;
        
    }
    
    int rem = self.characterLimit.intValue - self.textView.text.length;
    
    self.charactersRemainingLabel.text = [NSString stringWithFormat:@"%d characters remaining", rem];

}
- (IBAction)helpButtonTapped:(id)sender{
    NSLog(@"Tappity tap");
}
- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if( [text isEqualToString:@""] ) return YES;
    NSInteger length = textView.text.length;
    NSInteger rem  = self.characterLimit.intValue - length;
    return rem > 0;
}
- (void) textViewDidChange:(UITextView *)textView{
    NSInteger length = textView.text.length;
    NSInteger rem  = self.characterLimit.intValue - length;
    self.charactersRemainingLabel.text = [NSString stringWithFormat:@"%ld characters remaining", rem];
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
