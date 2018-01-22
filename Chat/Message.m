//
//  Message.m
//  Chat
//
//  Created by leng on 14-3-2.
//  Copyright (c) 2014年 123. All rights reserved.
//

#import "Message.h"

@implementation Message
@synthesize strContent;  //消息内容
@synthesize strTime;    //发消息时间
@synthesize strIcon;    //头像
@synthesize bType;      //自己或别人发的消息

@synthesize iconRect;
@synthesize timeRect;
@synthesize contentRect;
@synthesize cellHeight;
@synthesize bShowTime;

-(void)SetDatas:(NSString*)content WithTime:(NSString*)time WithIcon:(NSString*)icon WithType:(MessageType)type WithBShowTime:(bool)b
{
    strContent = [content copy];
    strIcon = [icon copy];
    strTime = [time copy];
    bType = type;
    bShowTime=b;
    
    //头像 内容开始的高度  跟有无时间有关
    CGFloat beginY = 0;
    //屏幕宽度
    CGFloat screenWith = [UIScreen mainScreen].bounds.size.width;
    
    // 时间位置
    if (bShowTime)
    {
        CGSize timeSize = [strTime sizeWithFont:kTimeFont];
        timeRect = CGRectMake((screenWith-timeSize.width)/2, kMargin, timeSize.width, timeSize.height);
        beginY = kMargin+timeSize.height;
    }
    
    //头像位置
    CGFloat iconX = kMargin;
    if (type==MessageTypeMe)
        iconX = screenWith - kMargin - kIconWH;
    iconRect = CGRectMake(iconX, beginY+kMargin, kIconWH, kIconWH);
    
    //内容位置
    CGFloat contentX = iconX+ kIconWH+kMargin;
    CGSize contentSize = [strContent sizeWithFont:kContentFont
                                constrainedToSize:CGSizeMake(screenWith*0.6 , CGFLOAT_MAX)];
    if (type==MessageTypeMe)
        contentX=iconX-kMargin-contentSize.width-kContentLeft-kContentRight;
    contentRect=CGRectMake(contentX, beginY+kMargin
                           , contentSize.width+kContentLeft+kContentRight
                           , contentSize.height+kContentTop+kContentBottom);
    
    //计算高度
    cellHeight = beginY+kMargin+contentSize.height+kContentTop+kContentBottom+kMargin;

//    NSLog(@"%f + %f = %f",beginY,contentSize.height,cellHeight);
    
}


@end
