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

{ #category : #comparing }
GtSceneryInspectorStencil >> = otherStencil [
	"Need special case to test equality of blocks."
	self == otherStencil ifTrue: [ ^ true ].
	self class = otherStencil class ifFalse: [ ^ false ].
	self viewMethodSelector printString
		= otherStencil viewMethodSelector printString ifFalse: [ ^ false ].
	self target printString = otherStencil target printString ifFalse: [ ^ false ].
	^ true
]

{ #category : #accessing }
GtSceneryInspectorStencil >> create [
	^ self elementClass new
		stencil: self;
		updateAppearance;
		yourself
]

{ #category : #accessing }
GtSceneryInspectorStencil >> defaultTarget [
	^ [nil]
]

{ #category : #accessing }
GtSceneryInspectorStencil >> defaultViewMethodSelector [
	^ nil
]

{ #category : #'api - instantiation' }
GtSceneryInspectorStencil >> elementClass [
	^ GtSceneryInspectorElement
]

{ #category : #comparing }
GtSceneryInspectorStencil >> hash [
	^ targetBlock printString hash bitXor: self viewMethodSelector hash
]

{ #category : #accessing }
GtSceneryInspectorStencil >> initialize [
	super initialize.
	targetBlock := [ nil ].
	extent := 300@400.
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

{ #category : #storing }
GtSceneryInspectorStencil >> storeOnAttributes [
	^ {#target.
		#viewMethodSelector}
]

{ #category : #accessing }
GtSceneryInspectorStencil >> target [
	"NB: the actual stored value is #targetBlock, but we may need to compute a #target depending on the actual target value, if it has been spawned."

	| target |
	self isSpawned
		ifTrue: [ self targetValue implementsStoreOn
				ifTrue: [ target := Smalltalk compiler
							evaluate: '[ ' , self targetValue storeString , ' ]' ]
				ifFalse: [
				
				 target := 
				 Smalltalk compiler
							evaluate:
				 
				 '[ Error signal: ''Could not serialize ' , self targetValue printString , ''' ]' 
							
							
							
							] ]
		ifFalse: [ target := targetBlock ].
	^ target
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
