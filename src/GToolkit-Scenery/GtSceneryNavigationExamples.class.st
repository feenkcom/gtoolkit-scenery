"
These examples exercise navigation between different types of items.
"
Class {
	#name : #GtSceneryNavigationExamples,
	#superclass : #AbstractGtExampleAssertable,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #scenery }
GtSceneryNavigationExamples >> embeddedScenerySpawnClassScenerio [
	<gtExample>
	<return: #GtScenery>
	| scenery  embeddedItem classItem |
	scenery := GtSceneryInspectorStencilExamples new embeddedSceneryExampleScenery.
	
	embeddedItem := scenery items first.
	self assert: (embeddedItem stencil isKindOf:GtEmbeddedSceneryStencil).

	classItem := embeddedItem stencil spawnClass.
	
	self assert: classItem stencil example class equals: GtScenery.
	self assert: scenery equals: scenery restored.
	
	^ scenery
]

{ #category : #scenery }
GtSceneryNavigationExamples >> ludoGameNavigateToClassScenario [
	"The object of the example method is the same as the example behind the spawned class stencil."

	<gtExample>
	<return: #GtScenery>
	| scenery gameItem classItem |
	scenery := self ludoGameScenario.
	gameItem := scenery items first.
	self assert: (gameItem stencil isKindOf: GtSceneryExampleStencil).

	classItem := gameItem stencil spawnClass.

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
	| scenery gameItem classItem scripter playerItem |
	scenery := self ludoGameNavigateToClassScenario.
	gameItem := scenery items first.
	classItem := scenery items second.
	self assert: (gameItem stencil isKindOf: GtSceneryExampleStencil).
	self assert: (classItem stencil isKindOf: GtSceneryUMLClassStencil).


	playerItem := classItem stencil
			spawnAssociatedClass: GtLudoPlayer
			using: #nextPlayer.

	scripter := scenery playInScripter.
	playerItem stencil width: 0.
	scripter play.


	self assert: playerItem stencil example class equals: GtLudoPlayer.

	self assert: scenery equals: scenery restored.

	^ scenery
]

{ #category : #scenery }
GtSceneryNavigationExamples >> scripterSpawnClassScenerio [
	<gtExample>
	<return: #GtScenery>
	| scenery  scripterItem classItem |
	scenery := GtSceneryInspectorStencilExamples new scripterScenery.
	
	scripterItem := scenery items first.
	self assert: (scripterItem stencil isKindOf:GtSceneryScripterStencil).

	classItem := scripterItem stencil spawnClass.
	
	self assert: classItem stencil example class equals: GtSceneryElement.
	self assert: scenery equals: scenery restored.
	
	^ scenery
]

{ #category : #scenery }
GtSceneryNavigationExamples >> slideSpawnClassScenerio [
	<gtExample>
	<return: #GtScenery>
	| scenery slideItem classItem |
	scenery := GtScenery new.
	slideItem := scenery addSceneryItem: GtScenerySlideStencil new asItem.
	
	classItem := slideItem stencil spawnClass.
	
	self assert: classItem stencil example class equals: GtElementLiveSlide.
	self assert: scenery equals: scenery restored.
	
	^ scenery
]
