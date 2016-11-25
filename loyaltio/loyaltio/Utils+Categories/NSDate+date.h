//
//  NSDate+date.h
//  InfoTransit
//
//  Created by Omar on 22/7/16.
//  Copyright © 2016 SlashMobility. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (date)

- (NSDateFormatter*) formatHourMinute;

- (NSString*) getPrintHour;

- (NSDateComponents*) getGenericComponent;

- (NSDate*) plusMinutes:(NSInteger)plusMinutes;

- (NSDate*) dateBeginFirstQuarter;

- (NSInteger) getDay;
- (NSInteger) getMonth;
- (NSInteger) getYear;

- (NSInteger) getHour;
- (NSInteger) getMinute;


@end
