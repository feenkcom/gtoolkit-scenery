"
I am a Trait for stencils that wrap a Lepiter page.
"
Trait {
	#name : #TGtSceneryLePageWrapper,
	#instVars : [
		'databaseName',
		'pageName'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #required }
TGtSceneryLePageWrapper >> announceStencilUpdate [
	self explicitRequirement
]

{ #category : #accessing }
TGtSceneryLePageWrapper >> databaseName [
	^ databaseName ifNil: [databaseName := self defaultDatabaseName]
]

{ #category : #accessing }
TGtSceneryLePageWrapper >> databaseName: aDatabaseName [
	databaseName := aDatabaseName.
	self announceStencilUpdate
]

{ #category : #accessing }
TGtSceneryLePageWrapper >> defaultDatabaseName [
	^ LeDatabase gtBookName
]

{ #category : #accessing }
TGtSceneryLePageWrapper >> defaultPageName [
	^ 'Glamorous Toolkit Book'
]

{ #category : #accessing }
TGtSceneryLePageWrapper >> pageName [
	^ pageName ifNil:[ pageName := self defaultPageName ] 
]

{ #category : #copying }
TGtSceneryLePageWrapper >> pageName: aString [
	pageName := aString.
	self announceStencilUpdate
]

{ #category : #copying }
TGtSceneryLePageWrapper >> postCopy [
	super postCopy.
	databaseName := self databaseName copy.
	pageName:= self pageName copy
]

{ #category : #copying }
TGtSceneryLePageWrapper >> startPage [
	| database |
	database := LeDatabasesRegistry default currentLoadedDefaultLogicalDatabase
			databaseNamed: self databaseName.
	^ database pageNamed: self pageName
]
