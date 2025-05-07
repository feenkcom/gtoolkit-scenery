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

{ #category : #printing }
GtSceneryCurvableConnectionStencil >> arrowHeadType [
	^ arrowHeadType
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> arrowHeadType: aSymbol [
	self assert: (self arrowHeadTypes includes: aSymbol asSymbol).
	arrowHeadType := aSymbol asSymbol.
	self announceStencilUpdate
]

{ #category : #acccessing }
GtSceneryCurvableConnectionStencil >> arrowHeadTypes [
	^ {#simple.
		#triangle.
		#none}
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

{ #category : #menu }
GtSceneryCurvableConnectionStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	^ BrMenuItems new
		addItemLabel: 'Modify curvature'
			submenu: (BrMenuItems new
					addItemLabel: 'Curve positively'
						action: [ self curvatureFraction: self curvatureFraction + self curvatureDelta ];
					addItemLabel: 'Curve negatively'
						action: [ self curvatureFraction: self curvatureFraction - self curvatureDelta ];
					addItemLabel: 'Be straight' action: [ self curvatureFraction: 0 ];
					yourself);
		addItemLabel: 'Arrowhead'
			submenu: [ | submenu |
				submenu := BrMenuItems new yourself.
				self arrowHeadTypes
					do: [ :each | 
						submenu
							addItemLabel: each asString capitalized
							action: [ self arrowHeadType: each ] ].
				submenu ] value;
		yourself
]

{ #category : #printing }
GtSceneryCurvableConnectionStencil >> storeOnAttributes [
	^ {#labelText.
		#fontSize.
		#arrowHeadType.
		#curvatureFraction}
]
