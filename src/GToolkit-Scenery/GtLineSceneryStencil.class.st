Class {
	#name : #GtLineSceneryStencil,
	#superclass : #GtSceneryItemStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtLineSceneryStencil >> create [
	| line |
	line := BlLineElement new
			border: (BlBorder paint: Color black);
			zIndex: 100;
			toHead: (BlArrowheadSimpleArrow new
								background: Color black;
								border: (BlBorder paint: Color black width: 5)).
	^ line
]
