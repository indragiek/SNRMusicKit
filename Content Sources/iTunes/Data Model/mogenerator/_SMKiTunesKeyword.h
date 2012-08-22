// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKiTunesKeyword.h instead.

#import <CoreData/CoreData.h>


extern const struct SMKiTunesKeywordAttributes {
	__unsafe_unretained NSString *name;
} SMKiTunesKeywordAttributes;

extern const struct SMKiTunesKeywordRelationships {
	__unsafe_unretained NSString *objects;
} SMKiTunesKeywordRelationships;

extern const struct SMKiTunesKeywordFetchedProperties {
} SMKiTunesKeywordFetchedProperties;

@class SMKiTunesObject;



@interface SMKiTunesKeywordID : NSManagedObjectID {}
@end

@interface _SMKiTunesKeyword : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SMKiTunesKeywordID*)objectID;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* objects;

- (NSMutableSet*)objectsSet;





@end

@interface _SMKiTunesKeyword (CoreDataGeneratedAccessors)

- (void)addObjects:(NSSet*)value_;
- (void)removeObjects:(NSSet*)value_;
- (void)addObjectsObject:(SMKiTunesObject*)value_;
- (void)removeObjectsObject:(SMKiTunesObject*)value_;

@end

@interface _SMKiTunesKeyword (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveObjects;
- (void)setPrimitiveObjects:(NSMutableSet*)value;


@end
