"
I am a stencil for a scene containing graphical items and possibly connections between them.
My items are instances of {{gtClass:name=GtSceneryItem}}, each of which wraps a stencil for a different kind of item.
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
		'announcer'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtScenery >> addConnectionWithStencil: anObject from: item1 to: item2 [ 
	| connection |
	connection := GtSceneryConnection new 
		stencil: anObject;
		from: item1;
		to: item2.
	connections add: connection.
	^ connection
]

{ #category : #accessing }
GtScenery >> addItem: anItem [
	items add: anItem.
	self announce: (GtSceneryItemAdded new item: anItem).
	^ anItem
]

{ #category : #accessing }
GtScenery >> addItemForStencil: anItemStencil [
	"So far not used anywhere?"
	
	"| item |
	item := GtSceneryItem new stencil: anItemStencil."
	
	^ self addItem: (GtSceneryItem new stencil: anItemStencil)
	
	"items add: item.
	self announce: (GtSceneryItemAdded new item: anItemStencil).
	^ item"
]

{ #category : #accessing }
GtScenery >> announce: anAnnouncement [ 
	self announcer announce: anAnnouncement
]

{ #category : #accessing }
GtScenery >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
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

{ #category : #'as yet unclassified' }
GtScenery >> faqPage [
	"An initial FAQ."
	<lePage>
	<gtExample>
	<noTest>
	^ (LePage named: 'Scenery FAQ')
	addSnippet: (LeTextSnippet new
			string: '*Q What is a scenery?*';
			addSnippet: (LeTextSnippet new
					string: 'A *Scenery* is a diagram consisting of a number of *items* and possible *connections* between them.';
					yourself);
			yourself);
	addSnippet: (LeTextSnippet new
			string: '*Q How do I create a scenery?*';
			addSnippet: (LeTextSnippet new
					string: 'To create a new scenery, instantiate {{gtClass:name=GtScenery}}:';
					yourself);
			addSnippet: (LePharoSnippet new
					code: 'GtScenery new';
					yourself);
			yourself);
	addSnippet: (LeTextSnippet new
			string: '*Q How do I edit a scenery?*';
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
			string: '*Q How do I save a scenery I have edited?*';
			addSnippet: (LeTextSnippet new
					string: 'To save a scenery, go to the `Store on` view and copy-paste the code to a method or to a Pharo snippet. See {{gtClass:name=GtSceneryEditedExamples}} for some examples.';
					yourself);
			yourself);
	addSnippet: (LeTextSnippet new
			string: '*Q Why is the image auto-zooming as I edit it?*';
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
			string: '';
			yourself);
	addSnippet: (LeTextSnippet new
			string: '*Caveat*';
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
							-> [ :e | e phlow spawnObject: (self database pageNamed: 'Scenery FAQ') asPhlowTool ]};
				yourself ]
]

{ #category : #accessing }
GtScenery >> gtConnectionsFor: aView [
	<gtView>
	^ aView list
		title: 'Connections';
		priority: 12;
		items: [ connections ];
		actionUpdateButton
]

{ #category : #action }
GtScenery >> gtDatabaseFor: aView [
	"Suppress the database view from TDatabaseHolder"

	<gtView>
	^ aView empty
]

{ #category : #accessing }
GtScenery >> gtItemsFor: aView [ 
	<gtView>
	^ aView list 
		title: 'Items';
		priority: 10;
		items: [ items ];
		actionUpdateButton
]

{ #category : #accessing }
GtScenery >> initialize [
	super initialize.
	"self initializeDatabase."
	items := OrderedCollection new .
	connections := OrderedCollection new
]

{ #category : #accessing }
GtScenery >> items [
	^ items
]

{ #category : #accessing }
GtScenery >> items: anObject [
	items := anObject
]

{ #category : #updating }
GtScenery >> removeConnection: aConnection [
	self connections remove: aConnection.
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
	self connections
		do: [ :c | (c from == anItem or: c to == anItem) 
			ifTrue: [ self removeConnection: c ] ].
	self items remove: anItem.
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
