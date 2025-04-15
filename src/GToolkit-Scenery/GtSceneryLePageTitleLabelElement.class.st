Class {
	#name : #GtSceneryLePageTitleLabelElement,
	#superclass : #GtSceneryTextLabelElement,
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #'as yet unclassified' }
GtSceneryLePageTitleLabelElement >> hoverColor [
	"^ self database
		pageNamed: self title
		ifPresent: [ Color paleBlue ]
		ifAbsent: [ Color pink ]"
	^ Color paleBlue
]

{ #category : #initalization }
GtSceneryLePageTitleLabelElement >> initializeLabelAptitude [
	"Default label with grey background, rounded rectangle and no border."

	labelAptitude := (BrGlamorousEditableLabelAptitude new
			glamorousRegularFontAndSize bold
			defaultBackground: Color white;
			yourself)
			+ (BrStyleCommonAptitude new
					hovered: [ :aStyle | aStyle background: self hoverColor ]).
	^ labelAptitude
]

{ #category : #initalization }
GtSceneryLePageTitleLabelElement >> stencilClass [
	^ GtSceneryLePageTitleLabelStencil
]
