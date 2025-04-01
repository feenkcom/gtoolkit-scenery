Class {
	#name : #GtSceneryConnection,
	#superclass : #Object,
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

{ #category : #'as yet unclassified' }
GtSceneryConnection >> from [
	^ from
]

{ #category : #accessing }
GtSceneryConnection >> from: anItem [ 
	from := anItem
]

{ #category : #'as yet unclassified' }
GtSceneryConnection >> isValid [
	^ (self stencil class canUnderstand: #isValid)
		ifTrue: [ self stencil isValid ]
		ifFalse: [ true ]
]

{ #category : #'as yet unclassified' }
GtSceneryConnection >> stencil [
	^ stencil
]

{ #category : #accessing }
GtSceneryConnection >> stencil: aLineStencil [ 
	stencil := aLineStencil
]

{ #category : #'as yet unclassified' }
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
