"
I am deprecated in favor of GtSceneryShapeStencil
"
Class {
	#name : #GtSceneryRectangleStencil,
	#superclass : #OldStyleSceneryItemStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #'as yet unclassified' }
GtSceneryRectangleStencil class >> itemCreationMenuSpecification [
	"<sceneryItemCreationSpecification>"
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #'as yet unclassified' }
GtSceneryRectangleStencil class >> itemCreationSubmenuLabel [
	^ 'Rectangle (old)'
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
