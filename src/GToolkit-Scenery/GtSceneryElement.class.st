"
I am an element for rendering a `GtScenery`. I render the scenery using a `container` which is an instance of `BlCanvassableElement`. 

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

{ #category : #updating }
GtSceneryElement >> addConnectionToView: aConnection [
	"I am used in reaction to a GtSceneryConnectionAdded announcement."
	| newConnectionElement |
	newConnectionElement := self createConnectionElementFor: aConnection.
	self container addChild: newConnectionElement.
	self updateItemIds.
	^ newConnectionElement
]

{ #category : #updating }
GtSceneryElement >> addItemToView: anItem [
	"I am used in reaction to a GtSceneryItemAdded announcement."
	| newItemElement |
	newItemElement := self createItemElementFor: anItem.
	self container addChild: newItemElement.
	self updateItemIds.
	^ newItemElement
]

{ #category : #updating }
GtSceneryElement >> addNewItemFor: anItemStencilClass at: aPosition [
	"Add a new item at the position of the triggering event."

	| newItem |
	newItem := anItemStencilClass new asItem.
	newItem position: aPosition.
	self gtScenery addItem: newItem.
	^ newItem
]

{ #category : #'connection menu' }
GtSceneryElement >> buildConnectionContextMenuForItem: aConnection andElement: aConnectionElement [
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
		action: [ :elt | self gtScenery removeConnection: aConnection ].
	^ menuItems
]

{ #category : #'item menu' }
GtSceneryElement >> buildItemContextMenuForItem: anItem andElement: anItemElement [
	<tag: #sceneryContextMenu>
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
		action: [ :elt | self gtScenery removeItemWithConnections: anItem ].
	^ menuItems
]

{ #category : #initialization }
GtSceneryElement >> buildItemCreationSubmenuForContext: aContext [
	"Add a submenu action for each ItemStencil class."

	<tag: #sceneryContextMenu>
	| subMenuItems |
	subMenuItems := BrMenuItems new.
	GtSceneryItemCreationContextMenuCollector new collectMenuItems
		do: [ :spec | 
			subMenuItems
				addItemLabel: spec title
				action: [ aContext
						childrenPositionDo: [ :aPoint | 
							self addNewItemFor: spec snippetClass at: aPoint.
							self currentItemStencil: spec snippetClass ]
						ifAbsentDo: [ 0 @ 0 ] ] ].
	^ subMenuItems
]

{ #category : #initialization }
GtSceneryElement >> buildLayoutSubmenuForContext: aContext [
	"Add a submenu actions for selected layouts."

	<tag: #sceneryContextMenu>
	| submenuItems submenu |
	submenu := BrMenuItems new.

	submenu
		addItemLabel: 'West Layout'
		action: [ self container
				layout: (BlOnceLayout new layout: GtGradWestHierarchicalLayout new) ].
	submenu
		addItemLabel: 'Horizontal tree Layout'
		action: [ self container
				layout: (BlOnceLayout new
						layout: (GtGradHorizontalTreeLayout new
								levelDistance: 50;
								nodeDistance: 20)) ].
	submenu
		addItemLabel: 'Force Layout'
		action: [ self container
				layout: (BlOnceLayout new layout: (GtGraphForceBasedLayout new length: 500)) ].
	submenu
		addItemLabel: 'Circle Layout'
		action: [ self container layout: (BlOnceLayout new layout: GtGradCircleLayout new) ].

	submenuItems := BrMenuItems new.

	(GtGradLayout allSubclasses reject: #isAbstract)
		do: [ :layoutClass | 
			submenuItems
				addItemLabel: layoutClass name
				action: [ self container layout: (BlOnceLayout new layout: layoutClass new) ] ].

	submenu
		addItem: (BrMenuSubmenuItem new
				label: 'GtGrad Layouts';
				submenu: submenuItems).

	submenuItems := BrMenuItems new.
	(GtGraphLayout allSubclasses reject: #isAbstract)
		do: [ :layoutClass | 
			submenuItems
				addItemLabel: layoutClass name
				action: [ self container layout: (BlOnceLayout new layout: layoutClass new) ] ].
	submenu
		addItem: (BrMenuSubmenuItem new
				label: 'GtGraph Layouts';
				submenu: submenuItems).

	^ submenu
]

{ #category : #initialization }
GtSceneryElement >> buildSceneryContextMenuForContext: aContext [
	"Build scenery context menu items.
	aContext is a BrMenuInitialContext instance."

	<tag: #sceneryContextMenu>
	| menuItems itemCreationSubmenu layoutSubmenu |
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
				
	itemCreationSubmenu := self buildItemCreationSubmenuForContext: aContext.
	menuItems
		addItem: (BrMenuSubmenuItem new
				label: 'Add item';
				submenu: itemCreationSubmenu).
				
	layoutSubmenu := self buildLayoutSubmenuForContext: aContext.
	menuItems
		addItem: (BrMenuSubmenuItem new
				label: 'Update layout';
				submenu: layoutSubmenu).
				
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

{ #category : #initialization }
GtSceneryElement >> createConnectionElementFor: aConnection [
	<tag: #sceneryListeners>
	| connectionElement |
	connectionElement := aConnection asElementIn: self.

	connectionElement when: GtPhlowObjectToSelect do: [ :e | e consumed: true ].

	connectionElement
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
				menu: [ self
						buildConnectionContextMenuForItem: aConnection
						andElement: connectionElement ]).

	^ connectionElement
]

{ #category : #accessing }
GtSceneryElement >> createItemElementFor: anItem [
	"Instantiate the given item as an element, adding scenery-specific listeners.
	NB: when items request an object to be spawned — generating a GtPhlowObjectToSpawn announcement
	— this will cause the new object to be spawned as an item *within* the scenery itself.
	GtSceneryObjectToSpawn must be used instead to spawn an inspector within the p hlow of the scenery."

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
		do: [ :e | 
			anItem extent: e currentTarget extent.
			itemElement size: e currentTarget extent ].
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
GtSceneryElement >> elementForConnection: aConnection [
	"Fails with NotFound error if absent."
	^ self graph allEdgeChildren
		detect: [ :element | element graph model == aConnection ]
]

{ #category : #accessing }
GtSceneryElement >> elementForConnection: aConnection ifNone: exceptionBlock [
	^ self graph allEdgeChildren
		detect: [ :element | element graph model == aConnection ]
		ifNone: exceptionBlock
]

{ #category : #accessing }
GtSceneryElement >> elementForItem: anItem [
	"Fails with NotFound error if absent."
	^ self graph allNodeChildren
		detect: [ :element | element graph model == anItem ]
]

{ #category : #accessing }
GtSceneryElement >> elementForItem: anItem ifNone: exceptionBlock [
	^ self graph allNodeChildren
		detect: [ :element | element graph model == anItem ]
		ifNone: exceptionBlock
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

{ #category : #initialization }
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
		
	gtScenery onceLayout
		ifNotNil: [ self container layout: (BlOnceLayout new layout: gtScenery onceLayout) ].

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
GtSceneryElement >> removeConnection: aConnection [
	"If the connection is not found, silently return."

	| aConnectionElement |
	aConnectionElement := self elementForConnection: aConnection ifNone: [ ^ self "halt" ].
	aConnectionElement removeFromParent.
	self updateItemIds
]

{ #category : #updating }
GtSceneryElement >> removeConnectionElement: aConnectionElement [
	self deprecated: 'Use GtSceneryElement>>#removeConnection: instead'.
	aConnectionElement removeFromParent.
	self updateItemIds
]

{ #category : #updating }
GtSceneryElement >> removeItemElementWithConnections: anItemElement [
	| edges |
	self deprecated: 'Use GtSceneryElement>>#removeItemWithConnections: instead'.
	edges := self graph allEdgeChildren
			select: [ :e | 
				e fromAnchor referenceElement = anItemElement
					or: [ e toAnchor referenceElement = anItemElement ] ].
	edges do: [ :e | e removeFromParent ].
	anItemElement removeFromParent.
	self updateItemIds
]

{ #category : #updating }
GtSceneryElement >> removeItemWithConnections: anItem [
	"If the item is not found, silently return."

	| edges itemElement |
	itemElement := self elementForItem: anItem ifNone: [ ^ self ].
	edges := self graph allEdgeChildren
			select: [ :e | 
				e fromAnchor referenceElement = itemElement
					or: [ e toAnchor referenceElement = itemElement ] ].
	edges do: [ :e | e removeFromParent ].
	itemElement removeFromParent.
	self updateItemIds
]

{ #category : #'as yet unclassified' }
GtSceneryElement >> spawnItemWithStencil: aStencil fromElement: sourceItemElement forItem: sourceItem [
	"I spawn a new item within the Scenery. 
	Updates to the view are handled by announcements. (See #subscribe.)"

	| itemToSpawn |
	itemToSpawn := aStencil asItem.
	itemToSpawn position: sourceItemElement bounds topRight + (40 @ 0).

	sourceItem addLinkTo: itemToSpawn.
	gtScenery addItem: itemToSpawn.

	^ itemToSpawn	"Only needed when also connecting to the new item"
]

{ #category : #connecting }
GtSceneryElement >> spawnNewConnectionWithStencil: aStencil fromElement: sourceItemElement forItem: sourceItem [
	| newConnection newItem |
	newItem := self
			spawnItemWithStencil: aStencil
			fromElement: sourceItemElement
			forItem: sourceItem.

	newConnection := self gtScenery addConnectionFrom: sourceItem to: newItem
]

{ #category : #announcements }
GtSceneryElement >> subscribe [
	"We subscribe to all  kinds of updates from the model."

	self gtScenery announcer
		when: GtSceneryItemAdded
		do: [ :announcement :subscriber | self addItemToView: announcement item ]
		for: self.

	self gtScenery announcer
		when: GtSceneryConnectionAdded
		do: [ :announcement :subscriber | self addConnectionToView: announcement connection ]
		for: self.

	self gtScenery announcer
		when: GtSceneryItemDeleted
		do: [ :announcement :subscriber | self removeItemWithConnections: announcement item ]
		for: self.

	self gtScenery announcer
		when: GtSceneryConnectionDeleted
		do: [ :announcement :subscriber | self removeConnection: announcement connection ]
		for: self.
]

{ #category : #announcements }
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
