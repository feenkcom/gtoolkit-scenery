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
