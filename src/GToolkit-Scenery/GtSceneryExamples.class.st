Class {
	#name : #GtSceneryExamples,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #'as yet unclassified' }
GtSceneryExamples >> mindmapWithRootNodeRemoved [
	<gtExample>
	| scenery item1 |
	scenery := self mindmapWithTwoSubnodes.

	item1 := scenery items
			detect: [ :item | item stencil text asString = 'A mindmap' ].
	scenery removeItemWithConnections: item1.

	self assert: scenery items size equals: 2.
	self assert: scenery connections size equals: 0.
	^ scenery
]

{ #category : #'as yet unclassified' }
GtSceneryExamples >> mindmapWithSubnodeRemoved [
	<gtExample>
	| scenery item2 |
	scenery := self mindmapWithTwoSubnodes.

	item2 := scenery items
			detect: [ :item | item stencil text asString = 'A concept A' ].
	scenery removeItemWithConnections: item2.

	self assert: scenery items size equals: 2.
	self assert: scenery connections size equals: 1.
	^ scenery
]

{ #category : #'as yet unclassified' }
GtSceneryExamples >> mindmapWithTwoSubnodes [
	<gtExample>
	| scenery item1 item2 item3 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryMindMapNodeStencil new text: 'A mindmap' asRopedText) asItem.
	item1 position: 0 @ 0.
	item2 := scenery
			addItem: (GtSceneryMindMapNodeStencil new text: 'A concept A' asRopedText) asItem.
	item2 position: 127.0 @ -58.0.
	item3 := scenery
			addItem: (GtSceneryMindMapNodeStencil new text: 'A concept B' asRopedText) asItem.
	item3 position: 126.0 @ 82.0.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item1
		to: item2.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item1
		to: item3.

	self assert: scenery items size equals: 3.
	self assert: scenery connections size equals: 2.
	^ scenery
]

{ #category : #accessing }
GtSceneryExamples >> sceneryWithOneInspector [
	<gtExample>
	| scenery scripter element item |
	scenery := GtScenery new.
	item := scenery addItem: (GtSceneryItem new stencil: (GtSceneryInspectorStencil new
					target: [ 42 ])).
	item position: 500 @ 300.
	scripter := BlScripter new element: scenery asElement.
	element := scripter rootWithoutParent children anyOne.
	self assert: (element isKindOf: GtSceneryElement).
	self assert: element children size equals: 1.
	self assert: element children anyOne children anyOne bounds top equals: 300.
	^ scenery
]

{ #category : #accessing }
GtSceneryExamples >> sceneryWithOneInspectorAndOneRectangle [
	<gtExample>
	| scenery scripter element item2 |
	scenery := self sceneryWithOneInspector.
	item2 := scenery addItem: (GtSceneryItem new stencil: GtSceneryRectangleStencil new).
	scripter := BlScripter new element: scenery asElement.
	element := scripter rootWithoutParent children first children anyOne.
	self assert: element children size = 2.
	^ scenery
]

{ #category : #accessing }
GtSceneryExamples >> sceneryWithOneInspectorAndOneRectangleAndOneConnection [
	<gtExample>
	| scenery scripter element item2 item1 |
	scenery := self sceneryWithOneInspectorAndOneRectangle.
	item1 := scenery items first.
	item2 := scenery items last.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item1
		to: item2.
	scripter := BlScripter new element: scenery asElement.
	element := scripter rootWithoutParent children first children anyOne.
	self assert: element children size equals: 3.
	^ scenery
]

{ #category : #accessing }
GtSceneryExamples >> sceneryWithOneInspectorAndOneRectangleAndOneConnectionStoreOn [
	<gtExample>
	| scenery storeOnString restoredScenery |
	scenery := self sceneryWithOneInspectorAndOneRectangleAndOneConnection.
	storeOnString := String streamContents: [:s | scenery storeOn: s].
	restoredScenery := Smalltalk compiler evaluate: storeOnString.
	self assert: (restoredScenery isKindOf: GtScenery).
	self assert: restoredScenery items size equals: 2.
	self assert: restoredScenery connections size equals: 1.
	^ restoredScenery
]

{ #category : #accessing }
GtSceneryExamples >> sceneryWithOneLepiterPage [
	<gtExample>
	| scenery scripter element item |
	scenery := GtScenery new.
	item := scenery
			addItem: (GtSceneryItem new
					stencil: (GtSceneryLepiterPageStencil new
							databaseName: LeDatabase gtBookName;
							pageName: 'Glamorous Toolkit')).
	item extent: 500 @ 400.
	item position: 0 @ 0.
	scripter := BlScripter new element: scenery asElement.
	element := scripter rootWithoutParent children anyOne.
	self assert: element children first children anyOne bounds top equals: 0.
	^ scenery
]

{ #category : #accessing }
GtSceneryExamples >> sceneryWithTwoLepiterPages [
	<gtExample>
	| scenery scripter element item |
	scenery := self sceneryWithOneLepiterPage.
	item := scenery
			addItem: (GtSceneryItem new
					stencil: (GtSceneryLepiterPageStencil new
							databaseName: LeDatabase gtBookName;
							pageName: 'About this book')).
	item extent: 500 @ 400.
	item position: 600 @ 300.
	scripter := BlScripter new element: scenery asElement.
	element := scripter rootWithoutParent children anyOne.
	self assert: element children first children second bounds top equals: 300.
	^ scenery
]
