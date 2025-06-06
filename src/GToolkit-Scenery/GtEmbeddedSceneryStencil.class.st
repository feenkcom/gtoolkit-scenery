Class {
	#name : #GtEmbeddedSceneryStencil,
	#superclass : #GtSceneryExampleStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #menu }
GtEmbeddedSceneryStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #menu }
GtEmbeddedSceneryStencil class >> itemCreationSubmenuLabel [
	^ 'Scenery'
]

{ #category : #initialization }
GtEmbeddedSceneryStencil >> defaultExampleMethodName [
	^ 'GtEmbeddedSceneryStencil>>#sceneryWithBubble'
]

{ #category : #initialization }
GtEmbeddedSceneryStencil >> defaultViewMethodSelector [
	^ #gtLiveFor:
]

{ #category : #menu }
GtEmbeddedSceneryStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
"We relabel 'Inspect value' to 'Inspect scenery'"
	<todo: 'extend the item menu for the embedded scenery stencil'>
	| menu |
	menu := super menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement.
	menu items first label: 'Inspect scenery'.
	^ menu
]

{ #category : #accessing }
GtEmbeddedSceneryStencil >> objectValue [
	"Set the embedded scenery (model) to not be draggable."

	| scenery |
	scenery := super objectValue.
	self assert: (scenery isKindOf: GtScenery).
	scenery backgroundDraggable: false.
	^ scenery
]

{ #category : #scenery }
GtEmbeddedSceneryStencil >> sceneryWithBubble [
	"NB: Generated by GtScenery>>#storeAsExampleMethod -- do not edit."

	<gtExample>
	<noTest>
	<storedScenery>
	<return: #GtScenery>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addSceneryItem: (GtSceneryMindMapNodeStencil new width: 102.93202209472656) asItem.
	item1 position: 100.62554253472217 @ 95.08513726128473.
	item1 extent: 102.93202209472656 @ 28.0.
	scenery storeStringMethodName: 'GtEmbeddedSceneryStencil>>#sceneryWithBubble'.
	^ scenery
]
