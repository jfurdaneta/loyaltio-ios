

#import "CoreDataManager.h"

@implementation CoreDataManager

//-----------------------------
// GENERAL
//-----------------------------

+(NSManagedObjectContext*)getContext{
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    context = [delegate managedObjectContext];
    
    return context;
    
}

+(NSDictionary *)entityToDictionary: (NSManagedObject*)entityObj{
    
    NSArray *keys = [[[entityObj entity] attributesByName] allKeys];
    return [entityObj dictionaryWithValuesForKeys:keys];
    
}

+(BOOL)saveData:(NSDictionary *)dataDictionary onNSManagedObejct:(NSManagedObject *)entityObj{
    
    NSString *className;
    
    for (id key in dataDictionary){
        
        className = NSStringFromClass([key class]);
        id value = [dataDictionary objectForKey:key];
        
        //if ([className containsString:@"String"])
        // {
        
        // }
        
        if([className isEqualToString:@"__NSCFString"] || [className isEqualToString:@"NSTaggedPointerString"] || [className isEqualToString:@"__NSCFConstantString"]){
            [entityObj setValue:value forKey:key];
        }//TODO other kinds
        
    }
    
    return [self saveContext];
    
}

+(BOOL) saveContext
{
    NSError *error = nil;
    
    NSManagedObjectContext *context = [self getContext];
    
    if ([context save:&error] == YES) {
        return TRUE;
    }else{
        //NSLog(@"Saving Failed!, Error and its Desc %@ %@", error, [error localizedDescription]);
        return FALSE;
    }
}
+(NSManagedObject*)createManagedObjectWithEntityName:(NSString*)entityName
{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[self getContext]];
}


+(NSArray*) getFetchRequest:(NSString*) entityName predicate:(NSPredicate*)predicate sortBy:(NSString*) sort ascending:(BOOL) ascendig
{
    NSError *error;
    
    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // with any predicate
    
    if (predicate)
    {
        [fetch setPredicate:predicate];
    }
    
    // if we need the array result sorted by any field
    
    if (sort)
    {
        NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:sort ascending:ascendig];
        
        [fetch setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    }
    
    NSArray *fetchedObjects =[[self getContext] executeFetchRequest:fetch error:&error];
    
    if (error) NSLog(@"error on fetchedObjects: %@",error);
    
    return fetchedObjects;
    
    
}


+(NSManagedObject*) findObjectInEntity:(NSString*) entity withStringPredicate:(NSString*) strPredicate withUnicSearch:(BOOL) isUnique
{
    NSPredicate *predicate;
    
    if (strPredicate)
    {
        predicate = [NSPredicate predicateWithFormat:strPredicate];
    }
   
    NSArray *obj = [self getFetchRequest:entity predicate:predicate sortBy:nil ascending:YES];
    
    if (!obj) return nil;
    
    if ([obj count]==1)
    {
        return [obj firstObject];
    }
    else
    {
        if (isUnique || [obj count]==0)
        {
            // we want unique record
            return nil;
        }
        else
        {
            // i don't care if there are a multiple record, return firstone
            return [obj firstObject];
            
        }
        
    }
}


@end
