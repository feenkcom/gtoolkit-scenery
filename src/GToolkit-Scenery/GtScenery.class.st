"
I am a stencil for a scene containing graphical items and possibly connections between them.
My items are instances of `GtSceneryItem`, each of which wraps a stencil for a different kind of item.
My items may be explicitly positioned or resized.
"
Class {
	#name : #GtScenery,
	#superclass : #BrStencil,
	#traits : 'TGtSceneryShared + TDatabaseHolder',
	#classTraits : 'TGtSceneryShared classTrait + TDatabaseHolder classTrait',
	#instVars : [
		'connections',
		'items',
		'announcer',
		'onceLayout'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #connecting }
GtScenery >> addConnectionFrom: anItem1 to: anItem2 [
	"Let the item decide the connection stencil to use."

	^ self addConnectionWithStencil: (anItem1 stencilForConnectionWith: anItem2) from: anItem1 to: anItem2
]

{ #category : #accessing }
GtScenery >> addConnectionWithStencil: aStencil from: anItem1 to: anItem2 [
	"Explicitly set the stencil. Used by GtScenery>>#storeOn:"

	| connection |
	connection := GtSceneryConnection new
			stencil: aStencil;
			from: anItem1;
			to: anItem2.
	connections add: connection.
	self announce: (GtSceneryConnectionAdded new connection: connection).
	^ connection
]

{ #category : #accessing }
GtScenery >> addItem: anItem [
	"Not a great name. Too  many other methods in the system with the same selector."

	items add: anItem.
	self announce: (GtSceneryItemAdded new item: anItem).
	^ anItem
]

{ #category : #accessing }
GtScenery >> addItemForStencil: anItemStencil [
	"So far not used anywhere?"

	^ self addItem: (GtSceneryItem new stencil: anItemStencil)
]

{ #category : #accessing }
GtScenery >> addScenery: otherScenery [
	"Experimental! Probably just useful for testing.
	TODO: add the new items above the existing ones."

	| space delta |
	space := -50.
	delta := (self boundingBox left - otherScenery boundingBox left)
			@ (space + self boundingBox top - otherScenery boundingBox bottom).

	otherScenery items
		do: [ :item | 
			item position: item position + delta.
			self addItem: item ].
	otherScenery connections
		do: [ :connection | self addConnectionFrom: connection from to: connection to ].
	^ self
]

{ #category : #announcements }
GtScenery >> announce: anAnnouncement [ 
	self announcer announce: anAnnouncement
]

{ #category : #accessing }
GtScenery >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GtScenery >> boundingBox [
	^ Rectangle
		encompassing: (self items collect: #position)
				, (self items collect: [ :each | each position + each extent ])
]

{ #category : #accessing }
GtScenery >> connections [
	^ connections
]

{ #category : #accessing }
GtScenery >> connections: anObject [
	connections := anObject
]

{ #category : #accessing }
GtScenery >> create [
	^ GtSceneryElement new
		gtScenery: self
]

{ #category : #accessing }
GtScenery >> defaultOnceLayout [
	"If nil, don't apply any layout."
	^ nil
]

{ #category : #page }
GtScenery >> faqImplementationPage [
	<lePage>
	<gtExample>
	<noTest>
	^ (LePage named: 'Scenery Implementation FAQ')
		addSnippet: (LeTextSnippet new
				string: '';
				yourself);
		addSnippet: (LeTextSnippet new
				string: '***Q What are the key classes?***';
				addSnippet: (LeTextSnippet new
						string: 'The key model class is {{gtClass:name=GtScenery}}. A scenery instance holds *items* and *connections*, which are instances of {{gtClass:name=GtSceneryItem}} and {{gtClass:name=GtSceneryConnection}}. Each of these in turn holds a *stencil*, an instance of a subclass of {{gtClass:name=GtSceneryEntityStencil}}, to create the actual view elements.';
						yourself);
				addSnippet: (LeTextSnippet new
						string: 'Item stencils are all subclasses of {{gtClass:name=GtSceneryDraggableItemStencil}}. ';
						yourself);
				addSnippet: (LeTextSnippet new
						string: 'The key connection stencils are {{gtClass:name=GtSceneryLineStencil}} and {{gtClass:name=GtSceneryParabollaArcStencil}}, for straight and curvable arrows.';
						yourself);
				addSnippet: (LeExampleSnippet new
						exampleBehaviorName: 'GtSceneryExplanationExamples';
						exampleSelector: #keyClassesUMLScenery;
						noCode: true;
						previewShowSelector: #gtLiveFor:;
						previewHeight: 500);
				yourself);
		addSnippet: (LeTextSnippet new
				string: '***Q How to add a new item type?***';
				addSnippet: (LeTextSnippet new
						string: 'Define a stencil as subclass of {{gtClass:name=GtSceneryDraggableItemStencil}}. Implement its `#create` method to create its view element. ';
						yourself);
				addSnippet: (LeTextSnippet new
						string: 'Optionally define a dedicated class for the view.';
						yourself);
				addSnippet: (LeTextSnippet new
						string: 'Implement `#storeOn:` to generate an executable storeString that, when evaluated, will produce a clone (used by {{gtMethod:name=GtScenery>>#storeOn:}}.';
						yourself);
				addSnippet: (LeTextSnippet new
						string: 'Implement `#itemCreationSubmenuLabel` so it will appear in the scenery''s item creation submenu.';
						yourself);
				addSnippet: (LeTextSnippet new
						string: 'Optionally override {{gtMethod:name=GtSceneryEntityStencil>>#handleDoubleClickForItem:andElement:inSceneryElement:}} to define the behavior when it is double-clicked.';
						yourself);
				addSnippet: (LeTextSnippet new
						string: 'Optionally override {{gtMethod:name=GtSceneryEntityStencil>>#updateContextMenuItems:forSceneryElement:andChildElement:}} to provide additional submenu items to the item''s context menu.';
						yourself);
				yourself);
		addSnippet: (LeTextSnippet new
				string: '***Q Where are context menu items defined for sceneries, items and connections?***';
				addSnippet: (LeTextSnippet new
						string: 'They are mostly initialized in {{gtClass:name=GtSceneryElement}}. See the `build*` methods, such as {{gtMethod:name=GtSceneryElement>>#buildSceneryContextMenuForContext:}} and {{gtMethod:name=GtSceneryElement>>#buildItemContextMenuForItem:andElement:}}.';
						yourself);
				addSnippet: (LeTextSnippet new
						string: 'Item and connection stencils can add their own item-specific submenus by overriding {{gtMethod:name=GtSceneryEntityStencil>>#updateContextMenuItems:forSceneryElement:andChildElement:}}';
						yourself);
				yourself);
		addSnippet: (LeTextSnippet new
				string: '***Q Where are keyboard shortcuts defined?***';
				addSnippet: (LeTextSnippet new
						string: 'They are defined by default in {{gtMethod:name=BrEditableLabel>>#defaultLabelShortcuts}}, and extended in {{gtMethod:name=GtSceneryTextLabelElement>>#defaultLabelShortcuts}}. ';
						yourself);
				yourself);
		addSnippet: (LeTextSnippet new
				string: '';
				yourself);
		yourself
]

{ #category : #page }
GtScenery >> faqPage [
	"An initial FAQ."
	<lePage>
	<gtExample>
	<noTest>
	^ (LePage named: 'Scenery FAQ')
	addSnippet: (LeTextSnippet new
			string: '';
			yourself);
	addSnippet: (LeTextSnippet new
			string: '***Q What is a scenery?***';
			addSnippet: (LeTextSnippet new
					string: 'A *Scenery* is a diagram consisting of a number of *items* and possible *connections* between them.';
					yourself);
			yourself);
	addSnippet: (LeTextSnippet new
			string: '***Q How do I create a scenery?***';
			addSnippet: (LeTextSnippet new
					string: 'To create a new scenery, instantiate {{gtClass:name=GtScenery}}:';
					yourself);
			addSnippet: (LePharoSnippet new
					code: 'GtScenery new';
					yourself);
			yourself);
	addSnippet: (LeTextSnippet new
			string: '***Q How do I edit a scenery?***';
			addSnippet: (LeTextSnippet new
					string: 'You can edit a scenery interactively in the *Live* view.';
					addSnippet: (LeTextSnippet new
							string: '• Double-click on the canvas to add a new item (mindmap bubble by default)';
							yourself);
					addSnippet: (LeTextSnippet new
							string: '• Primary-click on the canvas to open the context menu to add other types of items (inspectors, picture files, shapes etc)';
							yourself);
					addSnippet: (LeTextSnippet new
							string: '• Primary-click on an item to open its context menu (inspect the item, clone it, delete it etc.)';
							yourself);
					addSnippet: (LeTextSnippet new
							string: '• Control-click and drag from one item to another to establish a connection.';
							yourself);
					yourself);
			yourself);
	addSnippet: (LeTextSnippet new
			string: '***Q How do I save a scenery I have edited?***';
			addSnippet: (LeTextSnippet new
					string: 'To save a scenery, go to the `Store on` view and copy-paste the code to a method or to a Pharo snippet. See {{gtClass:name=GtSceneryEditedExamples}} for some examples.';
					yourself);
			yourself);
	addSnippet: (LeTextSnippet new
			string: '***Q Why is the image auto-zooming as I edit it?***';
			addSnippet: (LeTextSnippet new
					string: 'If you inspect a saved scenery, the *Live* view will be auto-zoomed by default. ';
					yourself);
			addSnippet: (LeTextSnippet new
					string: 'Click the *Zoom in*, *Zoom out* or *Zoom to actual size* buttons to leave auto-zoom mode. ';
					yourself);
			addSnippet: (LeTextSnippet new
					string: 'Click *Zoom to fit* to switch back to auto-zoom mode.';
					yourself);
			yourself);
	addSnippet: (LeTextSnippet new
			string: '***Q How can I extend sceneries with my own types of items and connections?***';
			addSnippet: (LeTextSnippet new
					string: 'See the [[Scenery Implementation FAQ]].';
					yourself);
			yourself);
	addSnippet: (LeTextSnippet new
			string: '';
			yourself);
	addSnippet: (LeTextSnippet new
			string: '***Caveat***';
			addSnippet: (LeTextSnippet new
					string: 'This is a work in progress. Many needed features are not yet implemented.';
					yourself);
			yourself);
	yourself
]

{ #category : #action }
GtScenery >> gtActionMenuFor: anAction [
	"Eventually add a nested menu of help pages."

	<gtAction>
	^ anAction dropdown
		priority: 100;
		tooltip: 'Help';
		icon: BrGlamorousVectorIcons hamburger;
		content: [ :aButton | 
			BrGlamorousSimpleContextMenuContent new
				items: {'Scenery FAQ'
							-> [ :e | e phlow spawnObject: (self database pageNamed: 'Scenery FAQ') asPagePhlowTool ].
						'Implementation FAQ'
							-> [ :e | 
								e phlow
									spawnObject: (self database pageNamed: 'Scenery Implementation FAQ') asPagePhlowTool ]};
				yourself ]
]

{ #category : #accessing }
GtScenery >> gtConnectionsFor: aView [
"	<gtView>
	^ aView list
		title: 'Connections';
		priority: 12;
		items: [ connections ];
		actionUpdateButton
		
		
		gtItemsFor: aView"
	<gtView>
	^ aView columnedList
		title: 'Connections';
		priority: 12;
		items: [ self connections ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Connection' text: [ :each | each gtDisplayString ]
		width: 200;
		column: 'Stencil' text: [ :each | each stencil gtDisplayString ]
		width: 200;
		column: 'Report'
			text: [ :each | each reportString ]
			width: 200;
		actionUpdateButtonTooltip: 'Update item list'
]

{ #category : #action }
GtScenery >> gtDatabaseFor: aView [
	"Suppress the database view from TDatabaseHolder"

	<gtView>
	^ aView empty
]

{ #category : #accessing }
GtScenery >> gtIteStencilsFor: aView [
	"<gtView>"
	^ aView columnedList
		title: 'Item Stencils';
		priority: 11;
		items: [ self items collect: #stencil ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Stencil'
			text: [ :each | each gtDisplayString ]
			width: 300;
		actionUpdateButtonTooltip: 'Update item list'
]

{ #category : #accessing }
GtScenery >> gtItemsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Items';
		priority: 10;
		items: [ self items ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Item'
			text: [ :each | each gtDisplayString ]
			width: 200;
		column: 'Stencil'
			text: [ :each | each stencil gtDisplayString ]
			width: 200;
		column: '# Incoming'
			text: [ :each | each incomingLinks size ]
			width: 80;
		column: '#Outgoing'
			text: [ :each | each outgoingLinks size ]
			width: 80;
		column: '#Report'
			text: [ :each | each reportString ]
			width: 200;
		actionUpdateButtonTooltip: 'Update item list'
]

{ #category : #views }
GtScenery >> gtReportFor: aView [
	<gtView>
	self isValid ifTrue: [ ^ aView empty ].
	^ aView columnedList
		title: 'Report';
		priority: 20;
		items: [ self invalidItemsAndConnections ];
		actionUpdateButtonTooltip: 'Update item list';
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Item' text: [ :eachItem | eachItem reportString ]
]

{ #category : #accessing }
GtScenery >> initialize [
	super initialize.
	"self initializeDatabase."
	items := OrderedCollection new .
	connections := OrderedCollection new.
	onceLayout := self defaultOnceLayout
]

{ #category : #accessing }
GtScenery >> invalidItemsAndConnections [
	^ (self items reject: #isValid) , (self connections reject: #isValid)
]

{ #category : #validity }
GtScenery >> isInvalid [
	^ self isValid not
]

{ #category : #validity }
GtScenery >> isValid [
	self items do: [ :each | each isValid ifFalse: [ ^ false ] ].
	self connections do: [ :each | each isValid ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #accessing }
GtScenery >> items [
	^ items
]

{ #category : #accessing }
GtScenery >> items: anObject [
	items := anObject
]

{ #category : #accessing }
GtScenery >> onceLayout [
	^ onceLayout
]

{ #category : #accessing }
GtScenery >> onceLayout: aLayout [
	"NB: A layout instance, not the class."

	onceLayout := aLayout
]

{ #category : #updating }
GtScenery >> removeConnection: aConnection [
	self connections remove: aConnection.
	self announce: (GtSceneryConnectionDeleted new connection: aConnection).
	^ aConnection
]

{ #category : #updating }
GtScenery >> removeItem: anItem [
	"Just removes an item, but not its connections."
	self  deprecated: 'Use removeItemWithConnections: instead'.
	items remove: anItem.
	^ anItem
]

{ #category : #updating }
GtScenery >> removeItemWithConnections: anItem [
	| connectionsToRemove |
	"NB: first compute the connections, *then* remove them!"
	connectionsToRemove := self connections
			select: [ :c | c from == anItem or: c to == anItem ].
	connectionsToRemove do: [ :c | self removeConnection: c ].
	self items remove: anItem.
	self announce: (GtSceneryItemDeleted new item: anItem).
	^ anItem
]

{ #category : #accessing }
GtScenery >> storeOn: aStream [
	aStream nextPutAll: '| scenery'.
	items doWithIndex: [ :eachItem :i | aStream nextPutAll: ' item' , i asString ].
	aStream
		nextPutAll: ' |';
		cr;
		nextPutAll: 'scenery := ';
		nextPutAll: self class name;
		nextPutAll: ' new.';
		cr.
	items
		doWithIndex: [ :eachItem :i | 
			aStream
				nextPutAll: 'item' , i asString , ' := scenery addItem: (('.
			eachItem stencil storeOn: aStream.
			aStream nextPutAll: ') asItem).';
				cr.
			aStream
				nextPutAll: 'item' , i asString , ' position: ' , eachItem position asString , '.';
				cr.
			aStream
				nextPutAll: 'item' , i asString , ' extent: ' , eachItem extent asString , '.';
				cr ].
	connections
		doWithIndex: [ :eachConnection :i | 
			aStream
				nextPutAll: 'scenery addConnectionWithStencil: ('.
			eachConnection stencil storeOn: aStream.
			aStream
				nextPutAll: ') from: item', (items indexOf: eachConnection from) asString;
				nextPutAll: ' to: item', (items indexOf: eachConnection to) asString, '.';
				cr ].
	aStream nextPutAll: 'scenery'
]
