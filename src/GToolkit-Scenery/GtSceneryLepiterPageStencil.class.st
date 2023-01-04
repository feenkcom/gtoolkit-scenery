Class {
	#name : #GtSceneryLepiterPageStencil,
	#superclass : #GtLiveSlide,
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
	^ startPage asPhlowTool asElementDo: [ :e | e ]
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> databaseName: anObject [
	databaseName := anObject
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> pageName: aString [
	pageName := aString
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> storeOn: aStream [
	super storeOn: aStream.
	aStream
		nextPutAll: 'pageName: ' , pageName , ';';
		nextPutAll: 'databaseName:' , databaseName
]
