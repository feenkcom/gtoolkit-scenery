Class {
	#name : #GtSceneryLepiterPageStencil,
	#superclass : #GtSceneryDraggableItemStencil,
	#traits : 'TGtSceneryLePageWrapper',
	#classTraits : 'TGtSceneryLePageWrapper classTrait',
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #acccessing }
GtSceneryLepiterPageStencil class >> itemCreationSubmenuLabel [
	^ 'Lepiter page'
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> create [
	^ self startPage asPhlowTool
		asElementDo: [ :e | 
			BrVerticalPane new
				addChild: (e
						margin: (BlInsets all: 10);
						background: Color white;
						addAptitude: BrShadowAptitude new);
				size: self defaultExtent ]
]

{ #category : #'as yet unclassified' }
GtSceneryLepiterPageStencil >> defaultExtent [
	^ 400 @ 300
]

{ #category : #listeners }
GtSceneryLepiterPageStencil >> handleDoubleClickForItem: anItem andElement: anItemElement inSceneryElement: aSceneryElement [
	"Spawn the page"

	anItemElement
		fireEvent: (GtSceneryObjectToSpawn new object: self startPage asPagePhlowTool)
]

{ #category : #initialization }
GtSceneryLepiterPageStencil >> initialize [ 
	super initialize.
	extent := self defaultExtent
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> storeOn: aStream [
	super storeOn: aStream.
	aStream
		space;
		nextPutAll: 'pageName: ' , self pageName storeString , ';';
		nextPutAll: 'databaseName:' , self databaseName storeString
]
