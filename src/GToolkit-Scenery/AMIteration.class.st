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

{ #category : #'instance creation' }
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

{ #category : #querying }
AMIteration >> divergences [
	^ self groupDivergences values reject: [ :obs | obs size = 1 ]
]

{ #category : #accessing }
AMIteration >> examples [
	^ examples
]

{ #category : #accessing }
AMIteration >> examples: anExampleCollection [
	examples := anExampleCollection
]

{ #category : #processing }
AMIteration >> groupBySourceAndTarget [
	"Return a dictionary mapping anonymous associations to observations with the same source and target."

	| partition |
	partition := Dictionary new.
	self mergedTargetObservations
		associationsDo: [ :keyValue | 
			| anon |
			anon := keyValue key asAnonymousAssociation.
			(partition at: anon ifAbsentPut: [ OrderedCollection new ]) add: keyValue ].
	^ partition
]

{ #category : #processing }
AMIteration >> groupDivergences [
	"Return a dictionary mapping pre-associations <source,message> -> observation*
	where each observation maps <source,message,target> -> witness* (source & message are the same)
	Entry is divergent if there are multiple observations with the same source and message but different target class."

	| partition |
	partition := Dictionary new.
	self observations
		associationsDo: [ :keyValue | 
			| pre |
			pre := keyValue key asPreassociation.
			(partition at: pre ifAbsentPut: [ OrderedCollection new ]) add: keyValue ].
	^ partition
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
AMIteration >> gtMergedMessageObservationsFor: aView [
	<gtView>
	^ (self gtObservationsFor: aView with: self mergedMessageObservations)
		title: 'Merged message observations';
		priority: 52
]

{ #category : #views }
AMIteration >> gtMergedTargetObservationsFor: aView [
	<gtView>
	^ (self gtObservationsFor: aView with: self mergedTargetObservations)
		title: 'Merged target observations';
		priority: 50
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
	^ (self gtObservationsFor: aView with: self observations)
		title: 'Observations';
		priority: 10
]

{ #category : #processing }
AMIteration >> iterateFor: aClassCollection [
	"Produce the next iteration. Iterate over the examples, producing successors,
	keeping track of new associations, new examples and new observations,
	discarding anything not of interest. We ignore successors whose result class 
	is not in the class collection of interest."

	| nextNewAssociations newExamples newObservations |
	newExamples := OrderedCollection new.
	newObservations := self observations copy.
	nextNewAssociations := OrderedCollection new.

	self examples
		do: [ :eg | 
			((eg unaryMethods
				collect: [ :m | m -> (eg navigateToSuccessorSending: m selector) clean ])
				select: [ :keyVal | keyVal value notNil 
					and: [ aClassCollection includes: keyVal value objectClass ] ])
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

{ #category : #processing }
AMIteration >> joinClasses: aClassCollection [
	^ ((aClassCollection allButFirst
		inject: aClassCollection first allSuperclasses
		into: [ :intersection :each | intersection intersection: each allSuperclasses ])
		sortedAs: #classDepth) last
]

{ #category : #processing }
AMIteration >> mergedMessageObservations [
	"If there are multiple observations with the same source and target but different messages,
	merge them, indicating a new pseudo-message that joins all the selectors. 
	(This can be a placeholder for a  more suitable label at a later stage.)"

	<todo: 'Cache this value?'>
	| mergedMessageObservations |
	mergedMessageObservations := Dictionary new.
	self groupBySourceAndTarget
		associationsDo: [ :kv | 
			kv value size = 1
				ifTrue: [ mergedMessageObservations
						at: kv value first key
						put: (OrderedCollection withAll: kv value first value) ]
				ifFalse: [ | selectorsToMerge merged |
					selectorsToMerge := kv value collect: [ :assoc | assoc key message ].
					merged := 'merged' , ('' join: (selectorsToMerge collect: #capitalized)).
					mergedMessageObservations
						at: (kv value first key copyWithMessage: merged asSymbol)
						put: (kv value flatCollect: #value) ] ].
	^ mergedMessageObservations
]

{ #category : #processing }
AMIteration >> mergedTargetObservations [
	"If there are ambiguous observations with multiple targets (kv value size > 1), 
	we merge them, take the join of the target classes.
	E.g., observations returning True and False will be merged into one returning Boolean."

	<todo: 'Cache this value?'>
	| mergedTargetObservations |
	mergedTargetObservations := Dictionary new.
	self groupDivergences
		associationsDo: [ :kv | 
			kv value size = 1
				ifTrue: [ mergedTargetObservations
						at: kv value first key
						put: (OrderedCollection withAll: kv value first value) ]
				ifFalse: [ | classesToJoin join |
					classesToJoin := kv value collect: [ :assoc | assoc key target ].
					join := self joinClasses: classesToJoin.
					mergedTargetObservations
						at: (kv value first key copyWithTarget: join)
						put: (kv value flatCollect: #value) ] ].
	^ mergedTargetObservations
]

{ #category : #querying }
AMIteration >> navigationClusters [
	"Clusters of observations with the same source and target but different navigation messages."

	^ self groupBySourceAndTarget values reject: [ :obs | obs size = 1 ]
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
AMIteration >> normalizedObservations [
	^ self mergedMessageObservations
]

{ #category : #accessing }
AMIteration >> observations [
	^ observations ifNil: [ observations := Dictionary new ]
]

{ #category : #accessing }
AMIteration >> observations: anObservationCollection [
	observations := anObservationCollection
]
