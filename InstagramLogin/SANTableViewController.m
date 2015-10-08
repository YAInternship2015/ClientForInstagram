//
//  SANTableViewController.m
//  InstagramLogin
//
//  Created by Admin on 07.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANTableViewController.h"
#import "SANServerManager.h"
#import "SANTag.h"
#import "UIImageView+AFNetworking.h"

@interface SANTableViewController () <XXX>

@property (nonatomic, strong) NSArray *array;

@end

@implementation SANTableViewController
- (IBAction)reload:(UIBarButtonItem *)sender {
   
    [self.tableView reloadData];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
      
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSArray array];
    
    SANServerManager *manager = [[SANServerManager alloc] init];
    [manager authorizeUser:^(SANTag *tag) {
        
        NSLog(@"authorization");
        
    }];
    manager.delegate = self;

}

-(void) rel:(NSArray *)array {
    self.array = array;
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.tableView reloadData];

}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    SANTag *tag = self.array[indexPath.row];
    
    cell.textLabel.text = tag.text;
    
    NSString *str = [NSString stringWithFormat:@"%@", tag.imagePath];
    NSURL *url = [NSURL URLWithString:str];
    
    
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    __weak UITableViewCell* weakCell = cell;
    cell.imageView.image = nil;
    [cell.imageView
     setImageWithURLRequest:request
     placeholderImage:nil
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
         weakCell.imageView.image = image;
         [weakCell layoutSubviews];
     }
     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
         
     }];

    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
