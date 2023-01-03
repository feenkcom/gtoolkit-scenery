Class {
	#name : #GtScenery,
	#superclass : #BrStencil,
	#instVars : [
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
GtScenery >> connections [
	^ connections
]

{ #category : #accessing }
GtScenery >> create [
	| container itemElement |
	container := BlCanvassableElement new
			background: Color white;
			constraintsDo: [ :c | 
				c vertical matchParent.
				c horizontal matchParent ].
	items
		do: [ :eachItem | 
			itemElement := eachItem asElementIn: container forScenery: self.
			
			itemElement
				when: BlElementPositionChangedEvent
				do: [ :e | eachItem position: e currentTarget position ].
			itemElement
				when: BlElementExtentChangedEvent
				do: [ :e | eachItem extent: e currentTarget extent ].
			container addChild: itemElement ].
	connections
		do: [ :eachConnection | container addChild: (eachConnection asElementIn: container forScenery: self) ].

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
GtScenery >> gtStoreOnFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Store On';
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
				nextPutAll: 'item' , i asString , ' := scenery addItem: ('.
			eachItem stencil storeOn: aStream.
			aStream nextPutAll: ').';
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
				nextPutAll: 'scenery addConnection: '.
			eachConnection stencil storeOn: aStream.
			aStream
				nextPutAll: ' from: item', (items indexOf: eachConnection from) asString;
				nextPutAll: ' to: item', (items indexOf: eachConnection to) asString, '.';
				cr ].
	aStream nextPutAll: 'scenery'
]
