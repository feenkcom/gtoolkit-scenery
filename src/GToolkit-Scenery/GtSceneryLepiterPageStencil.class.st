Class {
	#name : #GtSceneryLepiterPageStencil,
	#superclass : #GtSceneryDraggableItem,
	#instVars : [
		'databaseName',
		'pageName'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #acccessing }
GtSceneryLepiterPageStencil class >> itemCreationSubmenuLabel [
	^ 'Lepiter page'
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> create [
	| database startPage |
	database := LeDatabasesRegistry default currentLoadedDefaultLogicalDatabase
			databaseNamed: self databaseName.
	startPage := database pageNamed: self pageName.
	^ startPage asPhlowTool
		asElementDo: [ :e | 
			BrVerticalPane new
				addChild: (e
						margin: (BlInsets all: 10);
						background: Color white;
						addAptitude: BrShadowAptitude new);
				size: self defaultExtent ]
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> databaseName [
	^ databaseName ifNil: [databaseName := self defaultDatabaseName]
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> databaseName: aDatabaseName [
	databaseName := aDatabaseName
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> defaultDatabaseName [
	^ LeDatabase gtBookName
]

{ #category : #'as yet unclassified' }
GtSceneryLepiterPageStencil >> defaultExtent [
	^ 400 @ 300
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> defaultPageName [
	^ 'Glamorous Toolkit Book'
]

{ #category : #'as yet unclassified' }
GtSceneryLepiterPageStencil >> initialize [ 
	super initialize.
	extent := self defaultExtent
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> pageName [
	^ pageName ifNil:[ pageName := self defaultPageName ] 
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> pageName: aString [
	pageName := aString
]

{ #category : #'as yet unclassified' }
GtSceneryLepiterPageStencil >> postCopy [
	super postCopy.
	databaseName := self databaseName copy.
	pageName:= self pageName copy
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> storeOn: aStream [
	super storeOn: aStream.
	aStream
		space;
		nextPutAll: 'pageName: ' , self pageName storeString , ';';
		nextPutAll: 'databaseName:' , self databaseName storeString
]
