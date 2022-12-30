Class {
	#name : #GtSceneryExamples,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #accessing }
GtSceneryExamples >> sceneryElementWithOneInspector [
	<gtExample>
	| scenery scripter element |
	scenery := GtScenery new
			addSceneryItem: (GtInspectorSceneryStencil new
					target: [ 42 ];
					position: 500 @ 300).
	scripter := BlScripter new element: scenery asElement.
	element := scripter rootWithoutParent children anyOne.
	self assert: element children size = 1.
	self assert: element children anyOne bounds top = 300.
	^ element
]
