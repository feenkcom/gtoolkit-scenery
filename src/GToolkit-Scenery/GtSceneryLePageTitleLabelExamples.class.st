"
Some Lepiter page item stencils -- to be expanded.

To do: prepare examples of Lepiter roadmaps.
"
Class {
	#name : #GtSceneryLePageTitleLabelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #scenery }
GtSceneryLePageTitleLabelExamples >> gtBookLabel [
	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery addItem: GtSceneryLePageTitleLabelStencil new asItem.
	self assert: item1 isValid.
	^ scenery
]

{ #category : #scenery }
GtSceneryLePageTitleLabelExamples >> patternsLabel [
	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryLePageTitleLabelStencil new label: 'Moldable Development patterns')
					asItem.
	self assert: item1 isValid.
	^ scenery
]
