"
These examples highlight which class diagrams are valid or invalid.
"
Class {
	#name : #GtSceneryUMLClassExamples,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #'as yet unclassified' }
GtSceneryUMLClassExamples >> nonsenseClassNameIsNotValid [
	"Double-clicking is disabled."

	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryUMLClassStencil new label: 'a few good men') asItem.
	self assert: item1 stencil isValid not.
	^ scenery
]

{ #category : #'as yet unclassified' }
GtSceneryUMLClassExamples >> objectClassIsValid [
	"Double-clicking goes to the class"

	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery addItem: (GtSceneryUMLClassStencil new label: 'Object') asItem.
	self assert: item1 stencil isValid.
	^ scenery
]
