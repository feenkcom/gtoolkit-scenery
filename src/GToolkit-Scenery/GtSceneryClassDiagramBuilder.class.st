"
I am a utility offering a compact API for creating UML class diagrams as instances of GtScenery.

*Caveat:* the interface is expected to evolve.
"
Class {
	#name : #GtSceneryClassDiagramBuilder,
	#superclass : #Object,
	#instVars : [
		'classes',
		'inheritances',
		'classItemMap',
		'associations'
	],
	#category : #'GToolkit-Scenery-Utilities'
}

{ #category : #accessing }
GtSceneryClassDiagramBuilder class >> withClasses: aClassCollection associations: aRelationshipAssociationCollection andInheritances: anInheritanceAssociationCollection [
	^ self new
		classes: aClassCollection;
		associations: aRelationshipAssociationCollection;
		inheritances: anInheritanceAssociationCollection;
		yourself
]

{ #category : #building }
GtSceneryClassDiagramBuilder >> addAssociationsTo: scenery [
	self associations
		do: [ :assoc | 
			| from to connection |
			from := classItemMap
					at: assoc key
					ifAbsent: [ self signalItemNotFound: assoc key ].
			to := classItemMap
					at: assoc value
					ifAbsent: [ self signalItemNotFound: assoc value ].
			connection := scenery addConnectionFrom: from to: to.
			connection stencil beAssociation ]
]

{ #category : #building }
GtSceneryClassDiagramBuilder >> addClassesTo: scenery [
	| position positionDelta |
	position := 0 @ 0.
	positionDelta := 50 @ 50.
	self classes
		do: [ :aClass | 
			| item |
			item := scenery
					addItem: (GtSceneryUMLClassStencil new text: aClass name asRopedText) asItem.
			self classItemMap at: aClass put: item.
			item position: position.
			position := position + positionDelta ]
]

{ #category : #building }
GtSceneryClassDiagramBuilder >> addInheritencesTo: scenery [
	self inheritances
		do: [ :assoc | 
			| from to connection |
			from := classItemMap
					at: assoc key
					ifAbsent: [ self signalItemNotFound: assoc key ].
			to := classItemMap
					at: assoc value
					ifAbsent: [ self signalItemNotFound: assoc value ].
			connection := scenery addConnectionFrom: from to: to.
			connection stencil beInheritance ]
]

{ #category : #assertions }
GtSceneryClassDiagramBuilder >> assertClass: each [
	^ self assert: each isClass description: 'All arguments must be classes.'
]

{ #category : #assertions }
GtSceneryClassDiagramBuilder >> assertClass: aClass subclasses: anotherClass [
	^ self
		assert: aClass superclass = anotherClass
		description: aClass name , ' is not a subclass of ' , anotherClass name
]

{ #category : #assertions }
GtSceneryClassDiagramBuilder >> assertInClasses: aClass [
	self assert: (self classes includes: aClass) description: aClass name, 'must be in the set of classes'
]

{ #category : #accessing }
GtSceneryClassDiagramBuilder >> associations [
	^ associations ifNil: [ associations := OrderedCollection new ]
]

{ #category : #accessing }
GtSceneryClassDiagramBuilder >> associations: anClassAssociationCollection [
	<todo: 'Relationships need two classes, a label, and a 1-argument navigation block to verify that the result type matches the target class.'>
	<todo: 'need a way to check the relationship'>
	anClassAssociationCollection
		do: [ :assoc | 
			self assertClass: assoc key.
			self assertInClasses: assoc key.
			self assertClass: assoc value.
			self assertInClasses: assoc value ].
	associations := anClassAssociationCollection
]

{ #category : #building }
GtSceneryClassDiagramBuilder >> build [
	| scenery |
	scenery := GtScenery new.
	self addClassesTo: scenery.
	self addInheritencesTo: scenery.
	self addAssociationsTo: scenery.
	^ scenery
]

{ #category : #accessing }
GtSceneryClassDiagramBuilder >> classItemMap [
	^ classItemMap ifNil: [ classItemMap := Dictionary new ]
]

{ #category : #accessing }
GtSceneryClassDiagramBuilder >> classes [
	^ classes ifNil: [ classes := OrderedCollection new ]
]

{ #category : #accessing }
GtSceneryClassDiagramBuilder >> classes: aClassCollection [
	aClassCollection do: [ :each | self assertClass: each ].
	classes := aClassCollection copyWithoutDuplicates
]

{ #category : #accessing }
GtSceneryClassDiagramBuilder >> inheritances [
	^ inheritances ifNil: [ inheritances := OrderedCollection new ]
]

{ #category : #accessing }
GtSceneryClassDiagramBuilder >> inheritances: anInheritanceAssociationCollection [
	anInheritanceAssociationCollection
		do: [ :assoc | 
			self assertClass: assoc key.
			self assertInClasses: assoc key.
			self assertClass: assoc value.
			self assertInClasses: assoc value.
			self assertClass: assoc key subclasses: assoc value ].
	inheritances := anInheritanceAssociationCollection
]

{ #category : #building }
GtSceneryClassDiagramBuilder >> signalItemNotFound: assoc [
	^ AssertionFailure signal: 'Could not find item for class ' , assoc
]
