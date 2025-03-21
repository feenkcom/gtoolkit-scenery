"
I am similar to a {{gtClass:name=GtSceneryTextStencil}}, but I am intended to be used as a node within a Mind map.

"
Class {
	#name : #GtSceneryMindMapNodeStencil,
	#superclass : #GtSceneryDraggableItem,
	#instVars : [
		'text',
		'width'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #'as yet unclassified' }
GtSceneryMindMapNodeStencil class >> itemCreationSubmenuLabel [
	^ 'Mind map bubble'
]

{ #category : #'api - instantiation' }
GtSceneryMindMapNodeStencil >> create [
	| anEditableLabel |
	anEditableLabel := GtSceneryMindMapNodeElement new
			text: self text;
			yourself.
	self width
		ifNotNil: [ anEditableLabel
				hExact: width;
				vFitContent ].
	^ anEditableLabel
]

{ #category : #initialization }
GtSceneryMindMapNodeStencil >> initialize [
	super initialize.
	text := 'Double click me' asRopedText.
	self extent: nil
]

{ #category : #printing }
GtSceneryMindMapNodeStencil >> postCopy [
	super postCopy.
	text := text copy
]

{ #category : #printing }
GtSceneryMindMapNodeStencil >> storeOn: aStream [
	super storeOn: aStream.
	aStream
		space;
		nextPutAll: 'text: (' , text asString printString , ' asRopedText)'.
	width
		ifNotNil: [ aStream
				nextPutAll: '; width: (' , width storeString , ')' ]
]

{ #category : #accessing }
GtSceneryMindMapNodeStencil >> text [
	^ text
]

{ #category : #accessing }
GtSceneryMindMapNodeStencil >> text: anObject [
	text := anObject
]

{ #category : #accessing }
GtSceneryMindMapNodeStencil >> width [
	^ width
]

{ #category : #accessing }
GtSceneryMindMapNodeStencil >> width: anObject [
	width := anObject
]
