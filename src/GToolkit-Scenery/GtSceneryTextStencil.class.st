"
Should be deprecated in favour of `GtSceneryTextLabelStencil`
"
Class {
	#name : #GtSceneryTextStencil,
	#superclass : #GtSceneryDraggableItemStencil,
	#instVars : [
		'text'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #'as yet unclassified' }
GtSceneryTextStencil class >> itemCreationSubmenuLabel [
	^ 'Text (old)'
]

{ #category : #accessing }
GtSceneryTextStencil >> create [
	<tag: #sceneryListeners>
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
	text := anObject.
	self announceUpdate
]
