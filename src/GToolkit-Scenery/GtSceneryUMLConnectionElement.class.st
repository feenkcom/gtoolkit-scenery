Class {
	#name : #GtSceneryUMLConnectionElement,
	#superclass : #GtSceneryCurvableConnectionElement,
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #acccessing }
GtSceneryUMLConnectionElement >> invalidForegroundColor [
	^ Color red
]

{ #category : #validity }
GtSceneryUMLConnectionElement >> updateValidityColorFor: aConnection [
	"This should be done with the help of listeners whenever the connection changes.
	Currently not used."

	<tag: #shouldBeHandledByAnnouncement>
	self
		updateConnectionColor: (aConnection isValid
				ifTrue: [ self validForegroundColor ]
				ifFalse: [ self invalidForegroundColor ])
]

{ #category : #acccessing }
GtSceneryUMLConnectionElement >> validForegroundColor [
	^ Color black
]
