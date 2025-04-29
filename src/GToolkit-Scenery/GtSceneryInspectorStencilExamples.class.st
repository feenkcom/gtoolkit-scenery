"
Examples of different kinds of Inspector items
"
Class {
	#name : #GtSceneryInspectorStencilExamples,
	#superclass : #AbstractGtExampleAssertable,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #example }
GtSceneryInspectorStencilExamples >> embeddedSceneryExampleScenery [
	<gtExample>
	| scenery item1 item2 item3 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryExampleStencil new
					viewMethodSelector: #gtLiveFor:;
					exampleMethodName: 'GtSceneryEditedExamples>>#sceneryMindmap') asItem.
	item1 position: -277.0 @ -23.0.
	item1 extent: 357.16796875 @ 354.51822916666674.
	item2 := scenery
			addItem: (GtSceneryExampleStencil new
					viewMethodSelector: #gtLiveFor:;
					exampleMethodName: 'GtSceneryEditedExamples>>#simpleClassDiagram') asItem.
	item2 position: 196.71354166666663 @ -54.59914143880212.
	item2 extent: 362.12890625 @ 348.57096354166674.
	item3 := scenery
			addItem: (GtSceneryTextLabelStencil new
					label: 'A Scenery with two embedded sceneries as examples.';
					width: 183.29335021972656) asItem.
	item3 position: 29.16536458333246 @ -161.4962768554688.
	item3 extent: 183.29335021972656 @ 73.0.
	^ scenery
]

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
