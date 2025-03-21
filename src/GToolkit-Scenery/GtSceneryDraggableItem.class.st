"
I am an abstract superclass for stencil of draggable items (not connections). Each of my subclasses is a stencil for a specific kind of item.
"
Class {
	#name : #GtSceneryDraggableItem,
	#superclass : #GtSceneryItemStencil,
	#instVars : [
		'extent'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #acccessing }
GtSceneryDraggableItem class >> itemCreationSubmenuLabel [
	"Label to use for the item creation submenu of GtSceneryElement"
	self subclassResponsibility
]

{ #category : #converting }
GtSceneryDraggableItem >> asItem [
	^ GtSceneryItem new
		stencil: self;
		extent: self extent;
		yourself
]

{ #category : #accessing }
GtSceneryDraggableItem >> extent [
	^ extent
]

{ #category : #accessing }
GtSceneryDraggableItem >> extent: aPoint [
	"NB: If the extent is set to nil, then the size will  not be changed when the stencil is created.
	See: GtSceneryItem>>#asElementIn:forScenery:
	"
	extent := aPoint
]

{ #category : #accessing }
GtSceneryDraggableItem >> initialize [ 
	super initialize.
	extent := 50 @ 50
]

{ #category : #printing }
GtSceneryDraggableItem >> storeOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: ' new'
]
