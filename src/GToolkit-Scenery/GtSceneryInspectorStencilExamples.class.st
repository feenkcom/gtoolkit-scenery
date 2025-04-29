"
Examples of different kinds of Inspector items
"
Class {
	#name : #GtSceneryInspectorStencilExamples,
	#superclass : #AbstractGtExampleAssertable,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #example }
GtSceneryInspectorStencilExamples >> errorScenery [
	"A scenery with an inspector on an error."

	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryInspectorStencil new target: [ 1 / 0 ]) asItem.
	self should: [ item1 stencil targetValue ] raise: ZeroDivide.
	^ scenery
]

{ #category : #example }
GtSceneryInspectorStencilExamples >> ludoGameScenery [
	"A scenery with a plain inspector of an object."

	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryInspectorStencil new
					target: [ GtLudoRecordingGame new
							roll: 6;
							moveTokenNamed: 'A';
							roll: 2;
							moveTokenNamed: 'A';
							roll: 6;
							moveTokenNamed: 'b';
							roll: 6;
							moveTokenNamed: 'B';
							roll: 4;
							moveTokenNamed: 'B';
							yourself ]) asItem.
	self assert: (item1 stencil targetValue isKindOf: GtLudoRecordingGame).
	^ scenery
]

{ #category : #example }
GtSceneryInspectorStencilExamples >> ludoGameSceneryBoardView [
	<gtExample>
	| scenery ludoItem |
	scenery := self ludoGameScenery.
	ludoItem := scenery items first.
	ludoItem stencil viewMethodSelector: #gtPositionsFor:.
	ludoItem extent: 617.0312500000001 @ 654.5247395833334.
	self assert: ludoItem stencil viewMethodSelector equals: #gtPositionsFor:.
	^ scenery
]

{ #category : #example }
GtSceneryInspectorStencilExamples >> memoryExampleScenery [
	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryExampleStencil new
					viewMethodSelector: #gtLiveFor:;
					exampleMethodName: 'GtMemoryGameExamples>>#afterSomeMoves') asItem.
	item1 position: -29.446614583333258 @ 180.99833170572919.
	item1 extent: 351.9303385416665 @ 352.1028645833334.
	self assert: item1 stencil viewMethodSelector equals: #gtLiveFor:.
	^ scenery
]
