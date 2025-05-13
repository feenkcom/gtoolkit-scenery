"
These examples exercise navigation between different types of items.
"
Class {
	#name : #GtSceneryNavigationExamples,
	#superclass : #AbstractGtExampleAssertable,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #scenery }
GtSceneryNavigationExamples >> ludoGameNavigateToClassScenario [
	"The object of the example method is the same as the example behind the spawned class stencil."

	<gtExample>
	<return: #GtScenery>
	| scenery gameItem classItem scripter |
	scenery := self ludoGameScenario.
	gameItem := scenery items first.
	self assert: (gameItem stencil isKindOf: GtSceneryExampleStencil).

	classItem := gameItem stencil spawnClass.

	scripter := scenery playInScripter.
	classItem stencil width: 0.
	scripter play.

	self assert: gameItem stencil objectValue equals: classItem stencil example.
	self assert: scenery equals: scenery restored.

	^ scenery
]

{ #category : #scenery }
GtSceneryNavigationExamples >> ludoGameScenario [
	<gtExample>
	<return: #GtScenery>
	^ GtScenery new
		addSceneryItem: (GtSceneryExampleStencil new
				exampleMethodName: 'GtSceneryInspectorStencilExamples>>#ludoGameExample')
				asItem;
		yourself
]

{ #category : #scenery }
GtSceneryNavigationExamples >> ludoGameSpawnSubclassScenario [
	<gtExample>
	<return: #GtScenery>
	| scenery gameItem classItem subclassItem scripter |
	scenery := self ludoGameNavigateToClassScenario.
	gameItem := scenery items first.
	classItem := scenery items second.
	self assert: (gameItem stencil isKindOf: GtSceneryExampleStencil).
	self assert: (classItem stencil isKindOf: GtSceneryUMLClassStencil).

	self
		assert: (classItem stencil hasSubclassConnectionTo: GtLudoRecordingGame) not.
	self assert: classItem stencil missingSubclasses notEmpty.

	subclassItem := classItem stencil spawnSubclass: GtLudoRecordingGame.
	self assert: subclassItem stencil hasSuperclassConnection.
	self assert: (classItem stencil hasSubclassConnectionTo: GtLudoRecordingGame).
	self assert: classItem stencil missingSubclasses isEmpty.

	scripter := scenery playInScripter.
	subclassItem stencil fitHorizontally.
	scripter play.

	self
		assert: subclassItem stencil asClass
		equals: classItem stencil asClass subclasses first.
	self assert: subclassItem outgoingLinks first equals: classItem.
	self assert: scenery equals: scenery restored.

	^ scenery
]

{ #category : #scenery }
GtSceneryNavigationExamples >> ludoGameSpawnSuperclassScenario [
	<gtExample>
	<return: #GtScenery>
	| scenery gameItem classItem superItem scripter |
	scenery := self ludoGameNavigateToClassScenario.
	gameItem := scenery items first.
	classItem := scenery items second.

	self assert: (gameItem stencil isKindOf: GtSceneryExampleStencil).
	self assert: (classItem stencil isKindOf: GtSceneryUMLClassStencil).
	
	self assert: classItem stencil hasSuperclassConnection not.
	superItem := classItem stencil spawnSuperclass.
	self assert: classItem stencil hasSuperclassConnection.
	self assert: (superItem stencil hasSubclassConnectionTo: GtLudoGame).

	scripter := scenery playInScripter.
	superItem stencil fitHorizontally.
	scripter play.

	self
		assert: superItem stencil asClass
		equals: classItem stencil asClass superclass.
	self assert: classItem outgoingLinks first equals: superItem.
	self assert: scenery equals: scenery restored.

	^ scenery
]

{ #category : #scenery }
GtSceneryNavigationExamples >> ludoGameSpawnUnaryAssociationsScenario [
	<gtExample>
	<return: #GtScenery>
	| scenery gameItem classItem superItem scripter |
	scenery := self ludoGameNavigateToClassScenario.
	gameItem := scenery items first.
	classItem := scenery items second.
	self assert: (gameItem stencil isKindOf: GtSceneryExampleStencil).
	self assert: (classItem stencil isKindOf: GtSceneryUMLClassStencil).

	"superItem := classItem stencil spawnSuperclass.


	scripter := scenery playInScripter.
	superItem stencil width: 0.
	scripter play."

	"self
		assert: superItem stencil asClass
		equals: classItem stencil asClass superclass.
	self assert: classItem outgoingLinks first equals: superItem.
	self assert: scenery equals: scenery restored."

	^ scenery
]
