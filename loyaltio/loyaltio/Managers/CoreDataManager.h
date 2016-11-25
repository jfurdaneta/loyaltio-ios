// CoreDataManager.h


@interface CoreDataManager : NSObject


//********************************************
/**
 *  Get current context
 *  NSManagedObjectContext that we need to work
 *
 *  @return the context
 */

+(NSManagedObjectContext*)getContext;


//********************************************
/**
 *  Convert one entity into a Dictionary
 *
 *  @param entityObj entity to convert into dictionary
 *
 *  @return the dictionary
 */

+(NSDictionary *)entityToDictionary: (NSManagedObject*)entityObj;


//********************************************
/**
 *  Save one dictionary into a Object
 *
 *  @param dataDictionary dictionary of values to put into the Record, the keys needs the same names of properties
 *  @param entityObj      record
 *
 *  @return if saved correctly
 */
+(BOOL)saveData:(NSDictionary *)dataDictionary onNSManagedObejct:(NSManagedObject *)entityObj;


//********************************************
/**
 *  Save all CoreData
 *
 *  @return if saved correctly
 */
+(BOOL) saveContext;


//********************************************
/**
 *  Create Object for entity
 *
 *  @param entityName name of entity
 *
 *  @return the object
 */
+(NSManagedObject*)createManagedObjectWithEntityName:(NSString*)entityName;


//********************************************
/**
 *  Get objects optional predicate and sort
 *
 *  @param entityName entity name
 *  @param predicate  if needs any predicate like 'isoCountry == ES'
 *  @param sort       field to sort
 *  @param ascendig   YES: if is ascendig
 *
 *  @return array of objects found
 */
+(NSArray*) getFetchRequest:(NSString*) entityName predicate:(NSPredicate*)predicate sortBy:(NSString*) sort ascending:(BOOL) ascendig;


//********************************************
/**
 *  Find one object with predicate, and check if have a multiple copy return nil
 *
 *  @param entity       entity name
 *  @param strPredicate string of predicate. Example 'isoCountry == ES'
 *  @param isUnique     YES: to return a nil value of multiple records
 *
 *  @return direct NSManagedObject, they need to cast into a real object
 */
+(NSManagedObject*) findObjectInEntity:(NSString*) entity withStringPredicate:(NSString*) strPredicate withUnicSearch:(BOOL) isUnique;


@end
