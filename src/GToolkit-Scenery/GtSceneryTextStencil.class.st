Class {
	#name : #GtSceneryTextStencil,
	#superclass : #GtSceneryDraggableItem,
	#instVars : [
		'text'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryTextStencil >> create [
	^ BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude;
		text: text;
		size: extent;
		background: Color white;
		margin: (BlInsets all: 10);
		when: BrEditorTextChanged do: [ :e | self text: e text ]
]

{ #category : #accessing }
GtSceneryTextStencil >> initialize [
	super initialize.
	extent := 300 @ 200.
	text := 'Text' asRopedText
]

{ #category : #accessing }
GtSceneryTextStencil >> storeOn: aStream [
	super storeOn: aStream.
	aStream
		space;
		nextPutAll: 'text: (', text storeString, ')'
]

{ #category : #accessing }
GtSceneryTextStencil >> text [
	^ text
]

{ #category : #accessing }
GtSceneryTextStencil >> text: anObject [
	text := anObject
]
