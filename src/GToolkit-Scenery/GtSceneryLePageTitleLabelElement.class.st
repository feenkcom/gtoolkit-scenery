Class {
	#name : #GtSceneryLePageTitleLabelElement,
	#superclass : #GtSceneryTextLabelElement,
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #accessing }
GtSceneryLePageTitleLabelElement >> hoverColor [
	"Currently not used as it is not clear how not to compute the hover color eagerly."

	| item |
	item := self graph model.
	^ item ifNil: [ Color paleGreen ] ifNotNil: [ item stencil hoverColor ]
]

{ #category : #initalization }
GtSceneryLePageTitleLabelElement >> initialize [
	super initialize.
	self
		when: BlMouseEnterEvent
		do: [ :e | self stencil ifNotNil: [ self stencil fitHorizontally ] ]
]

{ #category : #initalization }
GtSceneryLePageTitleLabelElement >> initializeLabelAptitude [
	"Default label with white background, and no border."

	"labelAptitude :=
		BrGlamorousLabelAptitude new bold
				+ (BrStyleCommonAptitude new
						hovered: [ :aStyle | aStyle background: self hoverColor ])."

	<todo: 'The hover color is eagerly computed by BrStyleAptitude>>#when:style: -- how can we look it up dynamically?'>
	
	labelAptitude := BrGlamorousEditableLabelAptitude new
			glamorousRegularFontAndSize bold
			defaultBackground: Color white;
			yourself.

	labelAptitude styleLook
		default: [ :aStyle | 
			aStyle geometry: (BlRoundedRectangleGeometry cornerRadius: 0).
			aStyle background: Color white.
			aStyle border: BlBorder empty ].

	"labelAptitude styleLook
		when: [ :aState | aState hovered and: BrEditorModeState readOnly ]
		style: [ :aStyle | aStyle background: self hoverColor ]."


	^ labelAptitude
]

{ #category : #initalization }
GtSceneryLePageTitleLabelElement >> stencilClass [
	^ GtSceneryLePageTitleLabelStencil
]
