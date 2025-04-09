Class {
	#name : #AMIteration,
	#superclass : #Object,
	#traits : 'TAMUtility',
	#classTraits : 'TAMUtility classTrait',
	#instVars : [
		'examples',
		'observations',
		'classes',
		'newAssociations'
	],
	#category : #'GToolkit-Scenery-Mining'
}

{ #category : #accessing }
AMIteration class >> forSeeds: anExampleCollection andClasses: aClassCollection [ 
	"For the first iteration."

	^ self new
		examples: anExampleCollection;
		classes: aClassCollection;
		yourself
]

{ #category : #accessing }
AMIteration >> classes [
	"These are the classes of interest to the AssociationMiner.
	When we iterate, we are only interested in observations with targets in this collection."

	^ classes
]

{ #category : #accessing }
AMIteration >> classes: aClassCollection [
	classes := aClassCollection
]

{ #category : #accessing }
AMIteration >> examples [
	^ examples
]

{ #category : #accessing }
AMIteration >> examples: anExampleCollection [
	examples := anExampleCollection
]

{ #category : #views }
AMIteration >> gtExamplesFor: aView [
	<gtView>
	^ (self gtExamplesFor: aView with: self examples)
		title: 'Examples';
		priority: 20
]

{ #category : #views }
AMIteration >> gtExamplesFor: aView with: examples [
	"To be used in <gtView> method for a given examples list."

	examples ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Seeds';
		priority: 10;
		items: [ examples ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Time to run'
			text: [ :each | each timeToRun ]
			width: 100;
		column: 'Class'
			text: [ :each | each objectClass ]
			width: 150;
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #views }
AMIteration >> gtNewAssociationsFor: aView [
	<gtView>
	^ aView columnedList
		priority: 25;
		title: 'New Associations';
		items: [ self newAssociations ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Associations' text: [ :each | each gtDisplayString ]
]

{ #category : #views }
AMIteration >> gtObservationsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Observations';
		priority: 10;
		items: [ self observations associations
				collect: [ :keyVal | AMObservation for: keyVal ] ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Key' text: [ :each | each key gtDisplayString ];
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each key -> each value ];
		actionUpdateButton
]

{ #category : #accessing }
AMIteration >> iterate [
	"Produce the next iteration. Iterate over the examples, producing successors,
	keeping track of new associations, new examples and new observations,
	discarding anything not of interest."

	| nextNewAssociations newExamples newObservations |
	newExamples := OrderedCollection new.
	newObservations := self observations copy.
	nextNewAssociations := OrderedCollection new.

	self examples
		do: [ :eg | 
			((eg unaryMethods
				collect: [ :m | m -> (eg navigateToSuccessorSending: m selector) clean ])
				select: [ :keyVal | keyVal value notNil ])
				do: [ :keyVal | 
					| witness association oldWitnesses selector successor |
					selector := keyVal key selector.
					successor := keyVal value.
					witness := AMWitness
							example: eg
							message: selector
							result: successor.
					association := AMAssociation
							source: eg objectClass
							message: selector
							target: successor objectClass.
					oldWitnesses := self observations
							at: association
							ifAbsent: [ OrderedCollection new ].
					oldWitnesses
						ifEmpty: [ nextNewAssociations add: association.
							newObservations at: association put: {witness} asOrderedCollection ]
						ifNotEmpty: [ newObservations
								at: association
								put: (oldWitnesses copyWith: witness) ] ] ].
	^ AMIteration new
		examples: newExamples;
		observations: newObservations;
		classes: self classes;
		newAssociations: nextNewAssociations;
		yourself
]

{ #category : #accessing }
AMIteration >> newAssociations [
	"Initially empty, and also at the end."

	^ newAssociations ifNil: [ newAssociations := OrderedCollection new ]
]

{ #category : #accessing }
AMIteration >> newAssociations: anObject [
	newAssociations := anObject
]

{ #category : #accessing }
AMIteration >> observations [
	^ observations ifNil: [ observations := Dictionary new ]
]

{ #category : #accessing }
AMIteration >> observations: anObservationCollection [
	observations := anObservationCollection
]
