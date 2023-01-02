Class {
	#name : #GtSceneryExamples,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #accessing }
GtSceneryExamples >> sceneryWithOneInspector [
	<gtExample>
	| scenery scripter element item |
	scenery := GtScenery new.
	item := scenery addItem: (GtInspectorSceneryStencil new
					target: [ 42 ]).
	item position: 500 @ 300.
	scripter := BlScripter new element: scenery asElement.
	element := scripter rootWithoutParent children anyOne.
	self assert: (element isKindOf: BlCanvassableElement).
	self assert: element children size = 1.
	self assert: element children anyOne bounds top = 300.
	^ scenery
]

{ #category : #accessing }
GtSceneryExamples >> sceneryWithOneInspectorAndOneRectangle [
	<gtExample>
	| scenery scripter element item2 |
	scenery := self sceneryWithOneInspector.
	item2 := scenery addItem: GtRectangleSceneryStencil new.
	scripter := BlScripter new element: scenery asElement.
	element := scripter rootWithoutParent children anyOne.
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
		addConnection: GtLineSceneryStencil new
		from: item1
		to: item2.
	scripter := BlScripter new element: scenery asElement.
	element := scripter rootWithoutParent children anyOne.
	self assert: element children size = 3.
	^ scenery
]
