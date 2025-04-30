Class {
	#name : #GtSceneryExampleStencil,
	#superclass : #AbstractGtSceneryInspectorStencil,
	#instVars : [
		'exampleMethodName'
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

{ #category : #example }
GtSceneryExampleStencil >> defaultExampleMethod [
	<gtExample>
	^ nil
]

{ #category : #initialization }
GtSceneryExampleStencil >> defaultExampleMethodName [
	^ 'GtSceneryExampleStencil>>#defaultExampleMethod'
]

{ #category : #accessing }
GtSceneryExampleStencil >> exampleMethod [
	^ (MethodByName for: self exampleMethodName) method
]

{ #category : #accessing }
GtSceneryExampleStencil >> exampleMethodName [
	^ exampleMethodName
]

{ #category : #accessing }
GtSceneryExampleStencil >> exampleMethodName: aStringOrMethod [
	| methodByName |
	methodByName := MethodByName for: aStringOrMethod.
	self assert: (methodByName method hasPragmaNamed: #gtExample).
	exampleMethodName := methodByName name.
	self announceStencilUpdate
]

{ #category : #listeners }
GtSceneryExampleStencil >> handleDoubleClickForItemElement: anItemElement inSceneryElement: aSceneryElement [
	anItemElement fireEvent: (GtSceneryObjectToSpawn new object: self objectValue)
]

{ #category : #initialization }
GtSceneryExampleStencil >> initialize [
	super initialize.
	exampleMethodName := self defaultExampleMethodName
]

{ #category : #menu }
GtSceneryExampleStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	<todo: 'extend the item menu for the example stencil'>
	^ super menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement
]

{ #category : #accessing }
GtSceneryExampleStencil >> objectValue [
	^ self exampleMethod gtExample result returnValue
]

{ #category : #storing }
GtSceneryExampleStencil >> storeOnAttributes [
	^ super storeOnAttributes , {#exampleMethodName}
]
