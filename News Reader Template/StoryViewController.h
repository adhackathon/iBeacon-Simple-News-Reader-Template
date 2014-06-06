//
//  StoryViewController.h
//  News Reader Template
//

#import <UIKit/UIKit.h>
#import "RSSItem.h"

@interface StoryViewController : UIViewController

@property (assign,nonatomic) RSSItem *item;
@property (strong, nonatomic) IBOutlet UIWebView *storyWebView;

@end
