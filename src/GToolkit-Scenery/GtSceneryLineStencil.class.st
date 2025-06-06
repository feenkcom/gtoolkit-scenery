"
I am a stencil for a simple, straight line connection between items.

A better alternative is `GtSceneryCurvableConnectionStencil`.

"
Class {
	#name : #GtSceneryLineStencil,
	#superclass : #GtSceneryConnectionStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryLineStencil >> borderColor [
	^ Color black
]

{ #category : #accessing }
GtSceneryLineStencil >> create [
	| line |
	line := BlLineElement new
			border: (BlBorder paint: self borderColor width: 1);
			zIndex: -100;
			toHead: (BlArrowheadSimpleArrow new
					background: Color black;
					border: (BlBorder paint: Color black width: 5)).
	^ line
]
