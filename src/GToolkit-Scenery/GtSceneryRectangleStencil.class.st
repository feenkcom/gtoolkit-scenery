Class {
	#name : #GtSceneryRectangleStencil,
	#superclass : #GtSceneryDraggableItem,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #'as yet unclassified' }
GtSceneryRectangleStencil class >> itemCreationSubmenuLabel [
	^ 'Rectangle'
]

{ #category : #accessing }
GtSceneryRectangleStencil >> create [
	^ BlElement new
		size: extent;
		background: Color white;
		border: Color black;
		margin: (BlInsets all: 10)
]

{ #category : #accessing }
GtSceneryRectangleStencil >> initialize [
	super initialize.
	extent := 200 @ 300
]
