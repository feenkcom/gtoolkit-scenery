Class {
	#name : #GtSceneryConnection,
	#superclass : #GtSceneryEntity,
	#traits : 'TGtSceneryReporting',
	#classTraits : 'TGtSceneryReporting classTrait',
	#instVars : [
		'stencil',
		'from',
		'to'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryConnection >> asElementIn: aContainerElement [
	| line |
	line := stencil asElement.
	line graph model: self.
	line graph beEdge.

	self announcer
		when: GtSceneryConnectionUpdated
		do: [ :announcement :subscriber | line isUpdatableSceneryEntityElement ifTrue: [ line updateAppearance ] ]
		for: line.	"	line isUpdatableSceneryEntityElement
		ifTrue: [ line
				addAptitude: (BrStyleCommonAptitude new
						default: [ :elt | elt border: (BlBorder paint: Color black) ];
						hovered: [ :elt | elt border: (BlBorder paint: Color blue) ]) ]."
	line isUpdatableSceneryEntityElement
		ifTrue: [ line
				addAptitude: (BrStyleCommonAptitude new
						default: [ :elt | elt border: (BlBorder paint: [ line borderColor ] value width: line borderWidth) ];
						hovered: [ :elt | elt border: (BlBorder paint: [ line hoverColor ] value width: line borderWidth) ]) ].


	aContainerElement
		allChildrenBreadthFirstDetect: [ :each | each graph model = from ]
		ifFound: [ :fromElement | 
			aContainerElement
				allChildrenBreadthFirstDetect: [ :each | each graph model = to ]
				ifFound: [ :toElement | 
					line
						fromAnchor: (BlNearestPositionBoundsAnchor nearestTo: toElement from: fromElement).
					line
						toAnchor: (BlNearestPositionBoundsAnchor nearestTo: fromElement from: toElement).
					fromElement graph connectTo: toElement ]
				ifNone: [ self error: 'Could not find element' ] ]
		ifNone: [ self error: 'Could not find element' ].
	line userData at: #sceneryConnection put: true.
	line isUpdatableSceneryEntityElement ifTrue: [ line updateAppearance ].
	^ line
]

{ #category : #accessing }
GtSceneryConnection >> from [
	^ from
]

{ #category : #accessing }
GtSceneryConnection >> from: anItem [
	from := anItem.
	self subscribeToItem: anItem
]

{ #category : #views }
GtSceneryConnection >> gtLiveFor: aView [
	<gtView>
	^ aView forward
		title: 'Live';
		priority: 10;
		object: [ self sceneryForConnection ];
		view: #gtLiveFor:
]

{ #category : #validity }
GtSceneryConnection >> isValid [
	^ self stencil isValidIn: self
]

{ #category : #accessing }
GtSceneryConnection >> sceneryForConnection [
	| scenery |
	scenery := GtScenery new.
	from := scenery addItem: self from.
	to := scenery addItem: self to.
	scenery
		addConnectionWithStencil: self stencil
		from: from
		to: to.
	^ scenery
]

{ #category : #accessing }
GtSceneryConnection >> stencil [
	^ stencil
]

{ #category : #accessing }
GtSceneryConnection >> stencil: aLineStencil [
	self unsubscribe.
	stencil := aLineStencil.
	self subscribe
]

{ #category : #announcements }
GtSceneryConnection >> subscribe [
	self stencil isSceneryStencil ifFalse: [ ^ self ].
	self stencil announcer
		when: GtStencilUpdated
		do: [ :announcement :subscriber | self announce: (GtSceneryConnectionUpdated new connection: self) ]
		for: self
]

{ #category : #announcements }
GtSceneryConnection >> subscribeToItem: anItem [
	"Transform updates from my connected items to my subscribers."
	anItem announcer
		when: GtSceneryItemUpdated
		do: [ :announcement :subscriber | self announce: (GtSceneryConnectionUpdated new connection: self) ]
		for: self
]

{ #category : #accessing }
GtSceneryConnection >> to [
	^ to
]

{ #category : #accessing }
GtSceneryConnection >> to: anItem [ 
	to := anItem.
	self subscribeToItem: anItem
]

{ #category : #announcements }
GtSceneryConnection >> unsubscribe [
	self stencil
		ifNotNil: [ self stencil isSceneryStencil
				ifTrue: [ self stencil announcer unsubscribe: self ] ]
]

{ #category : #'connection menu' }
GtSceneryConnection >> updateConnectionContextMenuItems: aBrMenuItems forSceneryElement: aGtSceneryElement andConnectionElement: aConnectionElement [
	self stencil updateContextMenuItems: aBrMenuItems forSceneryElement: aGtSceneryElement andChildElement: aConnectionElement
]
