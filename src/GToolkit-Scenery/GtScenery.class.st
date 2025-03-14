"
I am a stencil for a scene containing graphical items and possibly connections between them.
My items are instances of {{gtClass:name=GtSceneryItem}}, each of which wraps a stencil for a different kind of item.
My items may be explicitly positioned or resized.
"
Class {
	#name : #GtScenery,
	#superclass : #BrStencil,
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
	| item |
	item := GtSceneryItem new stencil: anItemStencil.
	items add: item.
	self announce: (GtSceneryItemAdded new item: anItemStencil).
	^ item
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

{ #category : #accessing }
GtScenery >> gtStoreOnFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Store on';
		styler: (BrRBTextStyler new
				isForWorkspace: true;
				yourself);
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ String streamContents: [ :s | self storeOn: s ] ];
		actionButtonIcon: BrGlamorousVectorIcons playinspect
			tooltip: 'Do it and go'
			action: [ :button | 
				button phlow
					spawnObject: (Smalltalk compiler evaluate: (String streamContents: [ :s | self storeOn: s ])) ];
		actionUpdateButton
]

{ #category : #accessing }
GtScenery >> initialize [
	super initialize.
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

{ #category : #accessing }
GtScenery >> removeItem: anItem [
	items remove: anItem.
	"self announce: (GtSceneryItemAdded new item: anItem)."
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
				nextPutAll: 'item' , i asString , ' := scenery addItem: (GtSceneryItem new stencil: ('.
			eachItem stencil storeOn: aStream.
			aStream nextPutAll: ')).';
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
