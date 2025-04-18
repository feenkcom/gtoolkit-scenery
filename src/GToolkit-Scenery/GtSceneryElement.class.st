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

{ #category : #updating }
GtSceneryElement >> applyOnceLayout: aLayout [
	self container layout: (BlOnceLayout new layout: aLayout)
]

{ #category : #updating }
GtSceneryElement >> applyOnceLayoutNamed: key [
	^ self applyOnceLayout: (self onceLayouts at: key) value
]

{ #category : #menu }
GtSceneryElement >> buildConnectionContextMenuForItem: aConnection andElement: aConnectionElement [
	<tag: #sceneryContextMenu>
	^ BrMenuItems new
		addItemLabel: 'Inspect stencil'
			action: [ :elt | self inspectConnection: aConnection forElement: aConnectionElement ];
		addItemLabel: 'Inspect connection'
			action: [ :elt | self inspectConnectionWrapper: aConnection forElement: aConnectionElement ];
		addItems: (aConnection stencil
				menuForChildElement: aConnectionElement
				andSceneryElement: self) items;
		addItemLabel: 'Delete connection'
			action: [ :elt | self gtScenery removeConnection: aConnection ];
		yourself
]

{ #category : #menu }
GtSceneryElement >> buildItemContextMenuForItem: anItem andElement: anItemElement [
	<tag: #sceneryContextMenu>
	^ BrMenuItems new
		id: #'gtScenery-item-menu';
		addItemLabel: 'Inspect stencil'
			action: [ :elt | self inspectItem: anItem forElement: anItemElement ];
		addItemLabel: 'Inspect item'
			action: [ :elt | self inspectItemWrapper: anItem forElement: anItemElement ];
		addItemLabel: 'Clone item'
			action: [ :elt | self gtScenery spawnNewItemFor: anItem using: anItem stencil copy ];
		addItems: (anItem stencil menuForChildElement: anItemElement andSceneryElement: self)
				items;
		addItemLabel: 'Delete item'
			action: [ :elt | self gtScenery removeItemWithConnections: anItem ];
		yourself
]

{ #category : #initialization }
GtSceneryElement >> buildSceneryContextMenuForContext: aContext [
	"Build scenery context menu items.
	aContext is a BrMenuInitialContext instance."

	<tag: #sceneryContextMenu>
	^ BrMenuItems new
		id: #'gtScenery-context-menu';
		addItemLabel: 'Inspect Scenery'
			action: [ :elt | elt phlow spawnObject: self gtScenery ];
		addItemLabel: 'Add item here'
			action: [ aContext
					childrenPositionDo: [ :aPoint | self addNewItemFor: self currentItemStencil at: aPoint ]
					ifAbsentDo: [ 0 @ 0 ] ];
		addItemLabel: 'Add item'
			submenu: (self itemCreationSubmenuForContext: aContext);
		addItemLabel: 'Update layout'
			submenu: (self layoutSubmenuForContext: aContext);
		addItemLabel: 'Redisplay' action: [ self redisplay ];
		addItemLabel: 'FAQ'
			action: [ :e | 
				e phlow
					spawnObject: (self gtScenery database pageNamed: 'Scenery FAQ') asPagePhlowTool ];
		yourself
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
			self gtScenery
				spawnNewItemFor: anItem
				using: (GtSceneryInspectorStencil new target: [ e object ]) ].
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
			self gtScenery spawnConnectionFrom: e fromItem to: e toStencil ].
	self container
		when: BlDoubleClickEvent
		do: [ :evt | self addNewItemFor: self currentItemStencil at: evt childrenPosition ].
	self container
		aptitude: (BrGlamorousWithExplicitContextMenuAptitude new
				stencil: [ :aContext | 
					BrMenuExplicitHandle new
						menu: (self buildSceneryContextMenuForContext: aContext) ])
]

{ #category : #menu }
GtSceneryElement >> inspectConnection: aConnection forElement: aConnectionElement [
	^ aConnectionElement fireEvent: (GtSceneryObjectToSpawn new object: aConnection stencil)
]

{ #category : #menu }
GtSceneryElement >> inspectConnectionWrapper: aConnection forElement: aConnectionElement [
	^ aConnectionElement fireEvent: (GtSceneryObjectToSpawn new object: aConnection)
]

{ #category : #menu }
GtSceneryElement >> inspectItem: anItem forElement: anItemElement [
	"Inspect the actual stencil rather than the item wrapper."
	^ anItemElement fireEvent: (GtSceneryObjectToSpawn new object: anItem stencil)
]

{ #category : #menu }
GtSceneryElement >> inspectItemWrapper: anItem forElement: anItemElement [
	"Inspect the GtSceneryItem instance instead of the stencil it wraps."
	^ anItemElement fireEvent: (GtSceneryObjectToSpawn new object: anItem)
]

{ #category : #menu }
GtSceneryElement >> itemCreationSubmenuForContext: aContext [
	"Add a submenu action for each ItemStencil class."

	<tag: #sceneryContextMenu>
	| menu |
	menu := BrMenuItems new.
	GtSceneryItemCreationContextMenuCollector new collectMenuItems
		do: [ :spec | 
			menu
				addItemLabel: spec title
				action: [ aContext
						childrenPositionDo: [ :aPoint | 
							self addNewItemFor: spec snippetClass at: aPoint.
							self currentItemStencil: spec snippetClass ]
						ifAbsentDo: [ 0 @ 0 ] ] ].
	^ menu
]

{ #category : #menu }
GtSceneryElement >> layoutSubmenuForContext: aContext [
	"Add a submenu actions for selected layouts.
	To add more layouts, update #onceLayouts and add the key below in the desired order."

	<tag: #sceneryContextMenu>
	| menu submenu |
	menu := BrMenuItems new.
	{#west.
		#horizontal.
		#force.
		#circle}
		do: [ :key | 
			| labelLayout |
			labelLayout := self onceLayouts at: key.
			menu
				addItemLabel: labelLayout key
				action: [ self applyOnceLayout: labelLayout value ] ].
	menu
		addItemLabel: 'GtGrad Layouts'
		submenu: [ submenu := BrMenuItems new.
			(GtGradLayout allSubclasses reject: #isAbstract)
				do: [ :layoutClass | 
					submenu
						addItemLabel: layoutClass name
						action: [ self applyOnceLayout: layoutClass new ] ].
			submenu ] value.
	menu
		addItemLabel: 'GtGraph Layouts'
		submenu: [ submenu := BrMenuItems new.
			(GtGraphLayout allSubclasses reject: #isAbstract)
				do: [ :layoutClass | 
					submenu
						addItemLabel: layoutClass name
						action: [ self applyOnceLayout: layoutClass new ] ].
			submenu ] value.
	^ menu
]

{ #category : #menu }
GtSceneryElement >> onceLayouts [
	^ {#west -> ('West Layout' -> GtGradWestHierarchicalLayout new).
		#horizontal
			-> ('Horizontal tree Layout'
					-> (GtGradHorizontalTreeLayout new
							levelDistance: 50;
							nodeDistance: 20)).
		#force
			-> ('Force Layout'
					-> (GtGraphForceBasedLayout new
							charge: -5000;
							length: 100)).
		#circle -> ('Circle Layout' -> GtGradCircleLayout new)} asDictionary
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
