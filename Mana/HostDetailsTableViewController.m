//
//  HostDetailsTableViewController.m
//  Mana
//
//  Created by Scott Shebby on 5/20/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "HostDetailsTableViewController.h"
#import "UITableViewController+NextButtonSegue.h"
#import "TextInputViewController.h"

@interface HostDetailsTableViewController ()

@end

@implementation HostDetailsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
}
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self addNextButtonWithTitle:@"Publish Experience" andDelegate:self];
}
- (void) nextButtonTapped:(id)sender{
    
    [[ManaExperienceCreator sharedInstance].experience setPublished:YES];
    [self performSegueWithIdentifier:@"Confirm" sender:nil];
}
- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self removeNextButton];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (IBAction)showImagePicker:(id)sender{
    UIImagePickerController * picker =[[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:NO completion:nil];
}
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *img = info[UIImagePickerControllerEditedImage];
    
    [[ManaExperienceCreator sharedInstance].experience addImage:img];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath * indexPath = self.tableView.indexPathForSelectedRow;
    if( [segue.destinationViewController isKindOfClass:[TextInputViewController class]])
    {
        TextInputViewController * destination = (TextInputViewController*)segue.destinationViewController;
        switch (indexPath.row) {
            case 1:
                destination.field = @"Title";
                break;
            case 2:
                destination.field = @"Description";
                break;
            case 3:
                destination.field = @"Address";
                break;
            default:
                break;
        }
    }

    

}

@end
