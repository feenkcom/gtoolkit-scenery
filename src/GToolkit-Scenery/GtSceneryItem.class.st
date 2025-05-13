"
I am an item within a scenery. I wrap a stencil for an actual item.
"
Class {
	#name : #GtSceneryItem,
	#superclass : #GtSceneryEntity,
	#traits : 'TGtSceneryReporting',
	#classTraits : 'TGtSceneryReporting classTrait',
	#instVars : [
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

{ #category : #converting }
GtSceneryItem >> asElementIn: aSceneryElement [
	<tag: #sceneryListeners>
	| element |
	element := stencil asElement.
	element states
		addState: BrLayoutVerticalResizerState exact;
		addState: BrLayoutVerticalResizerState exact.

	extent = (0 @ 0)
		ifFalse: [ extent y = 0
				ifTrue: [ element width: extent y ]
				ifFalse: [ extent x = 0
						ifTrue: [ element height: extent y ]
						ifFalse: [ element size: extent ] ] ].	"Either x or y or bolth could be freely decided by the element."


	element graph model: self.
	element graph beNode.
	element beFocusable.

	self announcer
		when: GtSceneryItemMoved
		do: [ :announcement :subscriber | element relocate: self position ]
		for: element.

	self announcer
		when: GtSceneryItemUpdated
		do: [ :announcement :subscriber | element isSceneryElement ifTrue: [ element updateAppearance ] ]
		for: element.

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
		when: BlDoubleClickEvent
		do: [ :e | 
			e consumed: true.
			stencil
				handleDoubleClickForItemElement: element
				inSceneryElement: aSceneryElement ].

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
	"NB: If the extent is 0@0, let the element choose the size.
	If x or y = 0, then let the element choose that value.
	Important for text elements, which may be free in x and y, or just in y."

	aPoint notNil ifTrue: [ extent := aPoint ]
]

{ #category : #view }
GtSceneryItem >> gtExampleMethodFor: aView [
	<gtView>
	(self stencil isKindOf: GtSceneryExampleStencil) ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Example method';
		priority: 45;
		object: [ self stencil exampleMethod ];
		view: #gtSourceCodeFor:
]

{ #category : #views }
GtSceneryItem >> gtStencilStoreOnFor: aView [
	<gtView>
	^ aView forward
		title: 'Stencil Store on';
		priority: 40;
		object: [ self stencil ];
		view: #gtStoreOnFor:
]

{ #category : #views }
GtSceneryItem >> gtViewFor: aView [
	<gtView>
	^ aView forward
		title: 'Live';
		priority: 10;
		object: [ self stencil ];
		view: #gtLiveFor:
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

{ #category : #validity }
GtSceneryItem >> isValid [
	^ self stencil isValidIn: self
]

{ #category : #'as yet unclassified' }
GtSceneryItem >> neededHeight [
	"Estimated height needed for inserting this item in a scenery."

	^ self stencil neededHeight > 0
		ifTrue: [ self stencil neededHeight ]
		ifFalse: [ self extent y ]
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
	position := aPoint.
	self announce: (GtSceneryItemMoved new item: self)
]

{ #category : #'as yet unclassified' }
GtSceneryItem >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self stencil;
		nextPut: $)
]

{ #category : #updating }
GtSceneryItem >> resizeOnlyMiddleRight [
	"Remove all but the middle right listener."

	| middleRight |
	self resizer children
		detect: [ :l | l eventDispatcher handlers first isKindOf: BlResizerRightListener ]
		ifFound: [ :l | 
			middleRight := l.
			self resizer removeChildren.
			self resizer addChild: middleRight ]
		ifNone: [  ]
]

{ #category : #accessing }
GtSceneryItem >> resizer [
	^ resizer
		ifNil: [ resizer := BlResizerElement new preventMouseEvents zIndex: 100 ]
]

{ #category : #accessing }
GtSceneryItem >> stencil: anItemStencil [
	self unsubscribe.
	stencil := anItemStencil.
	self subscribe
]

{ #category : #connecting }
GtSceneryItem >> stencilForConnectionWith: anItem labeled: aText [
	"Let the stencil decide the connection stencil to use."

	^ self stencil
		stencilForConnectionWithItemStencil: anItem stencil
		labeled: aText
]

{ #category : #announcements }
GtSceneryItem >> subscribe [
	self stencil isSceneryStencil ifFalse: [ ^ self ].
	self stencil announcer
		when: GtStencilUpdated
		do: [ :announcement :subscriber | self announce: (GtSceneryItemUpdated new item: self) ]
		for: self
]

{ #category : #announcements }
GtSceneryItem >> unsubscribe [
	self stencil
		ifNotNil: [ self stencil isSceneryStencil
				ifTrue: [ self stencil announcer unsubscribe: self ] ]
]
