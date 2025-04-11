Class {
	#name : #GtSceneryUMLConnectionElement,
	#superclass : #GtSceneryCurvableConnectionElement,
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #acccessing }
GtSceneryUMLConnectionElement >> invalidForegroundColor [
	^ Color red
]

{ #category : #'as yet unclassified' }
GtSceneryUMLConnectionElement >> updateAppearance [
	"Hook for GtSceneryItemUpdated announcements."

	super updateAppearance.
	
	"NOT YET WORKING CORRECTLY"
	
	"self updateValidityColor"
]

{ #category : #validity }
GtSceneryUMLConnectionElement >> updateValidityColor [
	"This should be done with the help of listeners whenever the connection changes."

	<tag: #shouldBeHandledByAnnouncement>
	| connection |
	connection := self graph model.
	self
		updateConnectionColor: (connection isValid
				ifTrue: [ self validForegroundColor ]
				ifFalse: [ self invalidForegroundColor ])
]

{ #category : #acccessing }
GtSceneryUMLConnectionElement >> validForegroundColor [
	^ Color black
]
