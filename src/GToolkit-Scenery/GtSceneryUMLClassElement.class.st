Class {
	#name : #GtSceneryUMLClassElement,
	#superclass : #GtSceneryTextLabelElement,
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #initialization }
GtSceneryUMLClassElement >> defaultLabelAptitude [
	"Black, rectangular border."

	| labelAptitude |
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
