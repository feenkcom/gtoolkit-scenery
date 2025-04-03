Class {
	#name : #GtSceneryConnection,
	#superclass : #Object,
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
	^ line
]

{ #category : #accessing }
GtSceneryConnection >> from [
	^ from
]

{ #category : #accessing }
GtSceneryConnection >> from: anItem [ 
	from := anItem
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
	stencil := aLineStencil
]

{ #category : #accessing }
GtSceneryConnection >> to [
	^ to
]

{ #category : #accessing }
GtSceneryConnection >> to: item2 [ 
	to := item2
]

{ #category : #'connection menu' }
GtSceneryConnection >> updateConnectionContextMenuItems: aBrMenuItems forSceneryElement: aGtSceneryElement andConnectionElement: aConnectionElement [
	self stencil updateContextMenuItems: aBrMenuItems forSceneryElement: aGtSceneryElement andChildElement: aConnectionElement
]
