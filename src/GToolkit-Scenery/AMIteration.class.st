Class {
	#name : #AMIteration,
	#superclass : #Object,
	#traits : 'TAMUtility',
	#classTraits : 'TAMUtility classTrait',
	#instVars : [
		'examples',
		'observations',
		'classes'
	],
	#category : #'GToolkit-Scenery-Mining'
}

{ #category : #accessing }
AMIteration class >> forSeeds: anExampleCollection andClasses: aClassCollection [ 
	"For the first iteration."

	^ self new
		examples: anExampleCollection;
		observations: OrderedCollection new;
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
AMIteration >> gtObservationsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Observations';
		priority: 10;
		items: [ self observations ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #accessing }
AMIteration >> nextExamples [
	^ self examples flatCollect: #successors
]

{ #category : #accessing }
AMIteration >> observations [
	^ observations ifNil: [ observations := OrderedCollection new ]
]

{ #category : #accessing }
AMIteration >> observations: anObservationCollection [
	observations := anObservationCollection
]
