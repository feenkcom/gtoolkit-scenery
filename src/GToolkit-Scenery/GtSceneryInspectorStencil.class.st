"
I am an Inspector stencil for an object return by an arbitrary kind of code snippet defined as my `targetBlock`.
```
GtSceneryInspectorStencil new target: [ 3 + 4 ]
```
"
Class {
	#name : #GtSceneryInspectorStencil,
	#superclass : #AbstractGtSceneryInspectorStencil,
	#instVars : [
		'targetBlock',
		'isSpawned'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #menu }
GtSceneryInspectorStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #menu }
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
GtSceneryInspectorStencil >> defaultTarget [
	^ [nil]
]

{ #category : #comparing }
GtSceneryInspectorStencil >> hash [
	^ targetBlock printString hash bitXor: self viewMethodSelector hash
]

{ #category : #initialization }
GtSceneryInspectorStencil >> initialize [
	super initialize.
	targetBlock := [ nil ].
	isSpawned := false.
]

{ #category : #accessing }
GtSceneryInspectorStencil >> isSpawned [
	"See #setIsSpawnedTrue"
	^ isSpawned
]

{ #category : #accessing }
GtSceneryInspectorStencil >> objectValue [
	^ self targetValue
]

{ #category : #copying }
GtSceneryInspectorStencil >> postCopy [
	super postCopy.
	targetBlock := targetBlock copy.
]

{ #category : #accessing }
GtSceneryInspectorStencil >> setIsSpawnedTrue [
	"To be set in GtScenery>>#spawnNewItemFrom:for:
	In this case we may have non-serializable target block."
	isSpawned := true
]

{ #category : #storing }
GtSceneryInspectorStencil >> storeOnAttributes [
	^ super storeOnAttributes , {#target}
]

{ #category : #accessing }
GtSceneryInspectorStencil >> target [
	"NB: the actual stored value is #targetBlock, but we may need to compute a #target depending on the actual target value, if it has been spawned."

	| target |
	self isSpawned
		ifTrue: [ self targetValue implementsStoreOn
				ifTrue: [ target := Smalltalk compiler
							evaluate: '[ ' , self targetValue storeString , ' ]' ]
				ifFalse: [ target := Smalltalk compiler
							evaluate: '[ Error signal: ''Could not serialize ' , self targetValue printString , ''' ]' ] ]
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
