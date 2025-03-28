"
I am an element for rendering a {{gtClass:name=GtScenery}}. I render the scenery using a `container` which is an instance of {{gtClass:name=BlCanvassableElement}}. 

By default, autoscaling is initially turned on, so the scenery will be displayed to take up the entire visible canvas.
"
Class {
	#name : #GtSceneryElement,
	#superclass : #BlElement,
	#instVars : [
		'gtScenery',
		'container',
		'currentItemStencil'
	],
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #'item menu' }
GtSceneryElement >> addNewItemFor: anItemStencilClass at: position [
	"Add a new item at the position of the triggering event."

	<tag: #shouldBeHandledByAnnouncement>
	| item newElement |
	item := anItemStencilClass new asItem.
	item position: position.
	self gtScenery addItem: item.	"Handle rest by announcement ..."

	newElement := self createItemElementFor: item.
	self container addChild: newElement.
	self updateItemIds.
	^ newElement
]

{ #category : #'connection menu' }
GtSceneryElement >> buildConnectionContextMenuForItem: aConnection andElement: aConnectionElement [
	<tag: #shouldBeHandledByAnnouncement>
	<tag: #sceneryContextMenu>
	| menuItems |
	menuItems := BrMenuItems new
			id: #'gtScenery-connection-menu';
			yourself.
	menuItems
		addItemLabel: 'Inspect stencil'
		action: [ :elt | self inspectConnection: aConnection forElement: aConnectionElement ].
	menuItems
		addItemLabel: 'Inspect connection'
		action: [ :elt | self inspectConnectionWrapper: aConnection forElement: aConnectionElement ].

	aConnection
		updateConnectionContextMenuItems: menuItems
		forSceneryElement: self
		andConnectionElement: aConnectionElement. 

	menuItems
		addItemLabel: 'Delete connection'
		action: [ :elt | 
			self gtScenery removeConnection: aConnection.	"Next should be handled by announcement:"
			self removeConnectionElement: aConnectionElement ].
	^ menuItems
]

{ #category : #'item menu' }
GtSceneryElement >> buildItemContextMenuForItem: anItem andElement: anItemElement [
	<tag: #shouldBeHandledByAnnouncement>
	<tag: #sceneryContextMenu>
	<todo: '
	This should replace GtSceneryElement>>#itemContextMenuForItem:andElement:
	Here we want extensible submenus. Instead of just listing the items for the Menu aptitude, we can explicitly create a nested menu.
	We also want items themselves to offer new submenus ....'>
	| menuItems |
	menuItems := BrMenuItems new
			id: #'gtScenery-item-menu';
			yourself.
	menuItems
		addItemLabel: 'Inspect stencil'
		action: [ :elt | self inspectItem: anItem forElement: anItemElement ].
	menuItems
		addItemLabel: 'Inspect item'
		action: [ :elt | self inspectItemWrapper: anItem forElement: anItemElement ].
	menuItems
		addItemLabel: 'Clone item'
		action: [ :elt | 
			self
				spawnItemWithStencil: anItem stencil copy
				fromElement: anItemElement
				forItem: anItem ].
	anItem
		updateItemContextMenuItems: menuItems
		forSceneryElement: self
		andItemElement: anItemElement.

	menuItems
		addItemLabel: 'Delete item'
		action: [ :elt | 
			self gtScenery removeItemWithConnections: anItem.	"Next should be handled by announcement:"
			self removeItemElementWithConnections: anItemElement ].
	^ menuItems
]

{ #category : #initialization }
GtSceneryElement >> buildItemCreationSubMenuForContext: aContext [
	"Add a submenu action for each ItemStencil class."

	<tag: #sceneryContextMenu>
	| subMenuItems |
	subMenuItems := BrMenuItems new.
	(GtSceneryDraggableItem allSubclasses
		select: [ :c | c class includesSelector: #itemCreationSubmenuLabel ])
		do: [ :itemStencilClass | 
			subMenuItems
				addItemLabel: itemStencilClass itemCreationSubmenuLabel
				action: [ aContext
						childrenPositionDo: [ :aPoint | 
							self addNewItemFor: itemStencilClass at: aPoint.
							self currentItemStencil: itemStencilClass ]
						ifAbsentDo: [ 0 @ 0 ] ] ].
	^ subMenuItems
]

{ #category : #initialization }
GtSceneryElement >> buildSceneryContextMenuForContext: aContext [
	"Build scenery context menu items.
	aContext is a BrMenuInitialContext instance."

	<tag: #sceneryContextMenu>
	| menuItems subMenuItems |
	menuItems := BrMenuItems new
			id: #'gtScenery-context-menu';
			yourself.
	menuItems
		addItemLabel: 'Inspect Scenery'
		action: [ :elt | elt phlow spawnObject: self gtScenery ].
	menuItems
		addItemLabel: 'Add item here'
		action: [ aContext
				childrenPositionDo: [ :aPoint | self addNewItemFor: self currentItemStencil at: aPoint ]
				ifAbsentDo: [ 0 @ 0 ] ].
	subMenuItems := self buildItemCreationSubMenuForContext: aContext.
	menuItems
		addItem: (BrMenuSubmenuItem new
				label: 'Add item';
				submenu: subMenuItems).
	menuItems addItemLabel: 'Redisplay' action: [ self redisplay ].
	menuItems
		addItemLabel: 'FAQ'
		action: [ :e | 
			e phlow
				spawnObject: (self gtScenery database pageNamed: 'Scenery FAQ') asPagePhlowTool ].
	^ menuItems
]

{ #category : #accessing }
GtSceneryElement >> container [
	^ container
]

{ #category : #accessing }
GtSceneryElement >> createConnectionElementFor: aConnection [
	<tag: #sceneryListeners>
	| connectionElement |
	connectionElement := aConnection asElementIn: self.

	connectionElement when: GtPhlowObjectToSelect do: [ :e | e consumed: true ].

	connectionElement
		addAptitude: (BrStyleCommonAptitude new
				default: [ :elt | elt border: (BlBorder paint: Color black width: 2) ];
				hovered: [ :elt | elt border: (BlBorder paint: Color blue width: 2) ]).

	connectionElement
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
				menu: [ self
						buildConnectionContextMenuForItem: aConnection
						andElement: connectionElement ]).

	^ connectionElement
]

{ #category : #accessing }
GtSceneryElement >> createItemElementFor: anItem [
	"Instantiate the given item as an element, adding scenery-specific listeners."

	<tag: #sceneryListeners>
	| itemElement |
	itemElement := anItem asElementIn: self.
	itemElement when: GtPhlowObjectToSelect do: [ :e | e consumed: true ].
	itemElement
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
				menu: [ self buildItemContextMenuForItem: anItem andElement: itemElement ]).
	itemElement
		when: GtPhlowObjectToSpawn
		do: [ :e | 
			e consumed: true.
			self
				spawnItemWithStencil: (GtSceneryInspectorStencil new target: [ e object ])
				fromElement: itemElement
				forItem: anItem ].
	itemElement
		when: BlElementPositionChangedEvent
		do: [ :e | anItem position: e currentTarget position ].
	itemElement
		when: BlElementExtentChangedEvent
		do: [ :e | anItem extent: e currentTarget extent ].
	^ itemElement
]

{ #category : #accessing }
GtSceneryElement >> currentItemStencil [
	"Cache forthe most recently instantiated item, so double-clicking will default to this stencil."
	^ currentItemStencil
		ifNil: [ currentItemStencil := self defaultItemStencilClass ]
]

{ #category : #accessing }
GtSceneryElement >> currentItemStencil: anObject [
	currentItemStencil := anObject
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
				label: 'Zoom in' asRopedText;
				action: [ self container zoomIn ] ];
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons zoomout asElement;
				label: 'Zoom out' asRopedText;
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
				label: 'Redisplay' asRopedText;
				action: [ self redisplay ] ]
]

{ #category : #accessing }
GtSceneryElement >> gtScenery [
	^ gtScenery
]

{ #category : #accessing }
GtSceneryElement >> gtScenery: aScenery [
	| itemElement connectionElement |
	self unsubscribe.
	gtScenery := aScenery.
	gtScenery items
		withIndexDo: [ :eachItem :index | 
			itemElement := self createItemElementFor: eachItem.
			container addChild: itemElement ].
	gtScenery connections
		withIndexDo: [ :eachConnection :index | 
			connectionElement := self createConnectionElementFor: eachConnection.
			container addChild: connectionElement ].
	self updateItemIds.
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
	<tag: #sceneryListeners>
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
		do: [ :evt | self addNewItemFor: self currentItemStencil at: evt childrenPosition ].
	self container
		aptitude: (BrGlamorousWithExplicitContextMenuAptitude new
				stencil: [ :aContext | 
					BrMenuExplicitHandle new
						menu: (self buildSceneryContextMenuForContext: aContext) ])
]

{ #category : #'connection menu' }
GtSceneryElement >> inspectConnection: aConnection forElement: aConnectionElement [
	^ aConnectionElement fireEvent: (GtSceneryObjectToSpawn new object: aConnection stencil)
]

{ #category : #'connection menu' }
GtSceneryElement >> inspectConnectionWrapper: aConnection forElement: aConnectionElement [
	^ aConnectionElement fireEvent: (GtSceneryObjectToSpawn new object: aConnection)
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

{ #category : #utility }
GtSceneryElement >> redisplay [
	self container removeChildren.
	self gtScenery: self gtScenery

]

{ #category : #updating }
GtSceneryElement >> removeConnectionElement: aConnectionElement [
	aConnectionElement removeFromParent.
	self updateItemIds
]

{ #category : #updating }
GtSceneryElement >> removeItemElementWithConnections: anItemElement [
	| edges |
	edges := self graph allEdgeChildren
			select: [ :e | 
				e fromAnchor referenceElement = anItemElement
					or: [ e toAnchor referenceElement = anItemElement ] ].
	edges do: [ :e | e removeFromParent ].
	anItemElement removeFromParent.
	self updateItemIds
]

{ #category : #'as yet unclassified' }
GtSceneryElement >> spawnItemWithStencil: aStencil fromElement: sourceItemElement forItem: sourceItem [
	"I spawn a new item within the Scenery and the SceneryElement, starting from a given source item.
	When the source item is dragged, the new item will by dragged with it."
	<tag: #shouldBeHandledByAnnouncement>

	| itemToSpawn elementToSpawn |
	itemToSpawn := aStencil asItem.
	itemToSpawn position: sourceItemElement bounds topRight + (40 @ 0).

	sourceItem addLinkTo: itemToSpawn.
	gtScenery addItem: itemToSpawn.
	
	elementToSpawn := self createItemElementFor: itemToSpawn.
	sourceItemElement graph connectTo: elementToSpawn.
	sourceItemElement
		withDeep: [ :each | each graph nodesAlongIncomingEdges asArray ]
		do: [ :each | each addEventHandler: (BlPullHandler new targetElement: elementToSpawn) ].
	container addChild: elementToSpawn.
	^ elementToSpawn
]

{ #category : #initialization }
GtSceneryElement >> spawnNewConnectionWithStencil: aStencil fromElement: sourceItemElement forItem: sourceItem [
	<tag: #shouldBeHandledByAnnouncement>
	| newItemElement newConnection newConnectionElement |
	newItemElement := self
			spawnItemWithStencil: aStencil
			fromElement: sourceItemElement
			forItem: sourceItem.

	newConnection := self gtScenery
			addConnectionWithStencil: GtSceneryStraightArcStencil new
			from: sourceItem
			to: newItemElement graph model.

	"newConnectionElement := newConnection
			asElementIn: container
			forScenery: self gtScenery."
	newConnectionElement := self createConnectionElementFor: newConnection.

	container
		addChild: newConnectionElement
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

{ #category : #updating }
GtSceneryElement >> updateItemIds [
	"After an insertion or a deletion of an item or a connection, all the ids may change.
	NB: eventually each element type might have its own index ids."
	self graph allNodeChildren
		withIndexDo: [ :eachItem :index | eachItem id: (GtSceneryItemId indexed: index) ].
	self graph allEdgeChildren
		withIndexDo: [ :eachConnection :index | eachConnection id: (GtSceneryConnectionId indexed: index) ]
]
