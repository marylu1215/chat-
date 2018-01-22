//
//  Message.h
//  Chat
//
//  Created by leng on 14-3-2.
//  Copyright (c) 2014年 123. All rights reserved.
//
#define kMargin 10 //间隔
#define kIconWH 40 //头像宽高
#define kContentW 180 //内容宽度

#define kTimeMarginW 15 //时间文本与边框间隔宽度方向
#define kTimeMarginH 10 //时间文本与边框间隔高度方向

#define kContentTop 10 //文本内容与按钮上边缘间隔
#define kContentLeft 25 //文本内容与按钮左边缘间隔
#define kContentBottom 15 //文本内容与按钮下边缘间隔
#define kContentRight 15 //文本内容与按钮右边缘间隔

#define kTimeFont [UIFont systemFontOfSize:12] //时间字体
#define kContentFont [UIFont systemFontOfSize:16] //内容字体
#import <Foundation/Foundation.h>

typedef enum {
    
    MessageTypeMe = 0,    // 自己发的
    MessageTypeOther = 1  //别人发的
    
} MessageType;

@interface Message : NSObject

@property(copy,nonatomic)NSString      *strContent; //消息内容
@property(copy,nonatomic)NSString      *strTime;    //发消息时间
@property(copy,nonatomic)NSString      *strIcon;    //头像
@property(assign,nonatomic)MessageType  bType;      //自己或别人发的消息


@property (nonatomic, assign) CGRect  iconRect;
@property (nonatomic, assign) CGRect  timeRect;
@property (nonatomic, assign) CGRect  contentRect;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) BOOL    bShowTime;

-(void)SetDatas:(NSString*)content WithTime:(NSString*)time WithIcon:(NSString*)icon WithType:(MessageType)type WithBShowTime:(bool)b;

@end
