"
I am an item within a scenery. I wrap a stencil for an actual item. The stencil classes are subclasses of {{gtClass:name=GtSceneryItemStencil}}.
"
Class {
	#name : #GtSceneryItem,
	#superclass : #Object,
	#instVars : [
		'stencil',
		'position',
		'extent',
		'incomingLinks',
		'outgoingLinks',
		'resizer'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryItem >> addIncomingLink: anItem [ 
	incomingLinks add: anItem
]

{ #category : #accessing }
GtSceneryItem >> addLinkTo: anItem [
	self addOutgoingLink: anItem.
	anItem addIncomingLink: self
]

{ #category : #accessing }
GtSceneryItem >> addOutgoingLink: anItem [ 
	outgoingLinks add: anItem
]

{ #category : #accessing }
GtSceneryItem >> asElementIn: aSceneryElement forScenery: aScenery [
	<tag: #sceneryListeners>
	| element |
	element := stencil asElement.
	element states
		addState: BrLayoutVerticalResizerState exact;
		addState: BrLayoutVerticalResizerState exact.	"this is needed to support complicated widgets"
	extent ifNotNil: [ element size: extent ].	"Don't change the size if extent is nil."
	element graph model: self.
	element graph beNode.
	element beFocusable.
	element
		when: BlClickEvent
			do: [ :e | 
				e currentTarget requestFocus.
				e consumed: true ];
		when: BlFocusOutEvent
			do: [ :e | 
				self resizer
					detach;
					removeFromParent ];
		when: BlFocusInEvent
			do: [ :e | 
				self resizer
					detach;
					removeFromParent.
				aSceneryElement container addChild: resizer.
				resizer attachTo: element ].

	element
		addEventHandler: GtSceneryPullHandler new;
		relocate: position.
	element addEventHandler: (GtSceneryDragHandler for: aSceneryElement).

	^ element
]

{ #category : #accessing }
GtSceneryItem >> extent [
	^ extent
]

{ #category : #accessing }
GtSceneryItem >> extent: aPoint [
	extent := aPoint
]

{ #category : #accessing }
GtSceneryItem >> incomingLinks [
	^ incomingLinks
]

{ #category : #accessing }
GtSceneryItem >> incomingLinks: anObject [
	incomingLinks := anObject
]

{ #category : #accessing }
GtSceneryItem >> initialize [
	super initialize.
	position := 0@0.
	extent := 200 @ 200.
	incomingLinks := OrderedCollection new.
	outgoingLinks := OrderedCollection new
]

{ #category : #accessing }
GtSceneryItem >> outgoingLinks [
	^ outgoingLinks
]

{ #category : #accessing }
GtSceneryItem >> outgoingLinks: anObject [
	outgoingLinks := anObject
]

{ #category : #accessing }
GtSceneryItem >> position [
	^ position
]

{ #category : #accessing }
GtSceneryItem >> position: aPoint [ 
	position := aPoint
]

{ #category : #updating }
GtSceneryItem >> resizeOnlyMiddleRight [
	"A hack available for the GtSceneryTextLabelStencil"

	| middleRight |
	middleRight := self resizer children at: 5.
	self
		assert: (middleRight eventDispatcher handlers first isKindOf: BlResizerRightListener).
	resizer removeChildren.
	resizer addChild: middleRight.
	resizer
]

{ #category : #accessing }
GtSceneryItem >> resizer [
	^ resizer
		ifNil: [ resizer := BlResizerElement new preventMouseEvents zIndex: 100 ]
]

{ #category : #accessing }
GtSceneryItem >> stencil [
	^ stencil
]

{ #category : #accessing }
GtSceneryItem >> stencil: anItemStencil [ 
	stencil := anItemStencil
]
