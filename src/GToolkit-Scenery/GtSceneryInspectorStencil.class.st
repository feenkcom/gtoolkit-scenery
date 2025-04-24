Class {
	#name : #GtSceneryInspectorStencil,
	#superclass : #GtSceneryDraggableItemStencil,
	#instVars : [
		'targetBlock',
		'isSpawned'
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
	isSpawned := false.
]

{ #category : #accessing }
GtSceneryInspectorStencil >> isSpawned [
	^ isSpawned
]

{ #category : #'as yet unclassified' }
GtSceneryInspectorStencil >> postCopy [
	super postCopy.
	targetBlock := targetBlock copy
]

{ #category : #accessing }
GtSceneryInspectorStencil >> setIsSpawnedTrue [
	"To be set in GtScenery>>#spawnNewItemFrom:for:
	In this case we may have non-serializable target block."
	isSpawned := true
]

{ #category : #accessing }
GtSceneryInspectorStencil >> storeOn: aStream [
	"If I am a stencil for a spawned object, then the target block is `[ anObject ]`, which must be rewritten.
If the object is seralizable, we generate a new target block. Otherwise we generate a placeholder."

	| target |
	super storeOn: aStream.
	self isSpawned
		ifTrue: [ self targetValue implementsStoreOn
				ifTrue: [ target := '[ ' , self targetValue storeString , ' ]' ]
				ifFalse: [ target := '[ Error signal: ''Could not serialize '
							, self targetValue printString , ''' ]' ] ]
		ifFalse: [ target := targetBlock asString ].
	aStream
		space;
		nextPutAll: 'target: ' , target
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
