Class {
	#name : #GtSceneryUMLClassElement,
	#superclass : #GtSceneryTextLabelElement,
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #initalization }
GtSceneryUMLClassElement >> initialize [
	super initialize.
	self
		when: BlMouseEnterEvent
		do: [ :e | self stencil ifNotNil: [ self stencil fitHorizontally ] ]
]

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

{ #category : #validity }
GtSceneryUMLClassElement >> umlStencil [
	^ self graph model stencil
]

{ #category : #announcements }
GtSceneryUMLClassElement >> updateAppearance [
	"Hook for GtSceneryItemUpdated announcements."

	super updateAppearance.
	self
		hFitContent;
		vFitContent.
	self updateForegroundColor
]

{ #category : #validity }
GtSceneryUMLClassElement >> updateForegroundColor [
	"The foreground color of the text after editing can be reset by the aptitude."

	self labelAptitude
		defaultForeground: (self umlStencil isValidClass
				ifTrue: [ self umlStencil validForegroundColor ]
				ifFalse: [ self umlStencil invalidForegroundColor ]).
]
