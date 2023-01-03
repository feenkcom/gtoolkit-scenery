Class {
	#name : #GtScenery,
	#superclass : #BrStencil,
	#instVars : [
		'sceneryItems',
		'connections',
		'items'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtScenery >> addConnection: anObject from: item1 to: item2 [ 
	| connection |
	connection := GtSceneryConnection new 
		stencil: anObject;
		from: item1;
		to: item2.
	connections add: connection.
	^ connection
]

{ #category : #accessing }
GtScenery >> addItem: anItemStencil [
	| item |
	item := GtSceneryItem new stencil: anItemStencil.
	items add: item.
	^ item
]

{ #category : #accessing }
GtScenery >> addSceneryItem: anItem [ 
	sceneryItems add: anItem
]

{ #category : #accessing }
GtScenery >> connections [
	^ connections
]

{ #category : #accessing }
GtScenery >> create [
	| container |
	container := BlCanvassableElement new
			background: Color white;
			constraintsDo: [ :c | 
				c vertical matchParent.
				c horizontal matchParent ].
	items do: [ :each | 
		container addChild: (each asElementIn: container forScenery: self) ].
	connections do: [ :each | 
		container addChild: (each asElementIn: container forScenery: self) ].

	^ container
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
GtScenery >> gtSceneryItemsFor: aView [ 
	<gtView>
	^ aView list 
		title: 'Items';
		items: [ sceneryItems ]
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
GtScenery >> storeOn: aStream [
	aStream nextPutAll: '| scenery '.
	items doWithIndex: [:eachItem :i | 
		aStream nextPutAll: 'item', i asString].	
	aStream
		nextPutAll: '|';
		cr;
		nextPutAll: 'scenery := ';
		nextPutAll: self class name;
		nextPutAll: ' new';
		cr.
	items doWithIndex: [:eachItem :i |
		aStream nextPutAll: 'item', i asString, ' := scenery addItem: '.
		"eachItem storeOn: aStream"
		]
]
