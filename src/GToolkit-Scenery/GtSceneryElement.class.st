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
	self gtScenery addSceneryItem: newItem.
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
GtSceneryElement >> buildConnectionContextMenuForConnectionElement: aConnectionElement [
	<tag: #sceneryContextMenu>
	| aConnection |
	aConnection := aConnectionElement graph model.
	^ BrMenuItems new
		addItemLabel: 'Inspect stencil'
			action: [ :elt | self inspectConnectionForElement: aConnectionElement ];
		addItemLabel: 'Inspect connection'
			action: [ :elt | self inspectConnectionWrapperForElement: aConnectionElement ];
		addItems: (aConnection stencil
				menuForChildElement: aConnectionElement
				andSceneryElement: self) items;
		addItemLabel: 'Delete connection'
			action: [ :elt | self gtScenery removeConnection: aConnection ];
		yourself
]

{ #category : #menu }
GtSceneryElement >> buildItemContextMenuForItemElement: anItemElement [
	<tag: #sceneryContextMenu>
	<todo: 'Cloning needs to be deep if we really need it.'>
	| anItem |
	anItem := anItemElement graph model.
	^ BrMenuItems new
		id: #'gtScenery-item-menu';
		addItemLabel: 'Inspect stencil'
			action: [ :elt | self inspectItemForElement: anItemElement ];
		"addItemLabel: 'Clone'
			action: [ :elt | self gtScenery spawnNewItemFrom: anItem using: anItem stencil copy ];"
		addItems: (anItem stencil menuForChildElement: anItemElement andSceneryElement: self)
				items;
		addItemLabel: 'Delete'
			action: [ :elt | self gtScenery removeItemWithConnections: anItem ];
		yourself
]

{ #category : #initialization }
GtSceneryElement >> buildSceneryContextMenuForContext: aContext [
	"Build scenery context menu items.
	aContext is a BrMenuInitialContext instance."

	<tag: #sceneryContextMenu>
	| menu |
	menu := BrMenuItems new id: #'gtScenery-context-menu'.
	menu
		addItemLabel: 'Inspect Scenery'
			action: [ :e | e phlow spawnObject: self gtScenery ];
		addItemLabel: 'Add item here'
			action: [ aContext
					childrenPositionDo: [ :aPoint | self addNewItemFor: self currentItemStencil at: aPoint ]
					ifAbsentDo: [ 0 @ 0 ] ];
		addItemLabel: 'Add item'
			submenu: (self itemCreationSubmenuForContext: aContext);
		addItemLabel: 'Zoom'
			submenu: (BrMenuItems new
					addItemLabel: 'Zoom in' action: [ :elt | self container zoomIn ];
					addItemLabel: 'Zoom out' action: [ :elt | self container zoomOut ];
					addItemLabel: 'Zoom to fit' action: [ :elt | self container zoomToFit ];
					addItemLabel: 'Zoom to actual size'
						action: [ :elt | self container zoomToActualSize ];
					yourself);
		addItemLabel: 'Update layout'
			submenu: (self layoutSubmenuForContext: aContext);
		addItemLabel: 'Redisplay' action: [ self redisplay ].
	self gtScenery storeStringMethodName
		ifNotNil: [ menu
				addItemLabel: 'Save to ' , self gtScenery storeStringMethodName
				action: [ :e | 
					e phlow
						spawnTool: (GtMethodCoderTool compiledMethod: self gtScenery storeAsExampleMethod) ] ].
	menu
		addItemLabel: 'FAQ'
		action: [ :e | 
			e phlow
				spawnObject: (self gtScenery helpDatabase pageNamed: 'Scenery FAQ') asPagePhlowTool ].
	^ menu
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
				menu: [ self buildConnectionContextMenuForConnectionElement: connectionElement ]).

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
				menu: [ self buildItemContextMenuForItemElement: itemElement ]).
	itemElement
		when: GtPhlowObjectToSpawn
		do: [ :e | 
			e consumed: true.
			self gtScenery spawnNewItemFrom: anItem for: e object ].
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
GtSceneryElement >> disableBackgroundDragging [
	"Needed for embedded sceneries, so we can drag the scenery instead of the background."

	container
		removeEventHandlersSuchThat: [ :each | each isKindOf: BlCanvassableElementSlideHandler ]
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
				icon: BrGlamorousVectorIcons zoomin asElement;
				label: 'Zoom in' asRopedText;
				action: [ self container zoomIn ] ];
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons zoomout asElement;
				label: 'Zoom out' asRopedText;
				action: [ self container zoomOut ] ];
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons zoomtofit asElement;
				label: 'Zoom to fit' asRopedText;
				action: [ self container zoomToFit ] ];
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons actualsize asElement;
				label: 'Zoom to actual size' asRopedText;
				action: [ self container zoomToActualSize ] ];
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons refresh asElement;
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
	gtScenery backgroundDraggable ifFalse: [ self disableBackgroundDragging ].
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
GtSceneryElement >> inspectConnectionForElement: aConnectionElement [
	| aConnection |
	aConnection := aConnectionElement graph model.
	^ aConnectionElement
		fireEvent: (GtSceneryObjectToSpawn new object: aConnection stencil)
]

{ #category : #menu }
GtSceneryElement >> inspectConnectionWrapperForElement: aConnectionElement [
	| aConnection |
	aConnection := aConnectionElement graph model.
	^ aConnectionElement fireEvent: (GtSceneryObjectToSpawn new object: aConnection)
]

{ #category : #menu }
GtSceneryElement >> inspectItemForElement: anItemElement [
	"Inspect the actual stencil rather than the item wrapper."
	| anItem |
	anItem := anItemElement graph model.
	^ anItemElement fireEvent: (GtSceneryObjectToSpawn new object: anItem stencil)
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
	{#horizontal.
		#west.
		#vertical.
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
		#circle -> ('Circle Layout' -> GtGradCircleLayout new).
		
		#vertical
			-> ('Vertical tree Layout'
					-> (GtGradVerticalTreeLayout new
							levelDistance: 20;
							nodeDistance: 20)).
		
		} asDictionary
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
GtSceneryElement >> removeItemElementWithConnections: anItem [
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
		do: [ :announcement :subscriber | self removeItemElementWithConnections: announcement item ]
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
