// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SNRiTunesKeyword.h instead.

#import <CoreData/CoreData.h>


extern const struct SNRiTunesKeywordAttributes {
	__unsafe_unretained NSString *name;
} SNRiTunesKeywordAttributes;

extern const struct SNRiTunesKeywordRelationships {
	__unsafe_unretained NSString *objects;
} SNRiTunesKeywordRelationships;

extern const struct SNRiTunesKeywordFetchedProperties {
} SNRiTunesKeywordFetchedProperties;

@class SNRiTunesObject;



@interface SNRiTunesKeywordID : NSManagedObjectID {}
@end

@interface _SNRiTunesKeyword : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SNRiTunesKeywordID*)objectID;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* objects;

- (NSMutableSet*)objectsSet;





@end

@interface _SNRiTunesKeyword (CoreDataGeneratedAccessors)

- (void)addObjects:(NSSet*)value_;
- (void)removeObjects:(NSSet*)value_;
- (void)addObjectsObject:(SNRiTunesObject*)value_;
- (void)removeObjectsObject:(SNRiTunesObject*)value_;

@end

@interface _SNRiTunesKeyword (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveObjects;
- (void)setPrimitiveObjects:(NSMutableSet*)value;


@end
