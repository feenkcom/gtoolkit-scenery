Class {
	#name : #GtSceneryTextLabelStencilExamples,
	#superclass : #AbstractGtExampleAssertable,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #scenery }
GtSceneryTextLabelStencilExamples >> foobarTextLabelScenery [
	<gtExample>
	<return: #GtScenery>
	| scenery |
	scenery := GtScenery new
			addItem: (GtSceneryTextLabelStencil new label: 'Foobar') asItem;
			yourself.
	^ scenery
]

{ #category : #scenery }
GtSceneryTextLabelStencilExamples >> foobarTextLabelSceneryRelabeled [
	<gtExample>
	<return: #GtScenery>
	| scenery foobarStencil |
	scenery := self foobarTextLabelScenery.
	foobarStencil := scenery items first stencil.

	self assert: foobarStencil label equals: foobarStencil text asString.
	foobarStencil label: 'Barfox'.
	self assert: foobarStencil label equals: foobarStencil text asString.

	^ scenery
]
