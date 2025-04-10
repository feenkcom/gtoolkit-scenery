Trait {
	#name : #TAMUtility,
	#category : #'GToolkit-Scenery-Mining'
}

{ #category : #'as yet unclassified' }
TAMUtility >> gtExamplesFor: aView with: examples [
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

{ #category : #'as yet unclassified' }
TAMUtility >> gtObservationsFor: aView with: observations [
	"To be used in <gtView> method for a given observations list."

	^ aView columnedList
		title: 'Observations';
		priority: 10;
		items: [ observations associations collect: [ :keyVal | AMObservation for: keyVal ] ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Key' text: [ :each | each key gtDisplayString ];
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each key -> each value ];
		actionUpdateButton
]
