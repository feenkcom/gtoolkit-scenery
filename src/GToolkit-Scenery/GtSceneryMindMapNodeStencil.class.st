"
I am a kind of `GtSceneryTextLabelStencil`, but I am intended to be used as a node within a Mind map.
I should support a choice of colors and backgrounds, and possibly links to other kinds of related objects inside or outside of GT.

"
Class {
	#name : #GtSceneryMindMapNodeStencil,
	#superclass : #GtSceneryTextLabelStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #acccessing }
GtSceneryMindMapNodeStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #acccessing }
GtSceneryMindMapNodeStencil class >> itemCreationSubmenuLabel [
	^ 'Mind map bubble'
]

{ #category : #'as yet unclassified' }
GtSceneryMindMapNodeStencil class >> leJsonV4Name [
	"The name (symbol) for this type of stencil in the JSON representation."
	^ #sceneryMindMapNodeStencil
]

{ #category : #'api - instantiation' }
GtSceneryMindMapNodeStencil >> elementClass [
	^ GtSceneryMindMapNodeElement
]
