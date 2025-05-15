Class {
	#name : #GtSceneryExampleStencil,
	#superclass : #AbstractGtSceneryInspectorStencil,
	#instVars : [
		'exampleMethodName'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #menu }
GtSceneryExampleStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #menu }
GtSceneryExampleStencil class >> itemCreationSubmenuLabel [
	^ 'Example'
]

{ #category : #example }
GtSceneryExampleStencil >> defaultExampleMethod [
	<gtExample>
	<return: #UndefinedObject>
	^ nil
]

{ #category : #initialization }
GtSceneryExampleStencil >> defaultExampleMethodName [
	^ 'GtSceneryExampleStencil>>#defaultExampleMethod'
]

{ #category : #storing }
GtSceneryExampleStencil >> exampleBlockStringForUMLClassStencil [
	"For instantiating a GtSceneryUMLClassStencil.
	NB: to be refined by subclasses."

	^ '[ (' , self exampleMethodName , ') gtExample result returnValue ]'
]

{ #category : #accessing }
GtSceneryExampleStencil >> exampleMethod [
	^ (MethodByName for: self exampleMethodName) method
]

{ #category : #accessing }
GtSceneryExampleStencil >> exampleMethod: aMethod [
	self exampleMethodName: aMethod
]

{ #category : #accessing }
GtSceneryExampleStencil >> exampleMethodName [
	^ exampleMethodName
]

{ #category : #accessing }
GtSceneryExampleStencil >> exampleMethodName: aStringOrMethod [
	| methodByName |
	methodByName := MethodByName for: aStringOrMethod.
	self assert: (methodByName method hasPragmaNamed: #gtExample).
	exampleMethodName := methodByName name.
	self announceStencilUpdate
]

{ #category : #view }
GtSceneryExampleStencil >> gtExampleMethodFor: aView [
	<gtView>
	^ aView forward
		title: 'Example method';
		priority: 20;
		object: [ self exampleMethod ];
		view: #gtSourceCodeFor:
]

{ #category : #listeners }
GtSceneryExampleStencil >> handleDoubleClickForItemElement: anItemElement inSceneryElement: aSceneryElement [
	anItemElement fireEvent: (GtSceneryObjectToSpawn new object: self objectValue)
]

{ #category : #initialization }
GtSceneryExampleStencil >> initialize [
	super initialize.
	exampleMethodName := self defaultExampleMethodName
]

{ #category : #menu }
GtSceneryExampleStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	^ (super
		menuForChildElement: aChildElement
		andSceneryElement: aGtSceneryElement)
		addItemLabel: 'Spawn class' action: [ self spawnClass ];
		addItemLabel: 'Spawn package' action: [ self spawnPackage ];
		addItemLabel: 'Inspect UML'
			action: [ aChildElement fireEvent: (GtSceneryObjectToSpawn new object: self umlScenery) ];
		yourself
]

{ #category : #accessing }
GtSceneryExampleStencil >> objectValue [
	^ self exampleMethod gtExample result returnValue
]

{ #category : #menu }
GtSceneryExampleStencil >> spawnClass [
	^ self gtScenery
		spawnConnectionFrom: self item
		to: (GtSceneryUMLClassStencil new
				class: self objectValue class;
				exampleBlockString: self exampleBlockStringForUMLClassStencil;
				yourself)
		labeled: 'class'
]

{ #category : #menu }
GtSceneryExampleStencil >> spawnPackage [
	^ self gtScenery
		spawnConnectionFrom: self item
		to: (GtSceneryPackageInspectorStencil new
				package: self objectValue class package)
		labeled: 'package'
]

{ #category : #storing }
GtSceneryExampleStencil >> storeOnAttributes [
	^ super storeOnAttributes , {#exampleMethodName}
]

{ #category : #printing }
GtSceneryExampleStencil >> summaryDisplay [
	"Text to display in the items or stencil view."
	^ self exampleMethodName
]

{ #category : #'as yet unclassified' }
GtSceneryExampleStencil >> umlScenery [
	"For demo purposes only. We are still missing the ability to further expand the diagram, to associate labels to the associations, and examples to all the classes."

	<todo: 'Turn the UML scenery generation from a prototype into something usable for exploration.'>
	| eg egClass allClasses unaryMethods successorDict associations inheritances builder scenery layout |
	eg := self objectValue.

	egClass := eg class.

	allClasses := OrderedCollection with: egClass with: egClass superclass.
	allClasses addAll: egClass subclasses.

	successorDict := Dictionary new.
	unaryMethods := egClass methods
			select: [ :m | m selector isUnary and: [ m isDeprecated not ] ].
	unaryMethods
		do: [ :m | 
			| successor |
			successor := [ (eg perform: m selector) class ] onErrorDo: [ nil ].
			successor
				ifNotNil: [ successor = egClass
						ifFalse: [ (successorDict at: successor ifAbsentPut: [ OrderedCollection new ])
								add: m selector ] ] ].

	associations := successorDict keys
			collect: [ :successorClass | egClass -> successorClass ].

	allClasses addAll: successorDict keys.
	allClasses removeDuplicates.
	inheritances := allClasses
			collect: [ :c | c -> c superclass ]
			thenSelect: [ :assoc | allClasses includes: assoc value ].

	builder := GtSceneryClassDiagramBuilder
			withClasses: allClasses
			associations: associations
			andInheritances: inheritances.
	layout := GtGraphForceBasedLayout new
			charge: -5000;
			length: 100.
	scenery := builder build
			onceLayout: layout;
			yourself.
	^ scenery
]
