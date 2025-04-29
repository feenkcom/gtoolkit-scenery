"
I am an abstract superclass for stencil of draggable items (not connections). Each of my subclasses is a stencil for a specific kind of item.
"
Class {
	#name : #GtSceneryDraggableItemStencil,
	#superclass : #GtSceneryEntityStencil,
	#instVars : [
		'extent'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #menu }
GtSceneryDraggableItemStencil class >> itemCreationSubmenuLabel [
	"Label to use for the item creation submenu of GtSceneryElement"
	self subclassResponsibility
]

{ #category : #jsonV4 }
GtSceneryDraggableItemStencil class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: #extent -> #extent;
		yourself
]

{ #category : #converting }
GtSceneryDraggableItemStencil >> asItem [
	^ GtSceneryItem new
		stencil: self;
		extent: self extent;
		yourself
]

{ #category : #accessing }
GtSceneryDraggableItemStencil >> defaultExtent [
	^ 50@50
]

{ #category : #accessing }
GtSceneryDraggableItemStencil >> extent [
	^ extent
]

{ #category : #accessing }
GtSceneryDraggableItemStencil >> extent: aPoint [
	"NB: If the extent is set to nil, then the size will not be changed when the stencil is created.
	See: GtSceneryItem>>#asElementIn:forScenery: "

	extent := aPoint
]

{ #category : #accessing }
GtSceneryDraggableItemStencil >> initialize [ 
	super initialize.
	extent := self defaultExtent
]

{ #category : #connecting }
GtSceneryDraggableItemStencil >> stencilForConnectionWithItemStencil: anItem [
	"Hook to let the stencil decide the connection stencil to use."

	^ GtSceneryStraightArcStencil new
]

{ #category : #printing }
GtSceneryDraggableItemStencil >> storeOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: ' new'
]
