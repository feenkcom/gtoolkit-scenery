Class {
	#name : #GtSceneryTextStencil,
	#superclass : #GtSceneryDraggableItem,
	#instVars : [
		'text'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #acccessing }
GtSceneryTextStencil class >> itemCreationSubmenuLabel [
	^ 'Text'
]

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

{ #category : #initialization }
GtSceneryTextStencil >> initialize [
	super initialize.
	extent := 100 @ 50.
	text := 'Text' asRopedText
]

{ #category : #copying }
GtSceneryTextStencil >> postCopy [
	super postCopy.
	text := text copy
]

{ #category : #printing }
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
