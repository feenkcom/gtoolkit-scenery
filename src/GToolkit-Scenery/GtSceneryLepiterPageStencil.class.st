Class {
	#name : #GtSceneryLepiterPageStencil,
	#superclass : #OldStyleSceneryItemStencil,
	#traits : 'TGtSceneryLePageWrapper',
	#classTraits : 'TGtSceneryLePageWrapper classTrait',
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #menu }
GtSceneryLepiterPageStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #menu }
GtSceneryLepiterPageStencil class >> itemCreationSubmenuLabel [
	^ 'Lepiter page'
]

{ #category : #required }
GtSceneryLepiterPageStencil >> announceStencilUpdate [
	"Actually we inherit this, but we make the trait happy by duplicating the code."

	self announce: (GtStencilUpdated new stencil: self)
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
	^ 500 @ 400
]

{ #category : #listeners }
GtSceneryLepiterPageStencil >> handleDoubleClickForItemElement: anItemElement inSceneryElement: aSceneryElement [
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
