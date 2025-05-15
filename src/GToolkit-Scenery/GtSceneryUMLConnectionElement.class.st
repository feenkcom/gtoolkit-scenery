Class {
	#name : #GtSceneryUMLConnectionElement,
	#superclass : #GtSceneryCurvableConnectionElement,
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #acccessing }
GtSceneryUMLConnectionElement >> invalidForegroundColor [
	^ Color red
]

{ #category : #announcements }
GtSceneryUMLConnectionElement >> updateAppearance [
	self updateValidityColor.
	super updateAppearance
]

{ #category : #validity }
GtSceneryUMLConnectionElement >> updateValidityColor [
	"The actual visual update is made by updateAppearance."

	| connection |
	connection := self graph model.
	connection isValid
		ifTrue: [ self borderColor: self validForegroundColor ]
		ifFalse: [ self borderColor: self invalidForegroundColor ]
]

{ #category : #acccessing }
GtSceneryUMLConnectionElement >> validForegroundColor [
	^ self borderColor
]
