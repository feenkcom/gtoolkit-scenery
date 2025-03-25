"
These examples have been created directly editing a Scenery and saving the storeString.
"
Class {
	#name : #GtSceneryEditedExamples,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #'as yet unclassified' }
GtSceneryEditedExamples >> sceneryMindmap [
	"A basic mindmap without any styling of the nodes or edges."

	<gtExample>
	| scenery item1 item2 item3 item4 item5 item6 item7 item8 item9 item10 item11 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryMindMapNodeStencil new text: 'Scenery' asRopedText) asItem.
	item1 position: 126.64542643229174 @ 226.8690083821615.
	item1 extent: 56.858001708984375 @ 28.0.
	item2 := scenery
			addItem: (GtSceneryMindMapNodeStencil new text: 'Items' asRopedText) asItem.
	item2 position: 271.5034281412761 @ 110.8690083821615.
	item2 extent: 42.634002685546875 @ 28.0.
	item3 := scenery
			addItem: (GtSceneryMindMapNodeStencil new text: 'Connections' asRopedText) asItem.
	item3 position: 253.50342814127612 @ 229.8690083821615.
	item3 extent: 83.37400817871094 @ 28.0.
	item4 := scenery
			addItem: (GtSceneryMindMapNodeStencil new text: 'Created with stencils' asRopedText)
					asItem.
	item4 position: 396.137430826823 @ 69.8690083821615.
	item4 extent: 131.00201416015625 @ 28.0.
	item5 := scenery
			addItem: (GtSceneryMindMapNodeStencil new text: 'Connect two items' asRopedText) asItem.
	item5 position: 392.87743631998705 @ 207.8690083821615.
	item5 extent: 119.1300048828125 @ 28.0.
	item6 := scenery
			addItem: (GtSceneryMindMapNodeStencil new text: 'Rendered with stencils' asRopedText)
					asItem.
	item6 position: 393.87743631998705 @ 271.8690083821615.
	item6 extent: 142.0060272216797 @ 28.0.
	item7 := scenery
			addItem: (GtSceneryMindMapNodeStencil new
					text: 'Encapsulate any kind of graph node' asRopedText) asItem.
	item7 position: 395.137430826823 @ 144.8690083821615.
	item7 extent: 218.20803833007813 @ 28.0.
	item8 := scenery
			addItem: (GtSceneryMindMapNodeStencil new text: 'Use  cases' asRopedText) asItem.
	item8 position: 255.50342814127612 @ 371.8690083821615.
	item8 extent: 69.36000061035156 @ 28.0.
	item9 := scenery
			addItem: (GtSceneryMindMapNodeStencil new text: 'Mind maps' asRopedText) asItem.
	item9 position: 394.8634287516277 @ 317.8690083821615.
	item9 extent: 74.14801025390625 @ 28.0.
	item10 := scenery
			addItem: (GtSceneryMindMapNodeStencil new text: 'UML diagrams' asRopedText) asItem.
	item10 position: 393.8634287516277 @ 371.8690083821615.
	item10 extent: 93.18800354003906 @ 28.0.
	item11 := scenery
			addItem: (GtSceneryMindMapNodeStencil new text: 'Lepiter roadmaps' asRopedText) asItem.
	item11 position: 392.8634287516277 @ 428.8690083821615.
	item11 extent: 113.166015625 @ 28.0.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item1
		to: item2.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item1
		to: item3.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item2
		to: item4.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item3
		to: item5.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item3
		to: item6.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item2
		to: item7.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item1
		to: item8.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item8
		to: item9.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item8
		to: item10.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item8
		to: item11.
	
	self assert: scenery items size equals: 11.
	self assert: scenery connections size equals: 10.
	
	^ scenery
]
