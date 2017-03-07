/*
* This header is generated by classdump-dyld 0.1
* on Thursday, November 28, 2013 at 3:55:57 AM Eastern European Standard Time
* Operating System: Version 7.0.3 (Build 11B511)
* Image Source: /System/Library/PrivateFrameworks/Notes.framework/Notes
* classdump-dyld is free of use, Copyright © 2013 by Elias Limneos.
*/


#import <Notes/Notes-Structs.h>
@class NSManagedObjectModel, NSManagedObjectContext, NSPersistentStoreCoordinator, NSPredicate, NoteStoreObject, NoteAccountObject, CPExclusiveLock, NSNumber, NSString, NSMutableDictionary;

@interface NoteContext : NSObject {

	NSManagedObjectModel* _managedObjectModel;
	NSManagedObjectContext* _managedObjectContext;
	NSPersistentStoreCoordinator* _persistentStoreCoordinator;
	NSPredicate* _searchPredicate;
	NoteStoreObject* _localStore;
	NoteAccountObject* _localAccount;
	CXIndexRef __SharedNoteStoreSearchIndex;
	CPExclusiveLock* __SharedNoteStoreSearchIndexLock;
	int __SharedNoteStoreSearchIndexCount;
	BOOL _isIndexing;
	NSManagedObjectContext* _nextIdContext;
	CPExclusiveLock* _nextIdLock;
	NSNumber* _nextId;
	CPExclusiveLock* _objectCreationLock;
	unsigned _notificationCount;
	BOOL _logChanges;
	BOOL _indexInBatches;
	BOOL _hasPriorityInSaveConflicts;
	BOOL _inMigrator;
	NSString* _testingFilePrefix;
	NSString* _testingFilePath;
	NSMutableDictionary* _notePropertyObjectsRealized;

}

@property (nonatomic,readonly) BOOL isIndexing;                                            //@synthesize isIndexing=_isIndexing - In the implementation block
@property (nonatomic,readonly) NSManagedObjectContext * managedObjectContext; 
+(BOOL)databaseIsCorrupt:(id)arg1 ;
+(BOOL)shouldLogIndexing;
-(void)clearCaches;
-(id)storeOptions;
-(void)setPropertyValue:(id)arg1 forKey:(id)arg2 ;
-(id)rootDirectory;
-(id)propertyValueForKey:(id)arg1 ;
-(void)dealloc;
-(id)init;
-(void)invalidate;
-(id)managedObjectModel;
-(id)managedObjectContext;
-(BOOL)save:(id*)arg1 ;
-(id)storeForObjectID:(id)arg1 ;
-(id)newlyAddedStore;
-(BOOL)deleteStore:(id)arg1 ;
-(id)allVisibleNotesInCollection:(id)arg1 ;
-(id)newlyAddedNote;
-(void)deleteNoteRegardlessOfConstraints:(id)arg1 ;
-(id)notesForIntegerIds:(id)arg1 ;
-(id)allNotesWithoutBodiesInCollection:(id)arg1 ;
-(id)localAccount;
-(BOOL)deleteAccount:(id)arg1 ;
-(id)allAccounts;
-(id)accountForAccountId:(id)arg1 ;
-(id)newlyAddedAccount;
-(void)enableChangeLogging:(BOOL)arg1 ;
-(BOOL)saveOutsideApp:(id*)arg1 ;
-(void)deleteChanges:(id)arg1 ;
-(void)deleteNote:(id)arg1 ;
-(unsigned)countOfNotesInCollection:(id)arg1 ;
-(id)allNotesInCollection:(id)arg1 ;
-(BOOL)forceDeleteAccount:(id)arg1 ;
-(void)_createLocalAccount:(id*)arg1 andStore:(id*)arg2 ;
-(id)urlForPersistentStore;
-(void)setUpUniqueObjects;
-(BOOL)setUpLocalAccountAndStore;
-(BOOL)setUpLastIndexTid;
-(BOOL)saveSilently:(id*)arg1 ;
-(id)pathForPersistentStore;
-(id)pathForIndex;
-(void)removeSqliteAndIdxFiles;
-(void)removeConflictingSqliteAndIdxFiles;
-(void)handleMigration;
-(void)updateSearchIndex:(id)arg1 ;
-(void)trackChanges:(id)arg1 ;
-(id)initWithTestingFilePrefix:(id)arg1 atPath:(id)arg2 inMigrator:(BOOL)arg3 ;
-(id)initWithTestingFilePrefix:(id)arg1 inMigrator:(BOOL)arg2 ;
-(void)setUpCoreDataStack;
-(id)initWithTestingFilePrefix:(id)arg1 ;
-(void)tearDownCoreDataStack;
-(id)newFetchRequestForNotes;
-(id)visibleNotesPredicate;
-(id)nextIndex;
-(id)allVisibleNotesMatchingPredicate:(id)arg1 ;
-(unsigned)countOfVisibleNotesMatchingPredicate:(id)arg1 ;
-(id)allNotesMatchingPredicate:(id)arg1 ;
-(unsigned)countOfNotesMatchingPredicate:(id)arg1 ;
-(id)liveNotesNeedingBodiesPredicate;
-(void)forceSetUpUniqueObjects;
-(id)localStore;
-(unsigned)countOfStores;
-(id)_notePropertyObjectForKey:(id)arg1 ;
-(id)getNextIdObject;
-(id)notesToResumeIndexing;
-(void)saveNotesToResumeIndexing:(id)arg1 ;
-(void)indexNotes:(id)arg1 ;
-(void)destroySearchIndex;
-(BOOL)shouldResumeIndexing;
-(CXIndexRef)searchIndex:(char*)arg1 ;
-(void)cleanUpLocks;
-(id)noteChangeWithType:(int)arg1 store:(id)arg2 ;
-(id)copyNotesForSearch:(void*)arg1 predicate:(id)arg2 complete:(char*)arg3 ;
-(void*)newSearchContextWithText:(id)arg1 ;
-(id)allNotes;
-(id)initForMigrator;
-(id)newFRCForCollection:(id)arg1 delegate:(id)arg2 ;
-(void)sortNotes:(id)arg1 ;
-(id)collectionForObjectID:(id)arg1 ;
-(id)allVisibleNotes;
-(unsigned)countOfVisibleNotes;
-(unsigned)countOfVisibleNotesInCollection:(id)arg1 ;
-(id)visibleNoteForObjectID:(id)arg1 ;
-(id)visibleNotesForIntegerIds:(id)arg1 ;
-(unsigned)countOfNotes;
-(id)noteForObjectID:(id)arg1 ;
-(id)collectionForInfo:(id)arg1 ;
-(id)allStores;
-(id)defaultStoreForNewNote;
-(BOOL)shouldDisableLocalStore;
-(BOOL)hasMultipleEnabledStores;
-(void)setHasPriorityInSaveConflicts:(BOOL)arg1 ;
-(void)wrapUpIndexing;
-(void)resumeIndexing;
-(void)indexInBatches:(BOOL)arg1 ;
-(void)receiveDarwinNotificationWithChangeLogging:(BOOL)arg1 ;
-(void)resetNotificationCount;
-(id)copyNotesForSearch:(void*)arg1 complete:(char*)arg2 ;
-(id)findNotesWithText:(id)arg1 betweenDate:(id)arg2 andDate:(id)arg3 ;
-(BOOL)noteIsSafeToAccess:(id)arg1 ;
-(BOOL)deleteIndexFile;
-(BOOL)isIndexing;
-(id)persistentStoreCoordinator;
-(void).cxx_destruct;
@end

