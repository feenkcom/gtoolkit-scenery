"
Some initial mindmap examples — to be expanded.
"
Class {
	#name : #GtSceneryMindmapExamples,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #'as yet unclassified' }
GtSceneryMindmapExamples >> mindmapWithRootNodeRemoved [
	<gtExample>
	<return: #GtScenery>
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
GtSceneryMindmapExamples >> mindmapWithSubnodeRemoved [
	<gtExample>
	<return: #GtScenery>
	| scenery item2 |
	scenery := self mindmapWithTwoSubnodes.

	item2 := scenery items
			detect: [ :item | item stencil text asString = 'A concept A' ].
	scenery removeItemWithConnections: item2.

	self assert: scenery items size equals: 2.
	self assert: scenery connections size equals: 1.
	^ scenery
]

{ #category : #scenery }
GtSceneryMindmapExamples >> mindmapWithTwoSubnodes [
	<gtExample>
	<return: #GtScenery>
	| scenery item1 item2 item3 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryMindMapNodeStencil new
					label: 'A mindmap';
					width: 77.32601928710938) asItem.
	item1 position: 0 @ 0.
	item1 extent: 77.32601928710938 @ 28.0.
	item2 := scenery
			addItem: (GtSceneryMindMapNodeStencil new
					label: 'A concept A';
					width: 77.46598815917969) asItem.
	item2 position: 127.0 @ -58.0.
	item2 extent: 77.46598815917969 @ 28.0.
	item3 := scenery
			addItem: (GtSceneryMindMapNodeStencil new
					label: 'A concept B';
					width: 78.08198547363281) asItem.
	item3 position: 126.0 @ 82.0.
	item3 extent: 78.08198547363281 @ 28.0.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				curvatureFraction: 0)
		from: item1
		to: item2.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				curvatureFraction: 0)
		from: item1
		to: item3.
	self assert: scenery items size equals: 3.
	self assert: scenery connections size equals: 2.
	^ scenery
]
