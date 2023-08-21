Class {
	#name : #GtSceneryElement,
	#superclass : #BlElement,
	#instVars : [
		'gtScenery',
		'container'
	],
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #accessing }
GtSceneryElement >> createElementFor: eachItem [
	| itemElement itemToSpawn |
	itemElement := eachItem asElementIn: container forScenery: gtScenery.
	itemElement when: GtPhlowObjectToSelect do: [ :e | e consumed: true ].
	itemElement
		when: GtPhlowObjectToSpawn
		do: [ :e | 
			| elementToSpawn |
			e consumed: true.
			itemToSpawn := GtSceneryItem new
					stencil: (GtSceneryInspectorStencil new target: [ e object ]);
					position: itemElement bounds topRight + (40 @ 0);
					extent: itemElement bounds extent.
			eachItem addLinkTo: itemToSpawn.
			gtScenery addItem: itemToSpawn.
			elementToSpawn := self createElementFor: itemToSpawn.
			itemElement graph connectTo: elementToSpawn.
			itemElement
				withDeep: [ :each | each graph nodesAlongIncomingEdges asArray ]
				do: [ :each | 
					each
						addEventHandler: (BlPullHandler new targetElement: elementToSpawn) ].
			container addChild: elementToSpawn ].
	itemElement
		when: BlElementPositionChangedEvent
		do: [ :e | eachItem position: e currentTarget position ].
	itemElement
		when: BlElementExtentChangedEvent
		do: [ :e | eachItem extent: e currentTarget extent ].
	^ itemElement
]

{ #category : #accessing }
GtSceneryElement >> gtLiveFor: aView [
	<gtView>
	^ (super gtLiveFor: aView)
		actionStencil: [ 
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons zoomin asElement;
				label: 'Zoom In' asRopedText;
				action: [ self children first zoomIn ] ];
		actionStencil: [ 
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons zoomout asElement;
				label: 'Zoom Out' asRopedText;
				action: [ self children first zoomOut ] ];
		actionStencil: [ 
			BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons actualsize asElement;
				label: 'Resize' asRopedText;
				action: [ self children first zoomToActualSize ] ]
]

{ #category : #accessing }
GtSceneryElement >> gtScenery [
	^ gtScenery
]

{ #category : #accessing }
GtSceneryElement >> gtScenery: aScenery [
	| itemElement |
	gtScenery := aScenery.
	gtScenery items
		do: [ :eachItem | 
			"container addChild: "
			itemElement := self createElementFor: eachItem.
			container addChild: itemElement ].
	gtScenery connections
		do: [ :eachConnection | 
			container
				addChild: (eachConnection asElementIn: container forScenery: self gtScenery) ]
]

{ #category : #accessing }
GtSceneryElement >> initialize [
	super initialize.
	self constraintsDo: [ :c | 
				c vertical matchParent.
				c horizontal matchParent ].
	container := BlCanvassableElement new
			background: Color white;
			constraintsDo: [ :c | 
				c vertical matchParent.
				c horizontal matchParent ].
	self addChild: container.
]
