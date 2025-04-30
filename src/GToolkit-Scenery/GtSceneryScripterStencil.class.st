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
	"It's an example, but we will have to process it.
	Check if it's a Scripter and extract the root element?"

	^ super objectValue elementWithoutParent
]
