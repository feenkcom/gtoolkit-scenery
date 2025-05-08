Class {
	#name : #GtSceneryScripterStencil,
	#superclass : #GtSceneryExampleStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #menu }
GtSceneryScripterStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #menu }
GtSceneryScripterStencil class >> itemCreationSubmenuLabel [
	^ 'Scripter'
]

{ #category : #initialization }
GtSceneryScripterStencil >> defaultExampleMethodName [
	^ 'GtSceneryInScripterExamples>>#mindmapWithTwoSubnodes'
]

{ #category : #initialization }
GtSceneryScripterStencil >> defaultExtent [
	^ 250 @ 250
]

{ #category : #initialization }
GtSceneryScripterStencil >> defaultViewMethodSelector [
	^ #gtLiveFor:
]

{ #category : #accessing }
GtSceneryScripterStencil >> objectValue [
	"NB: Since the scenery element has already been created, we need to explicitly disable the background dragging."

	| result |
	result := super objectValue.
	self assert: (result isKindOf: BlScripter).
	(result element isKindOf: GtSceneryElement)
		ifTrue: [ result element disableBackgroundDragging ].
	^ result elementWithoutParent
]
