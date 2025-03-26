"
I am a stencil for a text label that can be specialized by subclasses to show different styles, or to link to wrapped items such as classes or Lepiter pages.
"
Class {
	#name : #GtSceneryTextLabelStencil,
	#superclass : #GtSceneryDraggableItem,
	#instVars : [
		'text',
		'width'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #acccessing }
GtSceneryTextLabelStencil class >> itemCreationSubmenuLabel [
	^ 'Text label'
]

{ #category : #converting }
GtSceneryTextLabelStencil >> asItem [
	^ GtSceneryItem new
		stencil: self;
		extent: self extent;
		resizeOnlyMiddleRight;
		yourself
]

{ #category : #'api - instantiation' }
GtSceneryTextLabelStencil >> create [
	| anEditableLabel |
	anEditableLabel := self elementClass new
			text: self text;
			yourself.
	self width
		ifNotNil: [ anEditableLabel
				hExact: width;
				vFitContent ].
	^ anEditableLabel
]

{ #category : #'api - instantiation' }
GtSceneryTextLabelStencil >> elementClass [
	^ GtSceneryTextLabelElement
]

{ #category : #initialization }
GtSceneryTextLabelStencil >> initialize [
	super initialize.
	text := 'Double click me' asRopedText.
	self extent: nil
]

{ #category : #printing }
GtSceneryTextLabelStencil >> postCopy [
	super postCopy.
	text := text copy
]

{ #category : #printing }
GtSceneryTextLabelStencil >> storeOn: aStream [
	super storeOn: aStream.
	aStream
		space;
		nextPutAll: 'text: ('.
	self text storeOn: aStream.
	aStream nextPutAll: ' asRopedText)'.
	width ifNotNil: [ aStream nextPutAll: '; width: (' , width storeString , ')' ]
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> text [
	^ text
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> text: aText [
	text := aText
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> width [
	^ width
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> width: aWidth [
	width := aWidth
]
