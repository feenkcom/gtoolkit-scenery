"
Examples of different kinds of Inspector items
"
Class {
	#name : #GtSceneryInspectorStencilExamples,
	#superclass : #AbstractGtExampleAssertable,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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
