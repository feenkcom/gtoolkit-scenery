Class {
	#name : #GtSceneryInScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #examples }
GtSceneryInScripterExamples >> dragNodeEdge [
	<gtExample>
	| aScripter aPoint anExpectedPosition |
	aScripter := self mindmapWithTwoSubnodes.

	aScripter mouseMoveOver
		label: 'Move mouse over target element';
		// (GtSceneryItemId indexed: 1);
		play.
	aScripter mouseDown
		label: 'Mouse down';
		modifiers: BlKeyModifiers ctrl;
		play.
	aPoint := 120 @ 30.
	aScripter mouseMove
		label: ('Move mouse by {1}' format: {aPoint});
		by: aPoint;
		modifiers: BlKeyModifiers ctrl;
		play.
	anExpectedPosition := 402.99451446533203 @ 276.0.
	aScripter assert
		label: 'Assert edge end point position in space';
		satisfies: [ :anElement | 
				| aCenter |
				aCenter := anElement bounds inSpace center.
				aCenter closeTo: anExpectedPosition precision: 0.0001 ]
			description: [ :anElement | 
				'Mouse position element is not in its expected position: {1} ~= {2}'
					format: {anElement bounds inSpace center.
							anExpectedPosition} ];
		// #'scenery--mouse-position';
		play.

	^ aScripter
]

{ #category : #examples }
GtSceneryInScripterExamples >> mindmapWithTwoSubnodes [
	<gtExample>
	^ self
		scripterWithModel: [ GtSceneryExamples new mindmapWithTwoSubnodes ]
		element: [ :aScenery | 
			aScenery asElement
				in: [ :anElement | 
					anElement container
						zoomLevel: 1.5;
						childrenTranslationFactor: 150 ];
				yourself ]
]
