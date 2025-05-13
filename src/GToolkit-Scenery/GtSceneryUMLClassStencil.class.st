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
		'exampleBlockString'
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
	^ self isValidClass
		ifTrue: [ self exampleBlockString
				ifEmpty: [ self asClass new ]
				ifNotEmpty: [ (Smalltalk compiler evaluate: self exampleBlockString) value ] ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> defaultExampleBlockString [
	^ ''
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
GtSceneryUMLClassStencil >> example [
	^ example ifNil: [ example := self computeExample ]
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> exampleBlockString [
	^ exampleBlockString
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> exampleBlockString: aClosureOrString [
	"We store a string instead of a block to avoid capturing any free variables.
	On updates we invalidate the #example cache."

	exampleBlockString := aClosureOrString isClosure
			ifTrue: [ aClosureOrString printString ]
			ifFalse: [ aClosureOrString ].

	example := nil.
	self announceStencilUpdate
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

{ #category : #initialization }
GtSceneryUMLClassStencil >> initialize [
	super initialize.
	exampleBlockString := self defaultExampleBlockString
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
	(self isValidClass and: [ self asClass isAbstract not ]) ifFalse: [ ^ menu ].
	menu
		addItemLabel: 'Inspect example'
		action: [ :elt | aChildElement fireEvent: (GtSceneryObjectToSpawn new object: self example) ].

	self asClass = ProtoObject
		ifFalse: [ menu
				addItemLabel: 'Spawn superclass ' , self asClass superclass className
				action: [ self spawnSuperclass ] ].
	
	subclasses := self asClass subclasses asOrderedCollection sortedAs: #name.
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

	menu addItemLabel: 'Spawn package' action: [ self spawnPackage ].
	^ menu
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

{ #category : #menu }
GtSceneryUMLClassStencil >> spawnPackage [
	^ self gtScenery
		spawnConnectionFrom: self item
		to: (GtSceneryPackageInspectorStencil new package: self asClass package)
		labeled: 'package'
]

{ #category : #menu }
GtSceneryUMLClassStencil >> spawnSubclass: aClass [
	^ self gtScenery
		spawnConnectionTo: self item
		from: (GtSceneryUMLClassStencil new
				class: aClass;
				exampleBlockString: self exampleBlockString;
				yourself)
]

{ #category : #menu }
GtSceneryUMLClassStencil >> spawnSuperclass [
	^ self gtScenery
		spawnConnectionFrom: self item
			to: (GtSceneryUMLClassStencil new
					class: self asClass superclass;
					exampleBlockString: self exampleBlockString;
					yourself)
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
	"Attributes used in the #storeOn:method"

	^ super storeOnAttributes , {#exampleBlockString}
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> validForegroundColor [
	^ Color black
]
