//
//  CountdownSeting.m
//  time_date
//
//  Created by Yun_He_Lee on 15/9/14.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import "CountdownSeting.h"

@implementation CountdownSeting

@end

@implementation CountdownButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)scale:(CountdownSeting*)setting {
    self.titleLabel.transform = CGAffineTransformMakeScale(1, 1);
    self.titleLabel.alpha     = 1;
    [self setTitleColor:setting.colorTitle ? setting.colorTitle : [UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:setting.colorTitle ? setting.colorTitle : [UIColor whiteColor] forState:UIControlStateDisabled];
    if (setting.indexStart > 0)
    {
        self.backgroundColor = setting.colorDisable ? setting.colorDisable : [UIColor lightGrayColor];
        [self setEnabled:NO];
//        NSString* title = [NSString stringWithFormat:@"   %@%d%@   ",(setting.strPrefix ? setting.strPrefix : @""),setting.indexStart,(setting.strSuffix ? setting.strSuffix : @"")];
//        NSLog(@"%@",title);
        [self setTitle:[self timeDifference:@"2015年09月16日14时30分25秒"] forState:UIControlStateNormal];
        [self setTitle:[self timeDifference:@"2015年09月16日14时30分25秒"] forState:UIControlStateDisabled];
        
        __weak typeof (self) wSelf = self;
        [UIView animateWithDuration:1 animations:^{
            self.titleLabel.transform = CGAffineTransformMakeScale(1.2, 1.2);
            self.titleLabel.alpha     = 0.0;
        } completion:^(BOOL b){
            setting.indexStart--;
            [wSelf scale:setting];
        }];
    }
    else {
       //倒计时完成
    }
}
#pragma mark - 启动函数
- (void)startWithSetting:(CountdownSeting *)setting {
    [self scale:setting];
}
-(NSString *)timeDifference:(NSString *)endTime{
    NSRange range = [endTime rangeOfString:@"年"];
    range.location= 0;
    range.length = 4;
    NSString *year = [endTime substringWithRange:range];
    
    NSRange range_month = [endTime rangeOfString:@"月"];
    range_month.location= range.length+1;
    range_month.length = 2;
    NSString *month = [endTime substringWithRange:range_month];
    
    NSRange range_day = [endTime rangeOfString:@"日"];
    range_day.location=range_month.location+3;
    range_day.length=2;
    NSString *day = [endTime substringWithRange:range_day];
    
    NSRange range_hour = [endTime rangeOfString:@"时"];
    range_hour.location =range_day.location+3;
    range_hour.length=2;
    NSString *hour = [endTime substringWithRange:range_hour];
    
    NSRange range_minute = [endTime rangeOfString:@"分"];
    range_minute.location =range_hour.location+3;
    range_minute.length=2;
    NSString *minute = [endTime substringWithRange:range_minute];
    
    NSRange range_second = [endTime rangeOfString:@"秒"];
    range_second.location =range_minute.location+3;
    range_second.length=2;
    NSString *second = [endTime substringWithRange:range_second];
    
    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    NSDateComponents *time = [[NSDateComponents alloc] init];    //初始化目标时间...奥运时间好了
    [time setYear:[year intValue]];
    [time setMonth:[month intValue]];
    [time setDay:[day intValue]];
    [time setHour:[hour intValue]];
    [time setMinute:[minute intValue]];
    [time setSecond:[second intValue]];
    NSDate *todate = [cal dateFromComponents:time]; //把目标时间装载入date
    NSDate *today = [NSDate date];    //得到当前时间
    //用来得到具体的时差
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:todate options:0];
    NSString *dateTime = [NSString stringWithFormat:@"%ld日%ld时%ld分%ld秒", [d day], [d hour], [d minute], [d second]];
    return dateTime;
}
@end