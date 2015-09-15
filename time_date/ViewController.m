//
//  ViewController.m
//  time_date
//
//  Created by Yun_He_Lee on 15/9/14.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import "ViewController.h"
#import "CountdownSeting.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CountdownButton* btn = [[CountdownButton alloc] initWithFrame:CGRectMake(40, 200, 300, 44)];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    
    [self.view addSubview:btn];
    
    [self btnAction:btn];
    
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)btnAction:(id)sender {
    NSLog(@"click");
    CountdownButton* btn = (CountdownButton*)sender;
    CountdownSeting* setting = [[CountdownSeting alloc] init];
    setting.indexStart = [self getTheCountdown:@"0000年09月16日14时30分25秒"];
    [btn startWithSetting:setting];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(unsigned int)getTheCountdown:(NSString *)time{
    NSRange range = [time rangeOfString:@"年"];
    range.location= 0;
    range.length = 4;
    NSString *year = [time substringWithRange:range];
    
    NSRange range_month = [time rangeOfString:@"月"];
    range_month.location= range.length+1;
    range_month.length = 2;
    NSString *month = [time substringWithRange:range_month];
    
    NSRange range_day = [time rangeOfString:@"日"];
    range_day.location=range_month.location+3;
    range_day.length=2;
    NSString *day = [time substringWithRange:range_day];
    
    NSRange range_hour = [time rangeOfString:@"时"];
    range_hour.location =range_day.location+3;
    range_hour.length=2;
    NSString *hour = [time substringWithRange:range_hour];
    
    NSRange range_minute = [time rangeOfString:@"分"];
    range_minute.location =range_hour.location+3;
    range_minute.length=2;
    NSString *minute = [time substringWithRange:range_minute];
    
    NSRange range_second = [time rangeOfString:@"秒"];
    range_second.location =range_minute.location+3;
    range_second.length=2;
    NSString *second = [time substringWithRange:range_second];
    unsigned int day_int = [day intValue];
    unsigned int hour_int = [hour intValue];
    unsigned int minute_int = [minute intValue];
    unsigned int second_int = [second intValue];
    
    return day_int*86400+hour_int*3600+minute_int*60+second_int;
}

-(NSDate *)CurrentDayTime:(NSString *)dataStr

{
    
    //设置转换的format
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    //获取当前年月日
    
    NSDate *currentdate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(
                                                        
                                                        NSYearCalendarUnit  |
                                                        
                                                        NSMonthCalendarUnit |
                                                        
                                                        NSDayCalendarUnit |
                                                        
                                                        NSHourCalendarUnit |
                                                        
                                                        NSMinuteCalendarUnit
                                                        
                                                        ) fromDate:currentdate];
    
    NSInteger year = [components year];
    
    NSInteger month = [components month];
    
    NSInteger day = [components day];
    
    NSString *strDate = [NSString stringWithFormat:@"%d-%d-%d %@",year,month,day,dataStr];
    
    NSDate *date = [dateFormatter dateFromString:strDate];
    
    return date;
    
}
-(BOOL)checkCanDinner

{
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:[self CurrentDayTime:@"08:59"]] == NSOrderedDescending //late
        
        && [currentDate compare:[self CurrentDayTime:@"13:59"]] == NSOrderedAscending //early
        
        )
        
    {
        
        NSLog(@"因较多餐厅休息,9:00之前掌上餐厅不接收订餐，为您带来的不便请谅解。");

        
        return YES;
        
    }
    
    else if([currentDate compare:[self CurrentDayTime:@"09:00"]] ==NSOrderedAscending //early
            
            && [currentDate compare:[self CurrentDayTime:@"00:00"]] ==  NSOrderedDescending//late
            
            )
        
    {
        
        NSLog(@"因较多餐厅休息,9:00之前掌上餐厅不接收订餐，为您带来的不便请谅解。");
        
        return NO;
        
    }
    
    else if([currentDate compare:[self CurrentDayTime:@"17:59"]] ==NSOrderedAscending //early
            
            && [currentDate compare:[self CurrentDayTime:@"14:00"]] ==  NSOrderedDescending//late
            
            )
        
    {
        
        NSLog(@"因较多餐厅休息,14:00以后掌上餐厅仅接收晚餐订餐,为您带来的不便请谅解。");
        
        return YES;
        
    }
    
    else if([currentDate compare:[self CurrentDayTime:@"21:00"]] ==NSOrderedAscending //early
            
            && [currentDate compare:[self CurrentDayTime:@"18:00"]] ==  NSOrderedDescending//late
            
            )
        
    {
        
        NSLog(@"因较多餐厅休息,14:00以后掌上餐厅仅接收晚餐订餐,为您带来的不便请谅解。");

        
        return YES;
        
    }
    
    else if([currentDate compare:[self CurrentDayTime:@"23:59"]] ==NSOrderedAscending //early
            
            && [currentDate compare:[self CurrentDayTime:@"21:00"]] ==  NSOrderedDescending//late
            
            )
        
    {
        
        NSLog(@"因较多餐厅休息,21:00以后掌上餐厅不接收订餐,为您带来的不便请谅解。");
        
        return NO;
        
    }
    
    return YES;
    
}

@end
