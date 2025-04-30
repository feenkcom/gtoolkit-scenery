Class {
	#name : #GtEmbeddedSceneryStencil,
	#superclass : #GtSceneryExampleStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #menu }
GtEmbeddedSceneryStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #menu }
GtEmbeddedSceneryStencil class >> itemCreationSubmenuLabel [
	^ 'Scenery'
]

{ #category : #accessing }
GtEmbeddedSceneryStencil >> exampleMethodName: aStringOrMethod [
	super exampleMethodName: aStringOrMethod
]

{ #category : #menu }
GtEmbeddedSceneryStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	<todo: 'extend the item menu for the embedded scenery stencil'>
	^ super menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement
]
