"
I am a text label for a class that can serve as a UML class box.

To do:
• Double-click to browse the class.
• Spawn UML specialization connections to sublasses or superclasses.
• Highlight name in red of the class is not valid.
• Auto-completion for valid class names.

"
Class {
	#name : #GtSceneryUMLClassStencil,
	#superclass : #GtSceneryTextLabelStencil,
	#instVars : [
		'example',
		'exampleBlockString',
		'successorDict',
		'exampleMethodName'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #menu }
GtSceneryUMLClassStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #menu }
GtSceneryUMLClassStencil class >> itemCreationSubmenuLabel [
	^ 'UML Class'
]

{ #category : #'as yet unclassified' }
GtSceneryUMLClassStencil class >> leJsonV4Name [
	"The name (symbol) for this type of stencil in the JSON representation."
	^ #sceneryUMLClassStencil
]

{ #category : #conversion }
GtSceneryUMLClassStencil >> asClass [
	"nil needed for #isValid"
	^ self label asClassIfAbsent: [ nil ]
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> class: aClass [
	self label: aClass name
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> computeExample [
	"NB: We want to deprecate the exampleBlockString ..."

	self exampleMethodName ifNotNil: [ ^ self objectValue ].
	self exampleBlockString
		ifNotNil: [ ^ self computeExampleFrom: self exampleBlockString ].
	^ self asClass isAbstract ifTrue: [ nil ] ifFalse: [ self asClass new ]
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> computeExampleFrom: aString [
	<todo: 'Instead of returning nil for abstract classes, try to instantiate a concrete subclass!'>
	self asClass superclass = Boolean
		ifTrue: [ ^ self asClass materializeFrom: nil ].
	^ self isValidClass
		ifTrue: [ (aString isNil or: [ aString isEmpty ])
				ifTrue: [ self asClass isAbstract ifTrue: [ nil ] ifFalse: [ self asClass new ] ]
				ifFalse: [ (Smalltalk compiler evaluate: aString) value ] ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> defaultExampleBlockString [
	^ nil
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> defaultExampleMethodName [
	^ nil
]

{ #category : #initialization }
GtSceneryUMLClassStencil >> defaultFontSize [
	^ 24
]

{ #category : #initialization }
GtSceneryUMLClassStencil >> defaultLabel [
	^ 'Click and return to edit'
]

{ #category : #'api - instantiation' }
GtSceneryUMLClassStencil >> elementClass [
	^ GtSceneryUMLClassElement
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> ensureItemForClass: aClass withExampleBlock: anExampleBlockString [
	"Ensure an item exists for this class and return it."

	<todo: 'Generalize #ensureItemForClass: for other usages (eg page stencils).'>
	^ self gtScenery items
		detect: [ :item | 
			(item stencil isKindOf: GtSceneryUMLClassStencil)
				and: [ item stencil asClass = aClass ] ]
		ifNone: [ self gtScenery
				spawnNewItemFrom: self item
				using: (GtSceneryUMLClassStencil new
						class: aClass;
						exampleBlockString: anExampleBlockString;
						yourself) ]
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> example [
	^ example ifNil: [ example := self computeExample ]
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> exampleBlockString [
	"In the original design, an example is computed from a block consisting of a class followed by 
	a sequence of unary message sends. We should deprecate this in favor of simply an example method name."

	^ exampleBlockString
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> exampleBlockString: aClosureOrString [
	"We store a string instead of a block to avoid capturing any free variables.
	On updates we invalidate the #example cache."

	| theString theExample |
	theString := aClosureOrString isClosure
			ifTrue: [ aClosureOrString printString ]
			ifFalse: [ aClosureOrString ].

	theExample := self computeExampleFrom: theString.
	self
		assert: (theExample isKindOf: self asClass)
		description: 'The example string "' , theString , '" returns a ' , theExample class name
				, ' instead of a ' , self label.

	exampleBlockString := theString.
	example := theExample.

	self announceStencilUpdate
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> exampleExpression [
	"Extract the expression within the block so we can compose it."

	^ ((self exampleBlockString removePrefix: '[') removeSuffix: ']') trim
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> exampleMethod [
	^ (MethodByName for: self exampleMethodName) method
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> exampleMethod: aMethod [
	^ self  exampleMethodName: aMethod
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> exampleMethodName [
	"Instead of arbitrary blocks, we want to exclusively allow gtExample methods."

	^ exampleMethodName
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> exampleMethodName: aStringOrMethod [
	"The argument should identify a <gtExample> method."

	| methodByName |
	methodByName := MethodByName for: aStringOrMethod.
	self assert: (methodByName method hasPragmaNamed: #gtExample).
	exampleMethodName := methodByName name	
	"self announceStencilUpdate"
]

{ #category : #querying }
GtSceneryUMLClassStencil >> examplesAvailable [
	^ self asClass package gtExamplesWithReturnPragmasClassified at: self label ifAbsent: [OrderedCollection new]
]

{ #category : #action }
GtSceneryUMLClassStencil >> gtExampleButtonFor: anAction [
	<gtAction>
	^ anAction button
		priority: 1;
		tooltip: 'Inspect example';
		icon: BrGlamorousVectorIcons eg;
		action: [ :aButton | aButton phlow spawnObject: self example ];
		primaryModifierAction: [ :aButton | aButton phlow showObject: self ]
			mouseCursor: BlCopyCursor new
]

{ #category : #listeners }
GtSceneryUMLClassStencil >> handleDoubleClickForItemElement: anItemElement inSceneryElement: aSceneryElement [
	"Hook method for subclasses."

	self isValidClass
		ifTrue: [ anItemElement
				fireEvent: (GtSceneryObjectToSpawn new object: (GtClassCoderTool forClass: self asClass)) ]
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> hasSubclassConnectionTo: aClass [
	^ self gtScenery connections
		detect: [ :c | 
			c to == self item
				and: [ (c stencil isKindOf: GtSceneryUMLConnectionStencil)
						and: [ c stencil isInheritanceRelation and: [ c from stencil asClass = aClass ] ] ] ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> hasSuperclassConnection [
	^ self gtScenery connections
		detect: [ :c | 
			c from == self item
				and: [ (c stencil isKindOf: GtSceneryUMLConnectionStencil)
						and: [ c stencil isInheritanceRelation ] ] ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #initialization }
GtSceneryUMLClassStencil >> initialize [
	super initialize.
	"exampleBlockString := self defaultExampleBlockString"
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> invalidForegroundColor [
	^ Color red
]

{ #category : #testing }
GtSceneryUMLClassStencil >> isUMLClassStencil [
	^ true
]

{ #category : #testing }
GtSceneryUMLClassStencil >> isValidClass [
	^ self asClass isNotNil
]

{ #category : #testing }
GtSceneryUMLClassStencil >> isValidIn: aSceneryContext [
	"We don't need the context."

	^ self isValidClass
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> label: aString [
	super label: aString.
	self isValidClass
		ifTrue: [ self text foreground: self validForegroundColor ]
		ifFalse: [ self text foreground: self invalidForegroundColor ]
]

{ #category : #menu }
GtSceneryUMLClassStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	<todo: 'spawn superclass or subclass nodes'>
	| menu subclasses |
	menu := super
			menuForChildElement: aChildElement
			andSceneryElement: aGtSceneryElement.
	self isValidClass ifFalse: [ ^ menu ].

	menu
		addItemLabel: 'Inspect example'
		action: [ :elt | aChildElement fireEvent: (GtSceneryObjectToSpawn new object: self example) ].

	menu
		addItemLabel: 'Set example method'
		submenu: [ | submenu |
			submenu := BrMenuItems new.
			self examplesAvailable
				do: [ :m | submenu addItemLabel: m name action: [ self exampleMethodName: m ] ].
			submenu ] value.

	self exampleMethodName
		ifNotNil: [ menu addItemLabel: 'Spawn example' action: [ self spawnExample ] ].

	self hasSuperclassConnection
		ifFalse: [ self asClass = ProtoObject
				ifFalse: [ menu
						addItemLabel: 'Spawn superclass ' , self asClass superclass name
						action: [ self spawnSuperclass ] ] ].

	subclasses := self missingSubclasses.
	subclasses size = 1
		ifTrue: [ menu
				addItemLabel: 'Spawn subclass ' , subclasses first name
				action: [ self spawnSubclass: subclasses first ] ].

	subclasses size > 1
		ifTrue: [ menu
				addItemLabel: 'Spawn subclass'
				submenu: [ | submenu |
					submenu := BrMenuItems new.
					subclasses
						do: [ :class | submenu addItemLabel: class name action: [ self spawnSubclass: class ] ].
					submenu ] value ].

	self successorDict notEmpty
		ifTrue: [ menu
				addItemLabel: 'Spawn associations'
				submenu: [ | submenu |
					submenu := BrMenuItems new.
					self successorDict
						keysAndValuesDo: [ :k :v | 
							submenu
								addItemLabel: 'Spawn association to ' , k name
								action: [ self spawnAssociatedClass: k using: v first key ] ].
					submenu ] value ].

	menu addItemLabel: 'Spawn package' action: [ self spawnPackage ].

	^ menu
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> missingSubclasses [
	"Return the list of subclasses for which a subclass connection does not already exist."

	^ (self asClass subclasses
		select: [ :c | (self hasSubclassConnectionTo: c) not ]) asOrderedCollection
		sortedAs: #name
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> objectValue [
	^ self exampleMethod gtExample result returnValue
]

{ #category : #querying }
GtSceneryUMLClassStencil >> packages [
	^ {self asClass package}
]

{ #category : #validity }
GtSceneryUMLClassStencil >> reportOn: aStream in: anItem [
	self isValidClass
		ifFalse: [ aStream
				nextPutAll: '“';
				nextPutAll: self label;
				nextPutAll: '” does not exist as a class';
				cr ]
]

{ #category : #'as yet unclassified' }
GtSceneryUMLClassStencil >> spawnAssociatedClass: aClass using: selector [
	| classItem |
	classItem := self
			ensureItemForClass: aClass
			withExampleBlock: '[ ' , self exampleExpression , ' ' , selector , ' ]'.
	self gtScenery
		addConnectionFrom: self item
		to: classItem
		labeled: selector.
	^ classItem
]

{ #category : #menu }
GtSceneryUMLClassStencil >> spawnExample [
	^ self gtScenery
		spawnConnectionFrom: self item
		to: (GtSceneryExampleStencil new exampleMethodName: self exampleMethodName)
		labeled: 'example'
]

{ #category : #menu }
GtSceneryUMLClassStencil >> spawnPackage [
	^ self gtScenery
		spawnConnectionFrom: self item
		to: (GtSceneryPackageInspectorStencil new package: self asClass package)
		labeled: 'package'
]

{ #category : #menu }
GtSceneryUMLClassStencil >> spawnSubclass: aClass [
	| subclassItem |
	subclassItem := self
			ensureItemForClass: aClass
			withExampleBlock: '[ ' , aClass name , ' new ]'.
	self gtScenery addConnectionFrom: subclassItem to: self item.
	^ subclassItem
]

{ #category : #menu }
GtSceneryUMLClassStencil >> spawnSuperclass [
	"NB: If the superclass is abstract, use my own example instead."

	| superclassItem |
	superclassItem := self
			ensureItemForClass: self asClass superclass
			withExampleBlock: (self asClass superclass isAbstract
					ifTrue: [ self exampleBlockString ]
					ifFalse: [ '[ ' , self asClass superclass name , ' new ]' ]).
	self gtScenery addConnectionFrom: self item to: superclassItem.
	^ superclassItem
]

{ #category : #connecting }
GtSceneryUMLClassStencil >> stencilForConnectionWith: aTargetItem labeled: aText [
	"Hook to let the stencil decide the connection stencil to use."

	self class = aTargetItem stencil class
		ifTrue: [ | connectionStencil |
			connectionStencil := GtSceneryUMLConnectionStencil new
					labelText: aText;
					yourself.
			aTargetItem stencil asClass = self asClass superclass
				ifTrue: [ connectionStencil beInheritance ].
			^ connectionStencil ].

	^ super stencilForConnectionWith: aTargetItem labeled: aText
]

{ #category : #printing }
GtSceneryUMLClassStencil >> storeOnAttributes [
	"Attributes used in the #storeOn: method (via #storeWithAttributesOn:)"

	^ super storeOnAttributes
		, {#exampleBlockString.
				#exampleMethodName}
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> successorDict [
	"For spwaning associations.
	Adapted from GtSceneryExampleStencil>>#umlScenery"

	<todo: 'Filter classes to merge True & False to Boolean, and to flatten Collections to the item type.'>
	| eg egClass unaryMethods successors |
	successorDict := Dictionary new.
	(self asClass = Object or: [ self asClass = UndefinedObject ])
		ifTrue: [ ^ successorDict ].
	eg := self example.
	egClass := eg class.
	unaryMethods := self unaryMethods.
	unaryMethods size > 50 ifTrue: [ ^ successorDict ].	"Avoid blocking for classes like Object!"
	successors := unaryMethods
			collect: [ :m | 
				[ | successor |
				successor := eg perform: m selector.
				m selector -> successor ] onErrorDo: [ nil ] ]
			thenSelect: #notNil.
	successors
		do: [ :kv | 
			(successorDict at: kv value class ifAbsentPut: [ OrderedCollection new ])
				add: kv ].
	^ successorDict
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> unaryMethods [
	^ self asClass methods
		select: [ :m | m selector isUnary and: [ m isDeprecated not ] ]
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> validForegroundColor [
	^ Color black
]
