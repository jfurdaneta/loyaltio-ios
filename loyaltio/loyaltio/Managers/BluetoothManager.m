//
//  BluetoothManager.m
//  PeripheralModeTest
//
//  Created by Omar on 2/5/16.
//  Copyright © 2016 Oltica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BluetoothManager.h"

#define master false

@implementation BluetoothManager


+ (id)sharedManager
{
    static BluetoothManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] initWithMaster:master];
    });
    return sharedMyManager;
}


- (id) initWithMaster:(BOOL)isMaster
{
    if (self = [super init])
    {
        _blueCharacteriscs = [[BlueToothCharacterist alloc] init];
        
        if (isMaster) {
            _centmanager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
        }
        else {
            _manager = [[CBPeripheralManager alloc]initWithDelegate:self queue:nil];
        }
        
    }
    return self;
}

- (NSDictionary*) getDicAdvertising
{
    
    return @{CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]};
    
//    return @{CBAdvertisementDataLocalNameKey : @"TEST-Manager-X",
//             CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:TRANSFER_DEVICE_UUID]]};

}

#pragma mark - CBCentralManager Delegate  ------------------------------------

/**
 *  When master writes
 *
 *  @param value          value to write
 *  @param characteristic witch characteristic
 */
- (void) masterWriteValue:(NSString*)value intoCharasteric:(CBMutableCharacteristic*) characteristic
{
  
    if (!value || value.length==0) return;
    
    [self.aCperipheral writeValue:[self dataFromString:value] forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
    
}

/**
 *  When master read
 *
 *  @param characteristic witch characteristic
 */

- (void) masterReadValueForCharacteristic:(CBMutableCharacteristic*) characteristic
{
    [self.aCperipheral readValueForCharacteristic:characteristic];

}


/***************************************
 *
 *  When Master change state
 *
 **************************************/

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            [self.centmanager scanForPeripheralsWithServices:nil options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : [NSNumber numberWithBool:YES] }];
            break;
            
        default:
            NSLog(@"%li",(long)central.state);
            break;
    }
}

/***************************************
 *
 *  When Master discover peripheral
 *
 **************************************/

- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)aPeripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    if ([RSSI floatValue]>=-45.f) {
        NSLog(@"Greater than 45 ... %@",RSSI);
        NSLog(@"advertisiment data : %@", advertisementData);
        [central stopScan];
        self.aCperipheral = aPeripheral;
        self.aCperipheral.delegate=self;
        [central connectPeripheral:self.aCperipheral options:nil];
    }
    
}

/***************************************
 *
 *  When Master connect peripheral
 *
 **************************************/

- (void) centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)aPeripheral
{
    NSLog(@"aperi: %@",aPeripheral);
    NSLog(@"Connected:%@",aPeripheral.name);
    NSLog(@"services: %@", aPeripheral.services);
    NSLog(@"NAme: %@",aPeripheral.name);
    
    self.aCperipheral = aPeripheral;
    
    [self.aCperipheral setDelegate:self];
    [self.aCperipheral discoverServices:nil];
}

/***************************************
 *
 *  When Master can not connect peripheral
 *
 **************************************/

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"Failed:%@",error);
}

#pragma mark -CBPeripheralManager Delegate ------------------------------------


/***************************************
 *
 *   Public methods for peripheral
 *
 **************************************/

- (void) startAdvertisingPeripheral
{
    [self.manager startAdvertising:[self getDicAdvertising]];
}

- (void) stopAdvertisingPeripheral
{
    [self.manager stopAdvertising];
}

- (void) slaveReadValueForCharacteristic:(CBMutableCharacteristic*) characteristic
{
    // NO testing
    
    //NSString *mainString = [NSString stringWithFormat:@"bla bla bla"];
   // NSData *mainData1= [mainString dataUsingEncoding:NSUTF8StringEncoding];
    
   // [self.manager updateValue:mainData1 forCharacteristic:characteristicRead onSubscribedCentrals:nil];
    
   // [manager updateValue:[self dataFromString:@"jjj"] forCharacteristic:characteristicWrite onSubscribedCentrals:nil];
}

/***************************************
 *
 *   peripheral create characteristic
 *
 **************************************/

-(void) create
{
    
    CBUUID *sUDID = [CBUUID UUIDWithString:TRANSFER_SERVICE_UUID];
    
    self.servicea = [[CBMutableService alloc]initWithType:sUDID primary:YES];
    
    [self.blueCharacteriscs createCharacterist];
    
    self.servicea.characteristics = [self.blueCharacteriscs getAllCharacterist];
    
    [self.manager addService:self.servicea];
    
}


/***************************************
 *
 *   peripheral update
 *
 **************************************/

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    NSLog(@"Done");
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOn:
        {
            if (!master)  {
                [self create];
            }
            
            break;
        }
        case CBPeripheralManagerStatePoweredOff:
        {
            NSLog(@"bluetooth off");
        }
        case CBPeripheralManagerStateResetting:
        {
            NSLog(@"state reseting");
        }
            case CBPeripheralManagerStateUnauthorized:
        {
            NSLog(@"state unauthorized");
            break;
        }
        case CBPeripheralManagerStateUnknown:
        {

            NSLog(@"state unknow");
            break;
        }
        case CBPeripheralManagerStateUnsupported:
        {
            NSLog(@"state unsupported");

            break;
        }
        default:
        {
            NSLog(@"no conectado --> %li",(long)peripheral.state);

            break;
        }
    }
}

/***************************************
 *
 *   peripheral services
 *
 **************************************/

//CBPeripheralManager

- (void) peripheralManager:(CBPeripheralManager *)peripheral willRestoreState:(NSDictionary<NSString *,id> *)dict
{
    NSLog(@"willRestoreState");
    NSLog(@"dic: %@", dict);
}



- (void) peripheral:(CBPeripheral *)aPeripheral didDiscoverServices:(NSError *)error {
    
    NSLog(@"didDiscoverServices");
    
    for (CBService *aService in aPeripheral.services)
    {
        NSLog(@"services dicover: %@",aService.UUID);
        if ([aService.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_DEVICE_UUID]])
        {
            [aPeripheral discoverCharacteristics:nil forService:aService];
            
            NSLog(@"discover aservices");
        }
    }
}

/***************************************
 *
 *   peripheral characterist
 *
 **************************************/

- (void) peripheral:(CBPeripheral *)aPeripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"diddiscoverCharacterists for service");
    
    for (CBCharacteristic *aChar in service.characteristics)
    {
        NSLog(@"%@",aChar.UUID);
    }
}

/***************************************
 *
 *   peripheral didReadSSI
 *
 **************************************/


-(void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error
{
    NSLog(@"rssi: %@", RSSI);
    NSLog(@"error rsi: %@",error);
}

/***************************************
 *
 *   peripheral didWriteValue
 *
 **************************************/

- (void)peripheral:(CBPeripheral *)aPeripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    //  [centmanager cancelPeripheralConnection:aPeripheral];
    NSLog(@"peripheral didWriteValueForCharasteric");
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
{
    NSLog(@"Added service, start advertising");
    
    [peripheral startAdvertising:[self getDicAdvertising]];
}

/***************************************
 *
 *   peripheral updateValue (master write¿?)
 *
 **************************************/

-(void) peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"didupdatevaluefor");
}

/***************************************
 *
 *   peripheral StartAdvertising
 *
 **************************************/

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
{
    NSLog(@"DidStartAdvertising");
    
}

- (void) peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"didDiscoverIncludedServiceForSErvice");
}


/***************************************
 *
 *   peripheral suscribe
 *
 **************************************/

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic12
{
    //When Master write comes here
    
    NSLog(@"Core:%@",characteristic12.UUID);
    NSLog(@"Connected");
}

- (void) peripheralManager:(CBPeripheralManager *) peripheral central:(nonnull CBCentral *)central didUnsubscribeFromCharacteristic:(nonnull CBCharacteristic *)characteristic
{
    NSLog(@"unsubscribe");
}



/***************************************
 *
 *   peripheral didUpdateNotification
 *
 **************************************/

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    NSLog(@"DidUpdate Notify forStateCharacteristic");
    NSString *strTemp = [[NSString alloc] initWithData:characteristic.value encoding:NSASCIIStringEncoding];
    NSLog(@"strTemp: %@",strTemp);
    
    NSLog(@"NOTIFY");

    [peripheral readValueForCharacteristic:characteristic];
    //  [peripheral readRSSI];
}

/***************************************
 *
 *   peripheral didUpdateNotification
 *
 **************************************/

- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral
{
    
    NSString *stra = @"ENDAL";
    NSData *dataa = [stra dataUsingEncoding:NSUTF8StringEncoding];
   // [peripheral updateValue:dataa forCharacteristic:self.characteristicRead onSubscribedCentrals:nil];
}


/***************************************
 *
 *   peripheral didReceiveReadRequest
 *
 **************************************/


/**
 *  When as a Slave receive a request to read
 *
 *  @param peripheral peripheral
 *  @param request    <#request description#>
 */

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request
{
    //Save las conection
    self.lastConnection = [NSDate new];
    
    [self.blueCharacteriscs processRequest:request isWriteCharacterist:NO withCompletion:^(TypeCharacteristic charact, NSString *nameCharac, NSData *dataToResponse)
    {
        NSLog(@"Charact %lu: (%@ - R) read value ---> %@ ", (unsigned long)charact, nameCharac, [self.blueCharacteriscs getWriteValueFromMaster:dataToResponse]?:@"-");

        if (dataToResponse) {
            request.value = dataToResponse;
        }
        
         [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
    }];
}

/**
 *  When as a Slave receive a request to write
 *
 *  @param peripheral peripheral
 *  @param request    array of wich request
 */

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests
{
    //Save last conection
    self.lastConnection = [NSDate new];
    
    for (CBATTRequest *aReq in requests)
    {
        [self.blueCharacteriscs processRequest:aReq isWriteCharacterist:YES withCompletion:^(TypeCharacteristic charact, NSString *nameCharac, NSData *dataToResponse)
        {
            [peripheral respondToRequest:aReq withResult:CBATTErrorSuccess];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDev object:dataToResponse];
            
        }];
    }
}



#pragma mark Private Methods --------------------------


- (NSData *)dataFromDictionary:(NSDictionary *)dict
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:data];
    [archiver finishEncoding];
    return data;
}

- (NSData *)dataFromString:(NSString *)str
{
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *) stringFromData:(NSData*) data
{
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

#pragma mark - Bluethooth conected

-(BOOL) isConnectedWithAlert:(BOOL)showAlert {
    
    NSDate *now = [NSDate date];
    
    NSTimeInterval secondsBetween = [now timeIntervalSinceDate:self.lastConnection];
    
    if (self.lastConnection && secondsBetween <= kTimeDisconecctInterval) {
        return YES;
    } else {
        if (showAlert)
        {
        if (self.lastConnection) {
            [[[UIAlertView alloc] initWithTitle:@"" message:stringLoc(@"gErrorConnection") delegate:nil cancelButtonTitle:stringLoc(@"gOk") otherButtonTitles:nil, nil]show];
        }else {
            [[[UIAlertView alloc] initWithTitle:@"" message:stringLoc(@"cocNoConnected") delegate:nil cancelButtonTitle:stringLoc(@"gOk") otherButtonTitles:nil, nil]show];
        }
        }
        
        return NO;
    }
    
}

@end
