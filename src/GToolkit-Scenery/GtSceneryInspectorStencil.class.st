Class {
	#name : #GtSceneryInspectorStencil,
	#superclass : #NewStyleSceneryItemStencil,
	#instVars : [
		'targetBlock',
		'isSpawned',
		'viewMethodSelector'
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
	^ self elementClass new
		stencil: self;
		updateAppearance;
		yourself
]

{ #category : #accessing }
GtSceneryInspectorStencil >> defaultViewMethodSelector [
	^ nil
]

{ #category : #'api - instantiation' }
GtSceneryInspectorStencil >> elementClass [
	^ GtSceneryInspectorElement

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
	"See #setIsSpawnedTrue"
	^ isSpawned
]

{ #category : #menu }
GtSceneryInspectorStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	| submenu |
	^ BrMenuItems new
		addItemLabel: 'Inspect value'
			action: [ aChildElement fireEvent: (GtSceneryObjectToSpawn new object: self targetValue) ];
		addItemLabel: 'Select view'
			submenu: [ | viewMethods |
				submenu := BrMenuItems new.
				submenu addItemLabel: 'All' action: [ self viewMethodSelector: nil ].
				viewMethods := self targetValue class allMethods
						select: [ :m | m hasPragmaNamed: #gtView ].
				viewMethods
					do: [ :m | submenu addItemLabel: m selector action: [ self viewMethodSelector: m selector ] ].
				submenu ] value;
		yourself
]

{ #category : #copying }
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

	<todo: 'FIX THIS to use the new scheme. Add the viewMethod attribute. Update the target attribute before saving.'>

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

{ #category : #accessing }
GtSceneryInspectorStencil >> viewMethodSelector [
	^ viewMethodSelector
]

{ #category : #accessing }
GtSceneryInspectorStencil >> viewMethodSelector: aSelector [
	viewMethodSelector := aSelector.
	self announceStencilUpdate
]
