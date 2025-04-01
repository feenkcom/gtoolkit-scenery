"
These examples highlight which class diagrams are valid or invalid.
"
Class {
	#name : #GtSceneryUMLClassExamples,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #'as yet unclassified' }
GtSceneryUMLClassExamples >> objectDiagramIsValid [
	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery addItem: GtSceneryUMLClassStencil new asItem.
	
	^ scenery
]
