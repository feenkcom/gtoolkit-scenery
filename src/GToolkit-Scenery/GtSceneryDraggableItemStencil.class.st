"
I am an abstract superclass for stencil of draggable items (not connections). Each of my subclasses is a stencil for a specific kind of item.
"
Class {
	#name : #GtSceneryDraggableItemStencil,
	#superclass : #GtSceneryEntityStencil,
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
		yourself
]

{ #category : #converting }
GtSceneryDraggableItemStencil >> asItem [
	^ GtSceneryItem new
		stencil: self;
		extent: self defaultExtent;
		yourself
]

{ #category : #initialization }
GtSceneryDraggableItemStencil >> defaultExtent [
	^ 50@50
]

{ #category : #accessing }
GtSceneryDraggableItemStencil >> extent [
	"A stencil does not need a mutable extent, but only a default extent."

	self
		deprecated: 'Use defaultExtent instead'
		transformWith: '`@receiver extent' -> '`@receiver defaultExtent'.
	^ self defaultExtent
]

{ #category : #accessing }
GtSceneryDraggableItemStencil >> neededHeight [
	^ self defaultExtent y
]

{ #category : #connecting }
GtSceneryDraggableItemStencil >> stencilForConnectionWith: anItem labeled: aText [
	"Hook to let the stencil decide the connection stencil to use."

	^ GtSceneryStraightArcStencil new
		labelText: aText;
		yourself
]

{ #category : #printing }
GtSceneryDraggableItemStencil >> storeOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: ' new'
]
