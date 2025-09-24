"
I am a singleton class that provides a Help database for sceneries.

You can access my in-memory database as follows:
```
GtSceneryHelpDatabase database
```

To load and access the persistent database (NB: slow):
```
GtSceneryHelpDatabase
	cleanUp;
	loadLepiterSceneryHelp;
	database
```

To unload the persistent database and load again the in-memory version:
```
GtSceneryHelpDatabase
	cleanUp;
	unloadLepiterSceneryHelp;
	database
```

"
Class {
	#name : #GtSceneryHelpDatabase,
	#superclass : #LeAbstractInMemoryDatabaseSingleton,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #loading }
GtSceneryHelpDatabase class >> databaseName [
	^ 'feenkcom/gtoolkit-scenery/scenery-help'
]

{ #category : #loading }
GtSceneryHelpDatabase class >> loadLepiterSceneryHelp [
	BaselineOfGToolkitScenery loadLepiterSceneryHelp
]

{ #category : #loading }
GtSceneryHelpDatabase class >> unloadLepiterSceneryHelp [
	"Mainly available for testing and debugging."

	| registry db |
	registry := LeDatabasesRegistry uniqueInstance defaultLogicalDatabase.
	db := registry databaseNamed: self databaseName.
	registry removeDB: db
]

{ #category : #initialization }
GtSceneryHelpDatabase >> initialize [
	self databaseName: self class databaseName.
	self initializeDatabase
]
