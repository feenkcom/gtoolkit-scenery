Class {
	#name : #GtSceneryInspectorStencil,
	#superclass : #GtSceneryDraggableItemStencil,
	#instVars : [
		'targetBlock'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #acccessing }
GtSceneryInspectorStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #acccessing }
GtSceneryInspectorStencil class >> itemCreationSubmenuLabel [
	^ 'Inspector'
]

{ #category : #accessing }
GtSceneryInspectorStencil >> create [
	| targetValue view |
	[ targetValue := self targetValue.
	view := self targetValue gtViewsFor: GtPhlowView empty ]
		onErrorDo: [ :error | 
			view := (GtSceneryInspectorOnError new errorValue: error)
					gtViewWithExceptionInStencilFor: GtPhlowView empty ].

	^ view
		asElementDo: [ :e | 
			e
				size: extent;
				background: Color white;
				margin: (BlInsets all: 10);
				addAptitude: BrShadowAptitude ]
]

{ #category : #accessing }
GtSceneryInspectorStencil >> initialize [
	super initialize.
	targetBlock := [ nil ].
	extent := 200@400.
]

{ #category : #'as yet unclassified' }
GtSceneryInspectorStencil >> postCopy [
	super postCopy.
	targetBlock := targetBlock copy
]

{ #category : #accessing }
GtSceneryInspectorStencil >> storeOn: aStream [
	super storeOn: aStream.
	aStream
		space;
		nextPutAll: 'target: ', targetBlock asString
]

{ #category : #copying }
GtSceneryInspectorStencil >> target: aBlock [
	targetBlock := aBlock.
	self announceStencilUpdate
]

{ #category : #accessing }
GtSceneryInspectorStencil >> targetValue [
	^ targetBlock value
]
