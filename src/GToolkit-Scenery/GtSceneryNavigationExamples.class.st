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
GtSceneryNavigationExamples >> ludoGameSpawnSuperclassScenario [
	"The object of the example method is the same as the example behind the spawned class stencil."

	<gtExample>
	<return: #GtScenery>
	| scenery gameItem classItem |
	scenery := self ludoGameNavigateToClassScenario.
	gameItem := scenery items first.
	classItem := scenery items second.
	self assert: (gameItem stencil isKindOf: GtSceneryExampleStencil).
	self assert: (classItem stencil isKindOf: GtSceneryUMLClassStencil).
	
	

	^ scenery
]
