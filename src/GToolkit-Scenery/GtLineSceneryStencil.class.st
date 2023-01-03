Class {
	#name : #GtLineSceneryStencil,
	#superclass : #GtSceneryItemStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtLineSceneryStencil >> borderColor [
	^ Color black
]

{ #category : #accessing }
GtLineSceneryStencil >> create [
	| line |
	line := BlLineElement new
			border: (BlBorder paint: self borderColor width: 1);
			zIndex: -100;
			toHead: (BlArrowheadSimpleArrow new
					background: Color black;
					border: (BlBorder paint: Color black width: 5)).
	^ line
]
