//
//  BlueToothCharacterist.m
//  PeripheralModeTest
//
//  Created by Omar on 2/5/16.
//  Copyright © 2016 Oltica. All rights reserved.
//

#import "BlueToothCharacterist.h"

@implementation BlueToothCharacterist

- (void) createCharacterist
{
    /*
     * Write characterist
     */
    
    self.chWriteCommand = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:kUUIDwriteCommand] properties:CBCharacteristicPropertyWrite value:nil permissions:CBAttributePermissionsWriteable];
    
    
    /*
     * Read characterist
     */
    
    
    self.chReadValues = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:kUUIDreadValues] properties:CBCharacteristicPropertyRead|CBCharacteristicPropertyIndicate value:nil permissions:CBAttributePermissionsReadable];


}

- (NSArray*) getAllCharacterist
{
    return @[self.chWriteCommand,
             self.chReadValues];
}

- (NSString*) getNameStrService:(TypeCharacteristic) charac
{
    NSArray *arr = @[@"Unknow",
                     @"Command",
                     @"Status User",
                     @"Status Led",
                     @"Alarm",
                     @"Heart Settings",
                     @"Watter Settings",
                     @"Time Remainding",
                     @"Battery",
                     @"Heart Temperature",
                     @"Water Temperature",
                     @"Read Water",
                     @"Read Heart",
                     @"Read Cook Time", @"a",@"b",@"c",@"d"];
    return arr[charac];
}

- (TypeCharacteristic) getTypeCharacterist:(CBATTRequest*) request
{
    TypeCharacteristic characterist = TypeUnknown;
    
    if ([request.characteristic.UUID isEqual:[CBUUID UUIDWithString:kUUIDwriteCommand]]) {
        characterist = TypeCommand;
    }
    else     if ([request.characteristic.UUID isEqual:[CBUUID UUIDWithString:kUUIDreadValues]]) {
        characterist = TypeReadValues;
    }

    
    return characterist;
}


/**
 *  process read / write value
 *
 *  @param request    objectPlaca
 *  @param isWrite    to know if there is a write mode or no
 *  @param completion return the manage data
 */

- (void) processRequest:(CBATTRequest*) request isWriteCharacterist:(BOOL) isWrite withCompletion:(void(^)(TypeCharacteristic charact, NSString *nameCharac, NSData *dataToResponse)) completion
{
    TypeCharacteristic characterist = [self getTypeCharacterist:request];
    NSCookPlaca *objPlaca = [NSCookPlaca sharedManager];
    
    NSData *valueToResponse = request.value;
    
    NSString *writeValue;
    if (isWrite)
    {
        writeValue = [self getWriteValueFromMaster:request.value];
        [objPlaca parseFullInfoFromPlaca:valueToResponse];
    }
    else
    {
        // is Read all values
        valueToResponse = [self readAllValuesToSendNSData];
    }
    
    
    if (valueToResponse) {
       // NSLog(@"value Response: %@", valueToResponse);
    }

     completion(characterist, isWrite?@"w":@"r", valueToResponse?:nil);
}

- (NSData*) readAllValuesToSendNSData
{
    
    /*
     [0] = Temperatura agua
     [1] = Temperatura core
     [2], [3] = Tiempo
     [4] = si esta conectado
     */
    
    
    NSMutableData *data = [NSMutableData new];
    
    NSCookPlaca *obj = [NSCookPlaca sharedManager];
    
    [data appendData:[self intToByteToNSData:obj.actualLiquid]];
    [data appendData:[self intToByteToNSData:obj.actualTempHeart]];
    if (obj.actualTime <= 256) {
        [data appendData:[self intToByteToNSData:0]];
    }
    [data appendData:[self intToByteToNSData:obj.actualTime]];
    [data appendData:[self intToByteToNSData:obj.conectivity?1:0]];

    return data;
}


- (NSData*) intToByteToNSData:(long) number
{
    int tBytes = 1;
    
    if (number > 256) tBytes = 2;
    unsigned char bytes[tBytes];
    unsigned long n = number;
    
    if (tBytes == 2) {
        bytes[0] = (n >> 8) & 0xFF;
        bytes[1] = n & 0xFF;
    }
    else {
        bytes[0] = n & 0xFF;
    }

    
    return [NSData dataWithBytes:bytes length:tBytes];
}

// sin validar
+ (NSData *)dataFromHexString:(NSString *)string
{
    string = [string lowercaseString];
    NSMutableData *data= [NSMutableData new];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i = 0;
    long length = string.length;
    while (i < length-1) {
        char c = [string characterAtIndex:i++];
        if (c < '0' || (c > '9' && c < 'a') || c > 'f')
            continue;
        byte_chars[0] = c;
        byte_chars[1] = [string characterAtIndex:i++];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return data;
}
// ----

/**
 *  Transfor the nsdata that write placa into a string
 *
 *  @param value binary
 *
 *  @return return string
 */

- (NSString*) getWriteValueFromMaster:(NSData*) value
{
    NSData *data = value;
    
    
    uint8_t byte;
    [data getBytes:&byte length:1];
   
    NSString *stringData = [data description];
    stringData = [stringData substringWithRange:NSMakeRange(1, [stringData length]-2)];
    
   
    unsigned dataAsInt = 0;
    int dataAsInteger = 0;
    NSScanner *scanner = [NSScanner scannerWithString: stringData];
    
    [scanner scanHexInt:& dataAsInt];
    [scanner scanInt:&dataAsInteger];
    
    return [NSString stringWithFormat:@"%u", dataAsInt];
    
}



@end
