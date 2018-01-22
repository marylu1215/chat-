//
//  MyTableViewCell.h
//  Chat
//
//  Created by leng on 14-3-2.
//  Copyright (c) 2014年 123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
@class Message;

@interface MyTableViewCell : UITableViewCell
{
    UIButton *_timeBtn;
    UIButton *_contentBtn;
    UIImageView   *_iconView;
}
@property (nonatomic, copy) Message *message;
-(void)SetDatas:(NSString*)content WithTime:(NSString*)time WithIcon:(NSString*)icon WithType:(MessageType)type WithBShowTime:(bool)b;
@end
