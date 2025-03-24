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

{ #category : #action }
GtScenery >> gtActionMenuFor: anAction [
	<gtAction>
	^ anAction button
		priority: 100;
		tooltip: 'Help';
		icon: BrGlamorousVectorIcons hamburger;
		action: [ :aButton |  ];
		primaryModifierAction: [ :aButton | self gtBrowseFrom: aButton ]
			mouseCursor: BlCopyCursor new
]

{ #category : #accessing }
GtScenery >> gtConnectionsFor: aView [ 
	<gtView>
	^ aView list 
		title: 'Connections';
		items: [ connections ]
]

{ #category : #accessing }
GtScenery >> gtItemsFor: aView [ 
	<gtView>
	^ aView list 
		title: 'Items';
		items: [ items ]
]

{ #category : #'as yet unclassified' }
GtScenery >> helpPage [
	"A help page should be defined here ..."
	<lePage>
	<gtExample>
	<noTest>
	^ (LePage named: 'Scenery exploration example')
	addSnippet: (LeTextSnippet new
			string: 'This is just a placeholder page for a proper initial Help documentation page.';
			yourself);
	addSnippet: (LePharoSnippet new
			code: 'mindmap := GtScenery new';
			yourself);
	addSnippet: (LePharoSnippet new
			code: 'GtSceneryExamples new  mindmapWithTwoSubnodes';
			yourself);
	yourself
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
GtScenery >> removeItem: anItem [
	"Just removes an item, but not its connections."
	self  deprecated: 'Use removeItemWithConnections: instead'.
	items remove: anItem.
	^ anItem
]

{ #category : #updating }
GtScenery >> removeItemWithConnections: anItem [
	| itemConnections |
	itemConnections := self connections
			select: [ :c | c from == anItem or: c to == anItem ].
	itemConnections do: [ :c | self connections remove: c ].

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
