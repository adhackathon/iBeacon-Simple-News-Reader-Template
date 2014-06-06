//
//  NewsViewController.m
//  News Reader Template
//

#import "NewsViewController.h"
#import "StoryViewController.h"
#import "RSSParser.h"
#import "RSSItem.h"

@interface NewsViewController () {
    RSSItem *item;
}

@end

@implementation NewsViewController

@synthesize newsFeed, tableView;

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
    
    [self setTitle:@"Loading..."];
    
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://rss.nytimes.com/services/xml/rss/nyt/InternationalHome.xml"]];
    [RSSParser parseRSSFeedForRequest:req success:^(NSArray *feedItems) {
        [self setTitle:@"News Reader Template"];
        [self setNewsFeed:feedItems];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self setTitle:@"Error"];
        NSLog(@"Error: %@",error);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [newsFeed count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    item = [newsFeed objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:item.title];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = [item title];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM dd, HH:mm"];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:item.pubDate];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        UITableViewCell *cell = (UITableViewCell*)sender;
        NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
        StoryViewController * story = (StoryViewController *)[segue destinationViewController];
        story.item = [newsFeed objectAtIndex:indexPath.row];
}

@end
