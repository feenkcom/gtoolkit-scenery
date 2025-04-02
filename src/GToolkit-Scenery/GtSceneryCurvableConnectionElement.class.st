"
I am a BlParabollaArcElement that can be extended with Connection-specific behavior.
"
Class {
	#name : #GtSceneryCurvableConnectionElement,
	#superclass : #BlParabollaArcElement,
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #initalization }
GtSceneryCurvableConnectionElement >> initialize [
	super initialize.
	self
		clipChildren: false;
		zIndex: -100
]

{ #category : #painting }
GtSceneryCurvableConnectionElement >> updateConnectionColor: aColor [
	self border: (BlBorder paint: aColor)
]
