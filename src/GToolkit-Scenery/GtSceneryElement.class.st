"
I am an element for rendering a {{gtClass:name=GtScenery}}. I render the scenery using a `container` which is an instance of {{gtClass:name=BlCanvassableElement}}. 

By default, autoscaling is initially turned on, so the scenery will be displayed to take up the entire visible canvas.
"
Class {
	#name : #GtSceneryElement,
	#superclass : #BlElement,
	#instVars : [
		'gtScenery',
		'container'
	],
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #menu }
GtSceneryElement >> backgroundMenu [
	"Just a placeholder for now."
	^ BrGlamorousSimpleContextMenuContent new
		items: {'Inspect graph' -> [ self inspect ]};
		yourself
]

{ #category : #accessing }
GtSceneryElement >> container [
	^ container
]

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
			"elementToSpawn := self createElementFor: itemToSpawn.
			itemElement graph connectTo: elementToSpawn.
			itemElement
				withDeep: [ :each | each graph nodesAlongIncomingEdges asArray ]
				do: [ :each | 
					each
						addEventHandler: (BlPullHandler new targetElement: elementToSpawn) ].
			container addChild: elementToSpawn" ].
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
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons zoomin asElement;
				label: 'Zoom In' asRopedText;
				action: [ self container zoomIn ] ];
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons zoomout asElement;
				label: 'Zoom Out' asRopedText;
				action: [ self container zoomOut ] ];
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons zoomtofit asElement;
				label: 'Zoom to fit' asRopedText;
				action: [ self container zoomToFit ] ];
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons actualsize asElement;
				label: 'Zoom to actual size' asRopedText;
				action: [ self container zoomToActualSize ] ];
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons refresh asElement;
				label: 'Refresh' asRopedText;
				action: [ self requestLayout ] ]
]

{ #category : #accessing }
GtSceneryElement >> gtScenery [
	^ gtScenery
]

{ #category : #accessing }
GtSceneryElement >> gtScenery: aScenery [
	| itemElement |
	self unsubscribe.
	gtScenery := aScenery.
	gtScenery items
		do: [ :eachItem | 
			itemElement := self createElementFor: eachItem.
			container addChild: itemElement ].
	gtScenery connections
		do: [ :eachConnection | 
			container
				addChild: (eachConnection asElementIn: container forScenery: self gtScenery) ].
	gtScenery items notEmpty ifTrue: [ self container enableAutoScale ].
	self subscribe
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
	self initializeEventListers.
]

{ #category : #initialization }
GtSceneryElement >> initializeEventListers [
	self container
		when: BlDoubleClickEvent
		do: [ :evt | 
			| item |
			item := GtSceneryTextStencil new asItem.
			item position: evt childrenPosition.
			self gtScenery addItem: item ].
	self container
		aptitude: (BrGlamorousWithContextMenuAptitude content: [ self backgroundMenu ])
]

{ #category : #announcement }
GtSceneryElement >> subscribe [
	"We want to see when a new item is added to the model.
	NB: This conflicts with the spawnObject: logic in createElementFor:,
	which also generates a new element for an item added."

	self gtScenery announcer
		when: GtSceneryItemAdded
		do: [ :announcement :subscriber | 
			| newElement |
			newElement := self createElementFor: announcement item.
			self container addChild: newElement ]
		for: self
]

{ #category : #announcement }
GtSceneryElement >> unsubscribe [
	gtScenery ifNotNil: [ gtScenery announcer unsubscribe: self ]
]
