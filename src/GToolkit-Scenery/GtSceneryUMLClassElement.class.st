Class {
	#name : #GtSceneryUMLClassElement,
	#superclass : #GtSceneryTextLabelElement,
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #initialization }
GtSceneryUMLClassElement >> initializeLabelAptitude [
	"Black, rectangular border."

	labelAptitude := BrGlamorousEditableLabelAptitude new
			glamorousRegularFont.
	labelAptitude styleLook
		default: [ :aStyle | 
			aStyle geometry: (BlRoundedRectangleGeometry cornerRadius: 0).
			aStyle background: Color white.
			aStyle border: (BlBorder paint: Color black width: 2) ].
	^ labelAptitude
]

{ #category : #initialization }
GtSceneryUMLClassElement >> stencilClass [
	^ GtSceneryUMLClassStencil
]

{ #category : #accessing }
GtSceneryUMLClassElement >> text: aText [
	super text: aText.
	self text when: BlTextStringsInserted do: [ self updateForegroundColor ].
	self text when: BlTextsDeleted do: [ self updateForegroundColor ]
]

{ #category : #validity }
GtSceneryUMLClassElement >> umlStencil [
	^ self graph model stencil
]

{ #category : #validity }
GtSceneryUMLClassElement >> updateForegroundColor [
	"The foreground color of the text after editing can be reset by the aptitude."

	self umlStencil isValid
		ifTrue: [ self labelAptitude defaultForeground: self umlStencil validForegroundColor ]
		ifFalse: [ self labelAptitude defaultForeground: self umlStencil invalidForegroundColor ].
	self aptitude: self labelAptitude
]
