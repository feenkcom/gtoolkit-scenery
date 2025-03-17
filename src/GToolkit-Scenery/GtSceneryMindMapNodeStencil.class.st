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

{ #category : #'api - instantiation' }
GtSceneryMindMapNodeStencil >> addLabelShortcutsTo: anEditableLabel [
	anEditableLabel
		labelShortcuts: anEditableLabel labelShortcuts
				, {BrEditorShortcut new
							name: 'Add subnode';
							description: 'Add a subnode.';
							combination: BlKeyCombination tab;
							performBlock: [ anEditableLabel
									fireEvent: (GtSceneryAddNewConnection new
											fromItemElement: anEditableLabel;
											toStencil: self class new;
											yourself) ];
							yourself}
]

{ #category : #'api - instantiation' }
GtSceneryMindMapNodeStencil >> create [
	| anEditableLabel resizer |
	anEditableLabel := BrEditableLabel new
			aptitude: BrGlamorousEditableLabelAptitude new glamorousRegularFontAndSize;
			text: self text;
			id: GtSceneryMindmapNodeId.
	self addLabelShortcutsTo: anEditableLabel.
	self width
		ifNotNil: [ anEditableLabel
				hExact: width;
				vFitContent ].
	resizer := BlResizerElement new preventMouseEvents zIndex: 100.
	anEditableLabel
		when: BlFocusOutEvent
			do: [ :e | 
				resizer
					detach;
					removeFromParent ];
		when: BlFocusInEvent
			do: [ :e | 
				resizer
					detach;
					removeFromParent.
				anEditableLabel parent addChild: resizer.
				resizer attachTo: anEditableLabel.
				anEditableLabel
					when: BlResizerResizedEvent
					do: [ :evt | 
						self width: evt extent x.
						anEditableLabel
							hExact: self width;
							vFitContent ] ].
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
