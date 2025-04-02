"
Some initial examples for the {{gtClass:name=GtSceneryClassDiagramBuilder}} builder for UML diagrams.
To do:
• Refine the API to support checked associations
• Generate a diagram from a package
• Generate a class hierarchy up to some depth
"
Class {
	#name : #GtSceneryClassDiagramBuilderExamples,
	#superclass : #AbstractGtExampleAssertable,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #'as yet unclassified' }
GtSceneryClassDiagramBuilderExamples >> objectCollectionHierarchy [
	<gtExample>
	| builder scenery |
	builder := GtSceneryClassDiagramBuilder
			withClasses: {Object.
					Collection}
			associations: {}
			andInheritances: {Collection -> Object}.

	scenery := builder build.

	self
		assert: (scenery items collect: [ :item | item stencil asClass ]) asSet
		equals: {Object.
				Collection} asSet.
	self
		assert: (scenery connections
				collect: [ :each | each from stencil asClass -> each to stencil asClass ])
				asSet
		equals: {Collection -> Object} asSet.

	^ scenery
]

{ #category : #'as yet unclassified' }
GtSceneryClassDiagramBuilderExamples >> objectCollectionHierarchyMissingClasses [
	"Should fail due to missing classes."

	<gtExample>
	^ self
		should: [ GtSceneryClassDiagramBuilder
				withClasses: {}
				associations: {}
				andInheritances: {Collection -> Object} ]
		raise: AssertionFailure
]
