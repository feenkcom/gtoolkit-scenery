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
	<return: #GtScenery>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery addSceneryItem: GtSceneryLePageTitleLabelStencil new asItem.
	self assert: item1 isValid.
	^ scenery
]

{ #category : #scenery }
GtSceneryLePageTitleLabelExamples >> patternsLabel [
	<gtExample>
	<return: #GtScenery>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new label: 'Moldable Development patterns')
					asItem.
	self assert: item1 isValid.
	^ scenery
]
