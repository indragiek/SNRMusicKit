// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKiTunesObject.h instead.

#import <CoreData/CoreData.h>


extern const struct SMKiTunesObjectAttributes {
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *name;
} SMKiTunesObjectAttributes;

extern const struct SMKiTunesObjectRelationships {
	__unsafe_unretained NSString *keywords;
} SMKiTunesObjectRelationships;

extern const struct SMKiTunesObjectFetchedProperties {
} SMKiTunesObjectFetchedProperties;

@class SMKiTunesKeyword;




@interface SMKiTunesObjectID : NSManagedObjectID {}
@end

@interface _SMKiTunesObject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SMKiTunesObjectID*)objectID;




@property (nonatomic, strong) NSString* identifier;


//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* keywords;

- (NSMutableSet*)keywordsSet;





@end

@interface _SMKiTunesObject (CoreDataGeneratedAccessors)

- (void)addKeywords:(NSSet*)value_;
- (void)removeKeywords:(NSSet*)value_;
- (void)addKeywordsObject:(SMKiTunesKeyword*)value_;
- (void)removeKeywordsObject:(SMKiTunesKeyword*)value_;

@end

@interface _SMKiTunesObject (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveKeywords;
- (void)setPrimitiveKeywords:(NSMutableSet*)value;


@end
