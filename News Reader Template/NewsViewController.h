//
//  NewsViewController.h
//  News Reader Template
//
//  Simple News Reader Template with Estimote SDK included. The Reader uses the RSS Parser BlockRSSParser( https://github.com/tibo/BlockRSSParser ).
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) NSArray * newsFeed;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
