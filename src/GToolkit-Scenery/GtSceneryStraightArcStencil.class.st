"
I am a convenience class. I look like a straight line, but in fact I can be curved positively or negatively.
"
Class {
	#name : #GtSceneryStraightArcStencil,
	#superclass : #GtSceneryCurvableConnectionStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #initialization }
GtSceneryStraightArcStencil >> initialize [
	super initialize.
	self beStraight
]
