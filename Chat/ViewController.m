//
//  ViewController.m
//  Chat
//
//  Created by leng on 14-3-2.
//  Copyright (c) 2014年 123. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"
#import "Message.h"

@interface ViewController ()
{
    NSMutableArray *_messageArray;
}
@end

@implementation ViewController
@synthesize tableView;
@synthesize textFied;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    //设置tableview属性
    textFied.delegate=self;
    textFied.keyboardAppearance = UIReturnKeySend;
    _messageArray = [[NSMutableArray alloc] init];
    tableView.delegate=self;
    tableView.dataSource=self;
 //   tableView.allowsSelection = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //没有横线
    tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
    
 
    Message *mess = [[Message alloc] init];
    Message *mess2 = [[Message alloc] init];
    Message *mess3 = [[Message alloc] init];
    
    [mess SetDatas:@"在" WithTime:@"12:12" WithIcon:@"me.png" WithType:MessageTypeMe WithBShowTime:true];
    [_messageArray addObject:mess];
    [mess2 SetDatas:@"不要问我在不在，你问我在不在，我也不会告诉你我在不在，既然我不会告诉你我在不在，你又为什么要问我在不在，为什么要问我在不在？" WithTime:@"12:22" WithIcon:@"you.png" WithType:MessageTypeOther WithBShowTime:true];
    [_messageArray addObject:mess2];
    [mess3 SetDatas:@"好吧" WithTime:@"12:22" WithIcon:@"me.png" WithType:MessageTypeMe WithBShowTime:true];
    [_messageArray addObject:mess3];
    
    [tableView reloadData];
    
    //键盘消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    NSLog(@"初始化完毕");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message *mess=_messageArray[[indexPath row]];
    NSString *str = mess.strContent;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"选中" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // 设置数据
    Message *mess= _messageArray[indexPath.row];
    BOOL b=true;
    if (indexPath.row!=0)
        if ( [mess.strTime isEqualToString:((Message*)_messageArray[indexPath.row-1]).strTime])
             mess.bShowTime=b=FALSE;
    [cell SetDatas:mess.strContent WithTime:mess.strTime WithIcon:mess.strIcon WithType:mess.bType WithBShowTime:b];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [(Message*)_messageArray[indexPath.row] cellHeight];
    Message *mess= _messageArray[indexPath.row];
    
    if (indexPath.row!=0)
        if ( [mess.strTime isEqualToString:((Message*)_messageArray[indexPath.row-1]).strTime])
        {
            CGSize timeSize = [mess.strTime sizeWithFont:kTimeFont];
            height-=kMargin+timeSize.height;
        }
    
    return height;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark - 键盘处理
#pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = - rect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
//    NSLog(@"键盘位置 %f",ty);
}
#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}
#pragma mark - 文本框代理方法
#pragma mark 点击textField键盘的回车按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    Message *mess = [[Message alloc] init];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"HH:mm"; // @"yyyy-MM-dd HH:mm:ss"
    NSString *time = [fmt stringFromDate:date];
    [mess SetDatas:textFied.text WithTime:time WithIcon:@"me.png" WithType:MessageTypeMe WithBShowTime:true];
    [_messageArray addObject:mess];  textFied.text=nil;
    [tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_messageArray.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(OnTimer)userInfo:nil repeats:NO];
    return YES;

}
-(void)OnTimer
{
    Message *mess = [[Message alloc] init];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"HH:mm"; // @"yyyy-MM-dd HH:mm:ss"
    NSString *time = [fmt stringFromDate:date];
    [mess SetDatas:@"哈哈" WithTime:time WithIcon:@"you.png" WithType:MessageTypeOther WithBShowTime:true];
    [_messageArray addObject:mess];  textFied.text=nil;
    [tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_messageArray.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
-(IBAction)btn:(id)sender
{
    
}

@end
