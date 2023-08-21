Class {
	#name : #GtSceneryLepiterPageStencil,
	#superclass : #GtSceneryDraggableItem,
	#instVars : [
		'databaseName',
		'pageName'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryLepiterPageStencil >> create [
	| database startPage |
	database := LeDatabasesRegistry default currentLoadedDefaultLogicalDatabase
			databaseNamed: databaseName.
	startPage := database pageNamed: pageName.
	^ startPage asPhlowTool
		asElementDo: [ :e | 
			BrVerticalPane new
				addChild: (e
						margin: (BlInsets all: 10);
						background: Color white;
						addAptitude: BrShadowAptitude new);
				size: 500@200 ]
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> databaseName: anObject [
	databaseName := anObject
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> initialize [ 
	super initialize
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> pageName: aString [
	pageName := aString
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> storeOn: aStream [
	super storeOn: aStream.
	aStream
		space;
		nextPutAll: 'pageName: ' , pageName storeString , ';';
		nextPutAll: 'databaseName:' , databaseName storeString
]
