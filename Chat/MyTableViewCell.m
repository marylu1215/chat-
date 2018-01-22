//
//  MyTableViewCell.m
//  Chat
//
//  Created by leng on 14-3-2.
//  Copyright (c) 2014年 123. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell
@synthesize message;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        message = [[Message alloc] init];
        //创建时间
        _timeBtn = [[UIButton alloc] init];
        [_timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _timeBtn.titleLabel.font = kTimeFont;
        _timeBtn.enabled = NO;
        [_timeBtn setBackgroundImage:[UIImage imageNamed:@"time.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_timeBtn];
        
        //创建头像
        _iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconView];
        
        //创建内容
        _contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _contentBtn.titleLabel.font = kContentFont;
        _contentBtn.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentBtn];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)SetDatas:(NSString*)content WithTime:(NSString*)time WithIcon:(NSString*)icon WithType:(MessageType)type WithBShowTime:(bool)b
{
    [message SetDatas:content WithTime:time WithIcon:icon WithType:type WithBShowTime:b];
    // 1、设置时间
    [_timeBtn setTitle:message.strTime forState:UIControlStateNormal];
    _timeBtn.frame = message.timeRect;
    _timeBtn.hidden = !message.bShowTime;
    
    // 2、设置头像
    _iconView.image = [UIImage imageNamed:message.strIcon];
    _iconView.frame = message.iconRect;
    
    // 3、设置内容
    [_contentBtn setTitle:message.strContent forState:UIControlStateNormal];
    _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentLeft, kContentBottom, kContentRight);
    _contentBtn.frame = message.contentRect;
    
    if (message.bType == MessageTypeMe) {
        _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentRight, kContentBottom, kContentLeft);
    }
    //聊天内容底图片
    UIImage *normal , *focused;
    if (message.bType == MessageTypeMe) {
        
        normal = [UIImage imageNamed:@"chat_me.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"chat_me2.png"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
    }else{
        
        normal = [UIImage imageNamed:@"chat_other.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"chat_other2.png"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
        
    }
    [_contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
    [_contentBtn setBackgroundImage:focused forState:UIControlStateHighlighted];

}


@end
