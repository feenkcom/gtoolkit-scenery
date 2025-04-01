"
These examples highlight which class diagrams are valid or invalid.
"
Class {
	#name : #GtSceneryUMLClassExamples,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #'as yet unclassified' }
GtSceneryUMLClassExamples >> collectionObjectInheritanceIsInvalid [
	<gtExample>
	| scenery item1 item2 |
	scenery := GtScenery new.
	item1 := scenery addItem: (GtSceneryUMLClassStencil new label: 'Object') asItem.
	item1 position: -44.0 @ -48.0.
	item1 extent: 48.41600036621094 @ 28.0.
	item2 := scenery
			addItem: (GtSceneryUMLClassStencil new label: 'Collection') asItem.
	item2 position: -19.0 @ 26.0.
	item2 extent: 69.33201599121094 @ 28.0.
	scenery
		addConnectionWithStencil: (GtSceneryUMLConnectionStencil new
				relationshipType: #inheritance)
		from: item1
		to: item2.

	self assert: scenery connections first isValid not.
	self assert: scenery isValid not.

	^ scenery
]

{ #category : #'as yet unclassified' }
GtSceneryUMLClassExamples >> nonsenseClassNameIsNotValid [
	"Double-clicking is disabled."

	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryUMLClassStencil new label: 'a few good men') asItem.
	self assert: item1 isValid not.
	self assert: scenery isValid not.
	^ scenery
]

{ #category : #'as yet unclassified' }
GtSceneryUMLClassExamples >> objectClassIsValid [
	"Double-clicking goes to the class"

	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery addItem: (GtSceneryUMLClassStencil new label: 'Object') asItem.
	self assert: item1 isValid.
	self assert: scenery isValid.
	^ scenery
]

{ #category : #'as yet unclassified' }
GtSceneryUMLClassExamples >> objectCollectionInheritanceIsValid [
	<gtExample>
	| scenery item1 item2 |
	scenery := GtScenery new.
	item1 := scenery addItem: (GtSceneryUMLClassStencil new label: 'Object') asItem.
	item1 position: -44.0 @ -48.0.
	item2 := scenery
			addItem: (GtSceneryUMLClassStencil new label: 'Collection') asItem.
	item2 position: -19.0 @ 26.0.
	scenery
		addConnectionWithStencil: (GtSceneryUMLConnectionStencil new
				relationshipType: #inheritance)
		from: item2
		to: item1.

	self assert: scenery connections first isValid.
	self assert: scenery isValid.

	^ scenery
]
