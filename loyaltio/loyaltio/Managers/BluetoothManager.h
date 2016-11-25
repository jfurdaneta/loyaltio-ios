//
//  BluetoothManager.h
//  PeripheralModeTest
//
//  Created by Omar on 2/5/16.
//  Copyright © 2016 Oltica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import <Foundation/Foundation.h>
#import "BlueToothCharacterist.h"

#define TRANSFER_DEVICE_UUID @"0000FED8-0000-1000-8000-00805F9B34FB"

#define TRANSFER_SERVICE_UUID @"b51b5dfe-1904-11e6-b6ba-3e1d05defe78"

#define kTimeDisconecctInterval 2.0


@interface BluetoothManager : NSObject  <CBPeripheralManagerDelegate,CBCentralManagerDelegate,CBPeripheralDelegate>


@property (nonatomic, strong) CBPeripheralManager *manager;
@property (nonatomic, strong) CBCentralManager *centmanager;

@property (nonatomic, strong) BlueToothCharacterist *blueCharacteriscs;

//@property (nonatomic, assign, getter=isConnected) BOOL connected;

@property (nonatomic, strong) CBMutableService *servicea;

@property (nonatomic, strong) CBCentral *acCentral;
@property (nonatomic, strong) CBPeripheral *aCperipheral;


@property (nonatomic) NSDate *lastConnection;

/***************************************
 *
 *   master public methods
 *
 **************************************/

+ (id)sharedManager;

- (void) masterWriteValue:(NSString*)value intoCharasteric:(CBMutableCharacteristic*) characteristic;
- (void) masterReadValueForCharacteristic:(CBMutableCharacteristic*) characteristic;

/***************************************
 *
 *   peripheral public methods
 *
 **************************************/

- (void) startAdvertisingPeripheral;
- (void) stopAdvertisingPeripheral;
- (BOOL) isConnectedWithAlert:(BOOL)showAlert;

/**
 *  When as a Slave receive a request to read
 *
 *  @param peripheral peripheral
 *  @param request    <#request description#>
 */

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request;

/**
 *  When as a Slave receive a request to write
 *
 *  @param peripheral peripheral
 *  @param request    array of wich request
 */

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests;

@end
