//
//  NSDate+date.m
//  InfoTransit
//
//  Created by Omar on 22/7/16.
//  Copyright © 2016 SlashMobility. All rights reserved.
//

#import "NSDate+date.h"

@implementation NSDate (date)

- (NSDateFormatter*) formatHourMinute
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"HH:mm"];
    return format;
}

- (NSString*) getPrintHour
{
    return [[self formatHourMinute] stringFromDate:self];
}

- (NSDateComponents*) getGenericComponent
{
    NSDate *currentDate = self;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate]; // Get necessary date components
    return components;
}

- (NSDate*) plusMinutes:(NSInteger)plusMinutes
{
    NSDateComponents *components= [[NSDateComponents alloc] init];
    [components setMinute:plusMinutes];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:components toDate:self options:0];
    return newDate;
}

- (NSDate*) dateBeginFirstQuarter
{
    NSInteger minute = [self getMinute];
    NSDate *returnDate;
    NSInteger plusMinutes;
    
    if (minute <= 15)
    {
        plusMinutes = 15 - minute;
    }
    else if (minute <= 30)
    {
        plusMinutes = 30 - minute;
    }
    else if (minute <= 45)
    {
        plusMinutes = 45 - minute;
    }
    else
    {
        plusMinutes = 60 - minute;
    }
    
    returnDate = [self plusMinutes:plusMinutes];
    
    return returnDate;
}

- (NSInteger) getYear
{
    NSDateComponents *components = [self getGenericComponent];
    return [components year];
}

- (NSInteger) getDay
{
    NSDateComponents *components = [self getGenericComponent];
    return [components day];
}

- (NSInteger) getMonth
{
    NSDateComponents *components = [self getGenericComponent];
    return [components month];
}

- (NSInteger) getHour
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"HH"];
    return [[format stringFromDate:self] integerValue];
    
}

- (NSInteger) getMinute
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"mm"];
    return [[format stringFromDate:self] integerValue];
}

@end
