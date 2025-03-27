"
I handle a Ctrl-click and drag event between two items in a {{gtClass:name=GtScenery}} to create an connection.

I must be on a node both when starting and stopping.

This would be better done using separate drag and drop events, but it seems that BlDropEvent is currently (2020-06-12) broken (sent to the dragged element instead of the drop location). 

NB: This class was cloned from HyperlinkDragHandler in the IMAD project.

"
Class {
	#name : #GtSceneryDragHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'edgeStarted',
		'lineElement',
		'mousePositionElement',
		'container',
		'startElement',
		'sceneryElement',
		'originalChildrenPosition'
	],
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #'instance  creation' }
GtSceneryDragHandler class >> for: aSceneryElement [
	^ self new
		sceneryElement: aSceneryElement;
		yourself
]

{ #category : #'event handling' }
GtSceneryDragHandler >> addConnectionTo: endElement [
	<tag: #shouldBeHandledByAnnouncement>
	| fromItem toItem newConnection newConnectionElement |
	self assert: endElement graph isNode.
	fromItem := startElement graph model.
	toItem := endElement graph model.
	self assertIsSceneryItem: fromItem.
	self assertIsSceneryItem: toItem.
	newConnection := self scenery
			addConnectionWithStencil: GtSceneryStraightArcStencil new
			from: fromItem
			to: toItem.	"Handle rest by announcement ..."	"newConnectionElement := newConnection
			asElementIn: container
			forScenery: self scenery."
	newConnectionElement := self sceneryElement
			createConnectionElementFor: newConnection.

	self sceneryElement container
		addChild: newConnectionElement
		as: (GtSceneryConnectionId indexed: self scenery connections size)
]

{ #category : #asserting }
GtSceneryDragHandler >> assertIsSceneryItem: anObject [
	self assert: (anObject isKindOf: GtSceneryItem)
]

{ #category : #'private - navigation' }
GtSceneryDragHandler >> canvasChildrenPositionFromEvent: anEvent [
	"The current target is a node element in a canvassable element.
	We want a position for a child in the canvassable element."

	| aContainerPosition aParent |
	aParent := anEvent currentTarget parent.
	aContainerPosition := anEvent parentPosition.
	^ aParent localPointToChildren: aContainerPosition
]

{ #category : #'event handling' }
GtSceneryDragHandler >> dragEndEvent: anEvent [
	edgeStarted ifFalse: [ ^ self ].

	anEvent consumed: true.

	self
		findNodeElementAt: anEvent position
		do: [ :endElement | endElement graph isNode ifTrue: [ self addConnectionTo: endElement ] ].

	container removeChild: mousePositionElement.
	container removeChild: lineElement
]

{ #category : #'event handling' }
GtSceneryDragHandler >> dragEvent: anEvent [
	| aChildrenPosition |
	"offset the mouse position node to be centered relative to the mouse position"
	edgeStarted ifFalse: [ ^ self ].
	anEvent currentTarget hasParent ifFalse: [ ^ self ].
	anEvent consumed: true.
	aChildrenPosition := self canvasChildrenPositionFromEvent: anEvent.
	mousePositionElement
		relocate: aChildrenPosition 
			"offset the mouse position node to be centered relative to the mouse position"
			- (self mousePositionExtent / 2.0)
]

{ #category : #'event handling' }
GtSceneryDragHandler >> dragStartEvent: anEvent [
	startElement := anEvent currentTarget.
	startElement graph isNode
		ifFalse: [ ^ self ].

	anEvent consumed: true.

	"self assert: (startElement isKindOf: HypernodeElement)."
	edgeStarted := true.

	"element position"
	originalChildrenPosition := self canvasChildrenPositionFromEvent: anEvent.

	container := startElement parent.
	mousePositionElement relocate: originalChildrenPosition 
		"offset the mouse position node to be centered relative to the mouse position"
		- (self mousePositionExtent / 2.0).
	lineElement := BlLineElement new.
	lineElement
		zIndex: 100;
		border: (BlBorder paint: Color blue width: 1);
		fromAnchor: (BlElementCenterAnchor element: startElement);
		toAnchor: (BlElementCenterAnchor element: mousePositionElement).
	container addChild: mousePositionElement.
	container addChild: lineElement
]

{ #category : #'event handling' }
GtSceneryDragHandler >> eventsToHandle [
	^ { BlDragStartEvent . BlDragEvent . BlDragEndEvent }
]

{ #category : #'private - navigation' }
GtSceneryDragHandler >> findNodeElementAt: aGlobalPosition do: ifFoundBlock [
	"Starting from my container, I search from the leaf children
	up to the container for the first node element I find."

	container
		withAllLeafChildrenAt: (container globalPointToLocal: aGlobalPosition)
		do: [ :eachElement | 
			eachElement
				withAllParentsUpTo: container
				detect: [ :eachParent | eachParent graph isNode ]
				ifFound: [ :aHypernodeElement | ^ ifFoundBlock value: aHypernodeElement ]
				ifNone: [  ] ]
]

{ #category : #initialization }
GtSceneryDragHandler >> initialize [
	super initialize.
	edgeStarted := false.
	mousePositionElement := BlElement new
		id: #'scenery--mouse-position';
		geometry: BlEllipseGeometry new;
		size: self mousePositionExtent;
		background: Color blue;
		border: BlBorder empty;
		zIndex: 100
]

{ #category : #asserting }
GtSceneryDragHandler >> isSceneryItemElement: anElement [
	self assert: (anElement isKindOf: BlElement).
	anElement graph isNode ifFalse: [^ false].
	anElement id
]

{ #category : #initialization }
GtSceneryDragHandler >> mousePositionExtent [
	"Size of the mouse position element (the blue circle)"
	^ 10 @ 10
]

{ #category : #acccessing }
GtSceneryDragHandler >> scenery [
	^ self sceneryElement gtScenery
]

{ #category : #accessing }
GtSceneryDragHandler >> sceneryElement [
	^ sceneryElement
]

{ #category : #accessing }
GtSceneryDragHandler >> sceneryElement: anObject [
	sceneryElement := anObject
]

{ #category : #'event handling' }
GtSceneryDragHandler >> wantsEvent: anEvent [
	"I only want Control events"
	^ (super wantsEvent: anEvent) and: [ anEvent modifiers isCtrl ]
]
