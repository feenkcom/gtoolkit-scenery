Class {
	#name : #GtSceneryExampleStencil,
	#superclass : #GtSceneryInspectorStencil,
	#instVars : [
		'exampleMethod'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #menu }
GtSceneryExampleStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #menu }
GtSceneryExampleStencil class >> itemCreationSubmenuLabel [
	^ 'Example'
]

{ #category : #initialization }
GtSceneryExampleStencil >> defaultExampleMethod [
	^ nil
]

{ #category : #accessing }
GtSceneryExampleStencil >> exampleMethod [
	^ exampleMethod
]

{ #category : #accessing }
GtSceneryExampleStencil >> exampleMethod: anExampleMethod [
	exampleMethod := anExampleMethod.
	targetBlock := [ anExampleMethod methodClass new
			perform: anExampleMethod selector ].
	self announceStencilUpdate
]

{ #category : #initialization }
GtSceneryExampleStencil >> initialize [
	super initialize.
	exampleMethod := self defaultExampleMethod
]

{ #category : #menu }
GtSceneryExampleStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	<todo: 'extend the item menu for the example stencil'>
	^ super menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement
]

{ #category : #storing }
GtSceneryExampleStencil >> storeOnAttributes [
	^ {#exampleMethod.
		#viewMethodSelector}
]
