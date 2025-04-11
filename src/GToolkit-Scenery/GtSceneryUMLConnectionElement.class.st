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
	super updateAppearance.
	self updateValidityColor
]

{ #category : #validity }
GtSceneryUMLConnectionElement >> updateValidityColor [
	| connection |
	connection := self graph model.
	connection isValid
		ifTrue: [ self borderColor: self validForegroundColor ]
		ifFalse: [ self borderColor: self invalidForegroundColor ].
	self updateConnectionColor: self borderColor
]

{ #category : #acccessing }
GtSceneryUMLConnectionElement >> validForegroundColor [
	^ self borderColor
]
