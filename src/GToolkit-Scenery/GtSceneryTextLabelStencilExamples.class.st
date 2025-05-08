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
			addSceneryItem: (GtSceneryTextLabelStencil new label: 'Foobar') asItem;
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

{ #category : #'as yet unclassified' }
GtSceneryTextLabelStencilExamples >> privateDatabaseLePageLabelExample [
	"This example will only work if the private db has a page named 'Tag'."

	<gtExample>
	<return: #GtScenery>
	<noTest>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new
					label: 'Tag';
					width: 157.8820343017578;
					databaseName: 'Documents/lepiter/default') asItem.
	self assert: scenery equals: scenery restored.
	^ scenery
]
