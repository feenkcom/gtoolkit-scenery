"
I am an abstract superclass for stencils of scenery items and connections.

Subclasses should implement `storeOn:` and also `postCopy` so cloning will work correctly.
"
Class {
	#name : #GtSceneryItemStencil,
	#superclass : #BrStencil,
	#traits : 'TGtSceneryShared',
	#classTraits : 'TGtSceneryShared classTrait',
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #'as yet unclassified' }
GtSceneryItemStencil >> handleDoubleClickForItem: anItem andElement: anItemElement inSceneryElement: aSceneryElement [
	"Hook method for subclasses."

	
]

{ #category : #'context menu' }
GtSceneryItemStencil >> updateContextMenuItems: aBrMenuItems forSceneryElement: aGtSceneryElement andChildElement: aChildElement [
	"Hook method for subclasses to provide more specific context menu items. By default do nothing."

	^ aBrMenuItems
]
