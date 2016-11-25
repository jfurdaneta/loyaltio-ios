//
//  BlueToothCharacterist.h
//  PeripheralModeTest
//
//  Created by Omar on 2/5/16.
//  Copyright © 2016 Oltica. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define kUUIDwriteCommand @"b51b62fe-1904-11e6-b6ba-3e1d05defe78"
#define kUUIDreadValues   @"b51b7078-1904-11e6-b6ba-3e1d05defe78"

//#define kUUIDreadWaterSetting @"b51b7078-1904-11e6-b6ba-3e1d05defe78"
//#define kUUIDreadHeartSetting @"b51b7140-1904-11e6-b6ba-3e1d05defe78"
//#define kUUIDreadCookingTime @"b51b7488-1904-11e6-b6ba-3e1d05defe78"


typedef NS_ENUM(NSUInteger, TypeCharacteristic) {
    TypeCommand = 0,
    TypeStatusUser = 1,
    TypeStatusLed = 2,
    TypeAlarm = 3,
    TypeWaterSetting =4,
    TypeHeartSetting = 5,
    TypeTimeReaminding = 6,
    TypeBatery = 8,
    TypeWaterTemp = 9,
    TypeHeartTemp = 11,
    
    TypeUDID = 13,
    
    TypeReadWater,
    TypeReadHeart,
    TypeReadCookTime,
    
    TypeReadValues,
    TypeUnknown,
};
@interface BlueToothCharacterist : NSObject


@property (nonatomic, strong) CBMutableCharacteristic *chWriteCommand;
@property (nonatomic, strong) CBMutableCharacteristic *chReadValues;


/**
 *  create the characteristics
 */
- (void) createCharacterist;

/**
 *  get all the charactirst available
 *
 *  @return values
 */
- (NSArray*) getAllCharacterist;

/**
 *  process read / write value
 *
 *  @param request    objectPlaca
 *  @param isWrite    to know if there is a write mode or no
 *  @param completion return the manage data
 */
- (void) processRequest:(CBATTRequest*) request isWriteCharacterist:(BOOL) isWrite withCompletion:(void(^)(TypeCharacteristic charact, NSString *nameCharac, NSData *dataToResponse)) completion;

/**
 *  Transfor the nsdata that write placa into a string
 *
 *  @param value binary
 *
 *  @return return string
 */
- (NSString*) getWriteValueFromMaster:(NSData*) value;

@end
