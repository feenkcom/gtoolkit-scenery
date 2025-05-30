"
I am a common asbtract parent for different kinds of inspector stencils.
"
Class {
	#name : #AbstractGtSceneryInspectorStencil,
	#superclass : #NewStyleSceneryItemStencil,
	#instVars : [
		'viewMethodSelector'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
AbstractGtSceneryInspectorStencil >> create [
	^ self elementClass new
		stencil: self;
		yourself
]

{ #category : #accessing }
AbstractGtSceneryInspectorStencil >> defaultExtent [
	^ 300 @ 400
]

{ #category : #initialization }
AbstractGtSceneryInspectorStencil >> defaultViewMethodSelector [
	^ nil
]

{ #category : #'api - instantiation' }
AbstractGtSceneryInspectorStencil >> elementClass [
	^ GtSceneryInspectorElement
]

{ #category : #initialization }
AbstractGtSceneryInspectorStencil >> initialize [
	super initialize.
	viewMethodSelector := self defaultViewMethodSelector
]

{ #category : #comparing }
AbstractGtSceneryInspectorStencil >> isAbstract [
	^ self = AbstractGtSceneryInspectorStencil
]

{ #category : #accessing }
AbstractGtSceneryInspectorStencil >> isSpawned [
	"NB: Only used by GtSceneryInspectorStencil"
]

{ #category : #menu }
AbstractGtSceneryInspectorStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	^ (super
		menuForChildElement: aChildElement
		andSceneryElement: aGtSceneryElement)
		addItemLabel: 'Inspect value'
			action: [ aChildElement fireEvent: (GtSceneryObjectToSpawn new object: self objectValue) ];
		addItemLabel: 'Select view'
			submenu: [ | viewMethods submenu |
				submenu := BrMenuItems new.
				submenu addItemLabel: 'All' action: [ self viewMethodSelector: nil ].
				viewMethods := [ self objectValue class allMethods
						select: [ :m | m hasPragmaNamed: #gtView ] ]
						onErrorDo: [ OrderedCollection new ].
				(viewMethods sortedAs: #selector)
					do: [ :m | submenu addItemLabel: m selector action: [ self viewMethodSelector: m selector ] ].
				submenu ] value;
		yourself
]

{ #category : #accessing }
AbstractGtSceneryInspectorStencil >> objectValue [
	^ self subclassResponsibility
]

{ #category : #accessing }
AbstractGtSceneryInspectorStencil >> setIsSpawnedTrue [
	"NB: Only used by GtSceneryInspectorStencil"
]

{ #category : #storing }
AbstractGtSceneryInspectorStencil >> storeOnAttributes [
	^ {#viewMethodSelector}
]

{ #category : #accessing }
AbstractGtSceneryInspectorStencil >> viewMethodSelector [
	^ viewMethodSelector
]

{ #category : #accessing }
AbstractGtSceneryInspectorStencil >> viewMethodSelector: aSelector [
	viewMethodSelector := aSelector.
	self announceStencilUpdate
]
