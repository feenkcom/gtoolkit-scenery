"
I am a stencil for a scene containing graphical items and possibly connections between them.
My items are instances of `GtSceneryItem`, each of which wraps a stencil for a different kind of item.
My items may be explicitly positioned or resized.
"
Class {
	#name : #GtScenery,
	#superclass : #BrStencil,
	#traits : 'TGtSceneryShared + TLeInMemoryDatabaseHolder',
	#classTraits : 'TGtSceneryShared classTrait + TLeInMemoryDatabaseHolder classTrait',
	#instVars : [
		'connections',
		'items',
		'announcer',
		'onceLayout',
		'storeStringMethodName',
		'backgroundDraggable',
		'dataFolders'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #comparison }
GtScenery >> = otherScenery [
	self == otherScenery ifTrue: [ ^ true ].
	self class = otherScenery class ifFalse: [ ^ false ].
	self items size = otherScenery items size ifFalse: [ ^ false ].
	self connections size = otherScenery connections size ifFalse: [ ^ false ].
	self items
		withIndexDo: [ :item :idx | item = (otherScenery items at: idx) ifFalse: [ ^ false ] ].
	self connections
		withIndexDo: [ :connection :idx | connection = (otherScenery connections at: idx) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #connecting }
GtScenery >> addConnectionFrom: anItem1 to: anItem2 [
	^ self
		addConnectionFrom: anItem1
		to: anItem2
		labeled: nil
]

{ #category : #connecting }
GtScenery >> addConnectionFrom: anItem1 to: anItem2 labeled: aText [
	"Let the item decide the connection stencil to use."

	^ self
		addConnectionWithStencil: (anItem1
				stencilForConnectionWith: anItem2
				labeled: aText)
		from: anItem1
		to: anItem2
]

{ #category : #accessing }
GtScenery >> addConnectionWithStencil: aStencil from: anItem1 to: anItem2 [
	^ self addConnectionWithStencil: aStencil from: anItem1 to: anItem2   labeled: nil
]

{ #category : #accessing }
GtScenery >> addConnectionWithStencil: aStencil from: anItem1 to: anItem2   labeled: aText [
	"Explicitly set the stencil. Used by GtScenery>>#storeOn:"

	| connection |
	connection := GtSceneryConnection new
			stencil: aStencil;
			from: anItem1;
			to: anItem2.
	aStencil isSceneryStencil ifTrue: [ aStencil gtScenery: self ].
	connections add: connection.
	anItem1 addLinkTo: anItem2.
	self announce: (GtSceneryConnectionAdded new connection: connection).
	^ connection
]

{ #category : #accessing }
GtScenery >> addItem: anItem [
	"Not a great name. Too  many other methods in the system with the same selector."

	self
		deprecated: 'Use addSceneryItem: instead'
		transformWith: '`@receiver addItem: `@argument' -> '`@receiver addSceneryItem: `@argument'.

	^ self addSceneryItem: anItem
]

{ #category : #accessing }
GtScenery >> addItemForStencil: anItemStencil [
	"So far not used anywhere?"

	^ self addSceneryItem: (GtSceneryItem new stencil: anItemStencil)
]

{ #category : #accessing }
GtScenery >> addScenery: otherScenery [
	"Experimental! Probably just useful for testing.
	Adds all the items and connections of another scenery above the bounding box of this one."

	| spacing delta |
	otherScenery items ifEmpty: [ ^ self ].
	spacing := 50.
	delta := (self boundingBox left - otherScenery boundingBox left)
			@ (self boundingBox top - otherScenery boundingBox bottom - spacing).

	otherScenery items
		do: [ :item | 
			item position: item position + delta.
			self addSceneryItem: item ].
	otherScenery connections
		do: [ :connection | self addConnectionFrom: connection from to: connection to ].
	^ self
]

{ #category : #storing }
GtScenery >> addSceneryFromStoreStringMethod [
	"This could be used to add the scenery items after setting the storeStringMethodName.
	Should not be used in the setting as it will lead to an infinite recursion."
	| method |
	"method := self storeStringMethodFor: aMethodName."
	method := self storeStringMethod.
	method
		ifNotNil: [ | storedScenery |
			storedScenery := method methodClass new perform: method selector.
			self addScenery: storedScenery ]
]

{ #category : #accessing }
GtScenery >> addSceneryItem: anItem [
	items add: anItem.
	anItem stencil isSceneryStencil ifTrue: [ anItem stencil gtScenery: self ].
	self announce: (GtSceneryItemAdded new item: anItem).
	^ anItem
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
GtScenery >> backgroundDraggable [
	^ backgroundDraggable ifNil: [ backgroundDraggable := true ]
]

{ #category : #accessing }
GtScenery >> backgroundDraggable: aBoolean [
	"Set to false for embedded sceneries."

	backgroundDraggable := aBoolean
]

{ #category : #accessing }
GtScenery >> boundingBox [
	self items ifEmpty: [ ^ 0 @ 0 corner: 100 @ 50 ].
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
GtScenery >> dataFolders [
	"This is where we can search for image files. Cache it in the scenery, as it can be expensive to compute."

	^ dataFolders
		ifNil: [ dataFolders := FileLocator gtResource allDirectoriesMatching: 'data' ]
]

{ #category : #accessing }
GtScenery >> dataFolders: anObject [
	dataFolders := anObject
]

{ #category : #initialization }
GtScenery >> defaultOnceLayout [
	"If nil, don't apply any layout."
	^ nil
]

{ #category : #initialization }
GtScenery >> defaultStoreStringMethodName [
	"If nil, don't offer a store action."
	^ nil
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

{ #category : #view }
GtScenery >> gtDatabaseFor: aView [
	"Suppress the database view from TDatabaseHolder"

	<gtView>
	^ aView empty
]

{ #category : #accessing }
GtScenery >> gtItemStencilsFor: aView [
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
		column: 'Stencil'
			text: [ :each | each stencil class itemCreationSubmenuLabel ]
			width: 200;
		column: 'Summary'
			text: [ :each | each stencil summaryDisplay ]
			width: 400;
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

{ #category : #action }
GtScenery >> gtStoreExampleMethodAction: anAction [
	<gtAction>
	<todo: 'Instead of hiding the action, if the method name is nil, offer the possibility to set it?'>
	self storeStringMethodName ifNil: [ ^ anAction empty ].
	^ anAction button
		tooltip: 'Save to ' , self storeStringMethodName;
		priority: 25;
		icon: BrGlamorousVectorIcons down;
		id: #gtSceneryStoreExampleAction;
		action: [ :aButton | 
			aButton phlow
				spawnTool: (GtMethodCoderTool compiledMethod: self storeAsExampleMethod) ]
]

{ #category : #view }
GtScenery >> gtStoreStringMethodOnFor: aView [
	<gtView>
	self storeStringMethod ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Store string method';
		priority: 121;
		object: [ self storeStringMethod ];
		view: #gtSourceCodeFor:;
		actionUpdateButton
]

{ #category : #comparison }
GtScenery >> hash [
	<todo: 'implement hash for all parts'>
	^ self items hash bitXor: self connections hash
]

{ #category : #accessing }
GtScenery >> initialize [
	super initialize.	"self initializeDatabase."
	items := OrderedCollection new.
	connections := OrderedCollection new.
	onceLayout := self defaultOnceLayout.
	storeStringMethodName := self defaultStoreStringMethodName.
	self databaseName: 'feenkcom/gtoolkit-scenery/scenery-help'
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

{ #category : #enumerating }
GtScenery >> itemForStencil: aStencil [
	^ self items detect: [ :item | item stencil == aStencil ] ifNone: [ nil ]
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
GtScenery >> itemsRightAndBelow: anItem [
	^ self items
		select: [ :item | item position + item extent > (anItem position + (anItem extent x @ 0)) ]
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

{ #category : #accessing }
GtScenery >> playInScripter [
	"This is sometimes needed to exercise a scenery so that its bounding box can be computed."

	^ (BlScripter new element: self asElement) play
]

{ #category : #updating }
GtScenery >> pushItemsRightAndBelow: anItem downBy: aNumber [
	"Find all items to the right and below the source item, and push them down a distance
	to make room for a new item. The distance should be the height of the new item plus a margin."

	(self itemsRightAndBelow: anItem)
		do: [ :item | item position: item position + (0 @ aNumber) ]
]

{ #category : #updating }
GtScenery >> removeConnection: aConnection [
	self connections remove: aConnection.
	self announce: (GtSceneryConnectionDeleted new connection: aConnection).
	^ aConnection
]

{ #category : #updating }
GtScenery >> removeItemWithConnections: anItem [
	"Use object identity, *not* equality, to find the item to delete.
	Return silently if the item is not found.
	NB: First compute the connections, *then* remove them, to avoid nasty
	bugs modifying a collection while iterating over it."

	| itemIndex connectionsToRemove |
	itemIndex := self items identityIndexOf: anItem ifAbsent: [ ^ anItem ].
	connectionsToRemove := self connections
			select: [ :c | c from == anItem or: c to == anItem ].
	connectionsToRemove do: [ :c | self removeConnection: c ].
	self items removeIndex: itemIndex.
	self announce: (GtSceneryItemDeleted new item: anItem).
	^ anItem
]

{ #category : #storing }
GtScenery >> restored [
	"Mainly for testing."
	^ Smalltalk compiler evaluate: self storeString
]

{ #category : #updating }
GtScenery >> spawnConnectionFrom: aSourceItem to: aStencil [
	^ self spawnConnectionFrom: aSourceItem to: aStencil labeled: nil
]

{ #category : #updating }
GtScenery >> spawnConnectionFrom: aSourceItem to: aStencil labeled: aText [
	<todo: 'Check if the connection already exists'>
	| newItem |
	newItem := self spawnNewItemFrom: aSourceItem using: aStencil.
	self
		addConnectionFrom: aSourceItem
		to: newItem
		labeled: aText.
	^ newItem
]

{ #category : #updating }
GtScenery >> spawnConnectionTo: aTargetItem from: aStencil [
	^ self spawnConnectionTo: aTargetItem from: aStencil labeled: nil
]

{ #category : #updating }
GtScenery >> spawnConnectionTo: aTargetItem from: aStencil labeled: aText [
	<todo: 'Check if the connection already exists'>
	| newItem  |
	newItem := self spawnNewItemTo: aTargetItem using: aStencil.
	self addConnectionFrom: newItem  to:  aTargetItem labeled: aText.
	^ newItem
]

{ #category : #updating }
GtScenery >> spawnNewItemFrom: aSourceItem for: anObject [
	"If the object to spawn is a LePage, use the lepiter page stencil instead."

	<todo: 'Handle more special cases of stencils to create?'>
	<todo: 'Instead of type-checking an object ask it what stencil to use to spawn it.'>
	| stencil theObject |
	theObject := (anObject isKindOf: GtPhlowCompositeTool)
			ifTrue: [ anObject tools first object ]
			ifFalse: [ anObject ].
	stencil := theObject sceneryInspectorStencil setIsSpawnedTrue.
	^ self spawnNewItemFrom: aSourceItem using: stencil
]

{ #category : #updating }
GtScenery >> spawnNewItemFrom: aSourceItem using: aStencil [
	"Just create the item, but not any link."
	| newItem |
	newItem := self spawnNewItemNextTo: aSourceItem using: aStencil.
	"aSourceItem addLinkTo: newItem."
	self addSceneryItem: newItem.
	^ newItem
]

{ #category : #updating }
GtScenery >> spawnNewItemNextTo: aTargetItem using: aStencil [
	<todo: 'Check if the item already exists.'>
	| newItem newPosition delta |
	newItem := aStencil asItem.

	delta := 20 + newItem neededHeight.
	self pushItemsRightAndBelow: aTargetItem downBy: delta.

	newPosition := aTargetItem position + ((100 + aTargetItem extent x) @ 0).
	newItem position: newPosition.
	^ newItem
]

{ #category : #updating }
GtScenery >> spawnNewItemTo: aTargetItem using: aStencil [
	| newItem |
	newItem := self spawnNewItemNextTo: aTargetItem using: aStencil.
	newItem addLinkTo: aTargetItem.
	self addSceneryItem: newItem.
	^ newItem
]

{ #category : #accessing }
GtScenery >> storeAsExampleMethod [
	| oldMethod newMethod methodBody |
	oldMethod := self storeStringMethod.
	oldMethod ifNil: [ ^ nil ].
	methodBody := oldMethod selector
			, '"NB: Generated by GtScenery>>#storeAsExampleMethod -- do not edit."'
			, ' <gtExample> <noTest> <storedScenery> <return: #GtScenery> '
			, self storeString , ' storeStringMethodName: '
			, self storeStringMethodName printString , '.' , '^ scenery '.
	oldMethod methodClass compile: methodBody.
	(oldMethod methodClass >> oldMethod selector) reformat.
	newMethod := oldMethod methodClass >> oldMethod selector.
	newMethod protocol: 'scenery'.
	^ newMethod
]

{ #category : #storing }
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
				nextPutAll: 'item' , i asString , ' := scenery addSceneryItem: (('.
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
				nextPutAll: ') from: item', (items identityIndexOf: eachConnection from) asString;
				nextPutAll: ' to: item', (items identityIndexOf: eachConnection to) asString, '.';
				cr ].
	aStream nextPutAll: 'scenery'
]

{ #category : #storing }
GtScenery >> storeStringMethod [
	^ self storeStringMethodFor: self storeStringMethodName
]

{ #category : #storing }
GtScenery >> storeStringMethodFor: aMethodName [
	"Return a valid compiled method from aMethodName, or nil.
	The method name must be a String of the form 'ClassName>>#unarySelector'
	where a class named 'ClassName' exists, #unarySelector is a valid unary selector.
	If the method exists, it should already be a noTest gtExample method."

	<todo: 'Instead of checking assertions, just return nil if an assertion fails?'>
	| parts className selector class method |
	aMethodName ifNil: [ ^ nil ].
	parts := '>>#' split: aMethodName.
	self assert: parts size equals: 2.
	className := parts first.
	selector := parts second asSymbol.
	self
		assert: className isValidGlobalName
		description: className , ' is not a valid class name'.
	class := className asClassIfAbsent: [ nil ].
	self
		assert: class isClass
		description: 'Class named ' , className , ' does not exist'.
	self
		assert: selector isValidSelector
		description: selector printString , ' is not a valid selector'.
	self
		assert: selector isUnary
		description: selector printString , ' is not a valid unary selector'.
	method := class
			compiledMethodAt: selector
			ifAbsent: [ class compile: selector , ' <gtExample> <noTest> ^ GtScenery new '.
				class >> selector ].
	method
		ifNotNil: [ self
				assert: (method hasPragmaNamed: #gtExample)
				description: 'Method ' , aMethodName , ' exists but is not a gtExample method'.
			self
				assert: (method hasPragmaNamed: #noTest)
				description: 'Method ' , aMethodName , ' exists but is not a noTest method' ].
	^ method
]

{ #category : #accessing }
GtScenery >> storeStringMethodName [
	"A gtExample method that can be rewritten to save the corrent storeString.
	If nil, this possibility is not offered as an action."

	^ storeStringMethodName
]

{ #category : #accessing }
GtScenery >> storeStringMethodName: aMethodName [
	"The method name must be a String of the form 'ClassName>>#unarySelector'
	where a class named 'ClassName' exists, #unarySelector is a valid unary selector.
	If the method exists, it should already be a noTest gtExample method.
	"

	storeStringMethodName := aMethodName
]
