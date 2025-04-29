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

{ #category : #initialization }
GtSceneryExampleStencil >> defaultExampleMethodName [
	^ nil
]

{ #category : #accessing }
GtSceneryExampleStencil >> exampleMethod [
	^ MethodByName for: self exampleMethodName
]

{ #category : #accessing }
GtSceneryExampleStencil >> exampleMethodName [
	^ exampleMethodName
]

{ #category : #accessing }
GtSceneryExampleStencil >> exampleMethodName: aStringOrMethod [
	aStringOrMethod isString
		ifTrue: [ exampleMethodName := aStringOrMethod ]
		ifFalse: [ aStringOrMethod isCompiledMethod
				ifTrue: [ exampleMethodName := aStringOrMethod printString ]
				ifFalse: [ ^ self ] ].
	self announceStencilUpdate
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
	^ self exampleMethod methodClass new perform: self exampleMethod selector
]

{ #category : #storing }
GtSceneryExampleStencil >> storeOnAttributes [
	^ super storeOnAttributes , {#exampleMethodName}
]
