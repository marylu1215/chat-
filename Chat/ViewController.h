//
//  ViewController.h
//  Chat
//
//  Created by leng on 14-3-2.
//  Copyright (c) 2014年 123. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(retain,nonatomic)IBOutlet UITableView *tableView;
@property(retain,nonatomic)IBOutlet UITextField *textFied;

-(IBAction)btn:(id)sender;
@end
