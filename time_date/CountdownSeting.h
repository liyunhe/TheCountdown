//
//  CountdownSeting.h
//  time_date
//
//  Created by Yun_He_Lee on 15/9/14.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CountdownSeting : NSObject
@property(nonatomic,strong)NSString     *strCommon;//按钮可用时的文本
@property(nonatomic,strong)NSString     *strPrefix;//倒计时前缀
@property(nonatomic,strong)NSString     *strSuffix;//倒计时后缀
@property(nonatomic,assign)unsigned int          indexStart;//开始从几倒计时
@property(nonatomic,strong)UIColor      *colorDisable;//倒计时的背景颜色
@property(nonatomic,strong)UIColor      *colorCommon;//按钮可用时的背景颜色
@property(nonatomic,strong)UIColor      *colorTitle;//文本颜色


@end

@interface CountdownButton : UIButton

/**
 *  开始倒计时，此时按钮disable
 *
 *  @param setting 设置
 */
- (void)startWithSetting:(CountdownSeting*)setting;
@end

