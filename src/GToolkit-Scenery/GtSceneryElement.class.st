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

{ #category : #'item menu' }
GtSceneryElement >> addNewItemFor: anItemStencilClass at: position [
	"Add a new item at the position of the triggering event."

	| item newElement |
	item := anItemStencilClass new asItem.
	item position: position.
	self gtScenery addItem: item.
	self shouldBeHandledByAnnouncement.
	newElement := self createElementFor: item.
	self container addChild: newElement.
	^ newElement
]

{ #category : #initialization }
GtSceneryElement >> buildSceneryContextMenuItemsInto: aMenuItems menuContext: aContext [
	"Build scenery context menu items.
	aMenuItems is a BrMenuItems instance.
	aContext is a BrMenuInitialContext instance."

	aMenuItems
		addItemLabel: 'Add item here'
		action: [ aContext
				childrenPositionDo: [ :aPoint | 
					self addNewItemFor: self defaultItemStencilClass at: aPoint ]
				ifAbsentDo: [ 0 @ 0 ] ].

	aMenuItems addItemLabel: 'Redisplay' action: [ self redisplay ]
]

{ #category : #accessing }
GtSceneryElement >> container [
	^ container
]

{ #category : #accessing }
GtSceneryElement >> createElementFor: eachItem [
	"Instantiate the given item as an element, adding scenery-specific listeners."
	
	| itemElement |
	itemElement := eachItem asElementIn: self forScenery: gtScenery.
	itemElement when: GtPhlowObjectToSelect do: [ :e | e consumed: true ].
	itemElement
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
				items: [ self itemContextMenuForItem: eachItem andElement: itemElement ]).
	itemElement
		when: GtPhlowObjectToSpawn
		do: [ :e | 
			e consumed: true.
			self
				spawnItemWithStencil: (GtSceneryInspectorStencil new target: [ e object ])
				fromElement: itemElement
				forItem: eachItem ].
	itemElement
		when: BlElementPositionChangedEvent
		do: [ :e | eachItem position: e currentTarget position ].
	itemElement
		when: BlElementExtentChangedEvent
		do: [ :e | eachItem extent: e currentTarget extent ].
	^ itemElement
]

{ #category : #initialization }
GtSceneryElement >> defaultItemStencilClass [
	^ GtSceneryMindMapNodeStencil
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
				label: 'Zoom to actual size' asRopedText;
				action: [ self redisplay ] ]
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
		withIndexDo: [ :eachItem :index | 
			itemElement := self createElementFor: eachItem.
			container addChild: itemElement as: (GtSceneryItemId indexed: index) ].
	gtScenery connections
		withIndexDo: [ :eachConnection :index | 
			container
				addChild: (eachConnection asElementIn: container forScenery: self gtScenery)
				as: (GtSceneryConnectionId indexed: index) ].
	gtScenery items isEmpty
		ifTrue: [ self container disableAutoScale ]
		ifFalse: [ self container enableAutoScale ].
	self subscribe
]

{ #category : #accessing }
GtSceneryElement >> initialize [
	super initialize.
	self id: GtSceneryId.
	self
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ].
	container := BlCanvassableElement new
			background: Color white;
			constraintsDo: [ :c | 
				c vertical matchParent.
				c horizontal matchParent ].
	self addChild: container.
	self initializeEventListers
]

{ #category : #initialization }
GtSceneryElement >> initializeEventListers [
	self
		when: GtSceneryObjectToSpawn
		do: [ :e | 
			e consumed: true.
			self phlow spawnObject: e object ].
	self
		when: GtSceneryAddNewConnection
		do: [ :e | 
			e consumed: true.
			self
				spawnNewConnectionWithStencil: e toStencil
				fromElement: e fromItemElement
				forItem: e fromItem ].
	self container
		when: BlDoubleClickEvent
		do: [ :evt | self addNewItemFor: self defaultItemStencilClass at: evt childrenPosition ].
	self container
		aptitude: (BrGlamorousWithExplicitContextMenuAptitude new
				stencil: [ :aContext | 
					| aMenuItems |
					aMenuItems := BrMenuItems new.
					self buildSceneryContextMenuItemsInto: aMenuItems menuContext: aContext.

					aMenuItems itemsCount isZero
						ifTrue: [ nil ]
						ifFalse: [ BrMenuExplicitHandle new menu: aMenuItems ] ])
]

{ #category : #'item menu' }
GtSceneryElement >> inspectItem: anItem forElement: anItemElement [
	"Inspect the actual stencil rather than the item wrapper."
	^ anItemElement fireEvent: (GtSceneryObjectToSpawn new object: anItem stencil)
]

{ #category : #'item menu' }
GtSceneryElement >> inspectItemWrapper: anItem forElement: anItemElement [
	"Inspect the GtSceneryItem instance instead of the stencil it wraps."
	^ anItemElement fireEvent: (GtSceneryObjectToSpawn new object: anItem)
]

{ #category : #'item menu' }
GtSceneryElement >> itemContextMenuForItem: anItem andElement: anItemElement [
	^ {'Inspect item'
			-> [ :elt | self inspectItem: anItem forElement: anItemElement ].
		'Clone item'
			-> [ :elt | 
				self
					spawnItemWithStencil: anItem stencil copy
					fromElement: anItemElement
					forItem: anItem ].
		'Delete item'
			-> [ :elt | 
				self gtScenery removeItem: anItem.
				self shouldBeHandledByAnnouncement.
				anItemElement removeFromParent ].
		'Inspect item wrapper'
			-> [ :elt | self inspectItemWrapper: anItem forElement: anItemElement ]}
]

{ #category : #utility }
GtSceneryElement >> redisplay [
	self container removeChildren.
	self gtScenery: self gtScenery

]

{ #category : #todo }
GtSceneryElement >> shouldBeHandledByAnnouncement [
	<todo: 'View updates are currently handled locally, whereas they should be handled in a listener for announcements from model updates. This should be fixed once the framework stabilizes and it becomes clear which model announcements are needed.'>
]

{ #category : #'as yet unclassified' }
GtSceneryElement >> spawnItemWithStencil: aStencil fromElement: sourceItemElement forItem: sourceItem [
	"I spawn a new item within the Scenery and the SceneryElement, starting from a given source item.
	When the source item is dragged, the new item will by dragged with it."

	| itemToSpawn elementToSpawn |
	itemToSpawn := aStencil asItem.
	itemToSpawn position: sourceItemElement bounds topRight + (40 @ 0).

	sourceItem addLinkTo: itemToSpawn.
	gtScenery addItem: itemToSpawn.

	self shouldBeHandledByAnnouncement.
	elementToSpawn := self createElementFor: itemToSpawn.
	sourceItemElement graph connectTo: elementToSpawn.
	sourceItemElement
		withDeep: [ :each | each graph nodesAlongIncomingEdges asArray ]
		do: [ :each | each addEventHandler: (BlPullHandler new targetElement: elementToSpawn) ].
	container addChild: elementToSpawn.
	^ {itemToSpawn.
		elementToSpawn}
]

{ #category : #initialization }
GtSceneryElement >> spawnNewConnectionWithStencil: aStencil fromElement: sourceItemElement forItem: sourceItem [
	| newItemAndElement newConnection |
	newItemAndElement := self
			spawnItemWithStencil: aStencil
			fromElement: sourceItemElement
			forItem: sourceItem.

	newConnection := self gtScenery
			addConnectionWithStencil: GtSceneryLineStencil new
			from: sourceItem
			to: newItemAndElement first.

	self shouldBeHandledByAnnouncement.
	container
		addChild: (newConnection asElementIn: container forScenery: self gtScenery)
		as: (GtSceneryConnectionId indexed: self gtScenery connections size)
]

{ #category : #announcement }
GtSceneryElement >> subscribe [
	"We want to see when a new item is added to the model.
	NB: This conflicts with the spawnObject: logic in createElementFor:,
	which also generates a new element for an item added."

	self gtScenery announcer
		when: GtSceneryItemAdded
		do: [ :announcement :subscriber | 
			"| newElement |
			newElement := self createElementFor: announcement item.
			self container addChild: newElement" ]
		for: self
]

{ #category : #announcement }
GtSceneryElement >> unsubscribe [
	gtScenery ifNotNil: [ gtScenery announcer unsubscribe: self ]
]
