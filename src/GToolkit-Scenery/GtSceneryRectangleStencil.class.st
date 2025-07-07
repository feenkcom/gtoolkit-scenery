"
I am deprecated in favor of GtSceneryShapeStencil
"
Class {
	#name : #GtSceneryRectangleStencil,
	#superclass : #OldStyleSceneryItemStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #menu }
GtSceneryRectangleStencil class >> itemCreationMenuSpecification [
	"<sceneryItemCreationSpecification>"
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #menu }
GtSceneryRectangleStencil class >> itemCreationSubmenuLabel [
	^ 'Rectangle (old)'
]

{ #category : #accessing }
GtSceneryRectangleStencil >> create [
	^ BlElement new
		background: Color white;
		border: Color black;
		margin: (BlInsets all: 10)
]
