// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SNRiTunesObject.h instead.

#import <CoreData/CoreData.h>


extern const struct SNRiTunesObjectAttributes {
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *name;
} SNRiTunesObjectAttributes;

extern const struct SNRiTunesObjectRelationships {
	__unsafe_unretained NSString *keywords;
} SNRiTunesObjectRelationships;

extern const struct SNRiTunesObjectFetchedProperties {
} SNRiTunesObjectFetchedProperties;

@class SNRiTunesKeyword;




@interface SNRiTunesObjectID : NSManagedObjectID {}
@end

@interface _SNRiTunesObject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SNRiTunesObjectID*)objectID;




@property (nonatomic, strong) NSString* identifier;


//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* keywords;

- (NSMutableSet*)keywordsSet;





@end

@interface _SNRiTunesObject (CoreDataGeneratedAccessors)

- (void)addKeywords:(NSSet*)value_;
- (void)removeKeywords:(NSSet*)value_;
- (void)addKeywordsObject:(SNRiTunesKeyword*)value_;
- (void)removeKeywordsObject:(SNRiTunesKeyword*)value_;

@end

@interface _SNRiTunesObject (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveKeywords;
- (void)setPrimitiveKeywords:(NSMutableSet*)value;


@end
