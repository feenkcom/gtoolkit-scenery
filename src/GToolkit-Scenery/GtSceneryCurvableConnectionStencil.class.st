"
I am a stencil for a connection that is straight by default but can curved.

I started as a clone of {{gtClass:name=GtSceneryParabollaArcStencil}}, but I am straight instead of curved by default.
"
Class {
	#name : #GtSceneryCurvableConnectionStencil,
	#superclass : #GtSceneryConnectionStencil,
	#instVars : [
		'labelText',
		'fontSize',
		'curvatureFraction',
		'arrowHeadType'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> arrowHead [
	self arrowHeadType = #triangle ifTrue: [ ^ self triangleArrowHead ].
	^ self simpleArrowHead
]

{ #category : #printing }
GtSceneryCurvableConnectionStencil >> arrowHeadType [
	^ arrowHeadType
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> arrowHeadType: aSymbol [
	"Currently #simple or #triangle. Defaults to #simple."
	arrowHeadType := aSymbol
]

{ #category : #deprecated }
GtSceneryCurvableConnectionStencil >> arrowLengthFraction: aNumber [
	"deprecated -- ignored"

	
]

{ #category : #initialization }
GtSceneryCurvableConnectionStencil >> beStraight [
	self curvatureFraction: 0
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> borderColor [
	^ Color black
]

{ #category : #'instance creation' }
GtSceneryCurvableConnectionStencil >> create [
	^ self elementClass new
]

{ #category : #'context menu' }
GtSceneryCurvableConnectionStencil >> curvatureDelta [
	^ 0.2
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> curvatureFraction [
	^ curvatureFraction
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> curvatureFraction: aFraction [
	curvatureFraction := aFraction.
	self announceStencilUpdate
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> defaultArrowHeadType [
	^ #simple
]

{ #category : #initialization }
GtSceneryCurvableConnectionStencil >> defaultCurvatureFraction [
	^ 0.2
]

{ #category : #initialization }
GtSceneryCurvableConnectionStencil >> defaultFontSize [
	^ 12
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> defaultLabelText [
	"A nil label is not displayed"
	
	^ nil
]

{ #category : #'instance creation' }
GtSceneryCurvableConnectionStencil >> elementClass [
	^ GtSceneryCurvableConnectionElement
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> fontSize [
	^ fontSize
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> fontSize: aFontSize [
	fontSize := aFontSize.
	self announceStencilUpdate
]

{ #category : #initialization }
GtSceneryCurvableConnectionStencil >> initialize [
	super initialize.
	labelText := self defaultLabelText.
	fontSize := self defaultFontSize.
	arrowHeadType := self defaultArrowHeadType.
	curvatureFraction := self defaultCurvatureFraction
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> labelText [
	^ labelText
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> labelText: aText [
	labelText := aText.
	self announceStencilUpdate
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> simpleArrowHead [
	^ BlArrowheadSimpleArrow new
		background: Color black;
		border: (BlBorder paint: Color black)
]

{ #category : #printing }
GtSceneryCurvableConnectionStencil >> storeOnAttributes [
	^ {#labelText.
		#fontSize.
		#arrowHeadType.
		#curvatureFraction}
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> triangleArrowHead [
	^ BlArrowheadTriangle new
		scale: 4;
		border: (BlBorder paint: Color black)
]

{ #category : #'context menu' }
GtSceneryCurvableConnectionStencil >> updateItemContextMenuItems: aBrMenuItems forSceneryElement: aGtSceneryElement andChildElement: aChildElement [
	| curvatureSubMenuItems brMenuItems |
	brMenuItems := super
			updateItemContextMenuItems: aBrMenuItems
			forSceneryElement: aGtSceneryElement
			andChildElement: aChildElement.

	curvatureSubMenuItems := BrMenuItems new.
	curvatureSubMenuItems
		addItemLabel: 'Curve positively'
		action: [ self curvatureFraction: self curvatureFraction + self curvatureDelta ].
	curvatureSubMenuItems
		addItemLabel: 'Curve negatively'
		action: [ self curvatureFraction: self curvatureFraction - self curvatureDelta ].
	curvatureSubMenuItems
		addItemLabel: 'Be straight'
		action: [ self curvatureFraction: 0 ].

	brMenuItems
		addItem: (BrMenuSubmenuItem new
				label: 'Modify curvature';
				submenu: curvatureSubMenuItems).

	^ brMenuItems
]
