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
	"Currently #simple or #triangle"
	arrowHeadType := aSymbol
]

{ #category : #deprecated }
GtSceneryCurvableConnectionStencil >> arrowLengthFraction: aNumber [
	"deprecated -- ignored"

	
]

{ #category : #initialization }
GtSceneryCurvableConnectionStencil >> beStraight [
	"Make me look like GtSceneryLineStencil"

	labelText := nil.
	fontSize := 20.
	arrowLengthFraction := 2.5.
	curvatureFraction := 0
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> borderColor [
	^ Color black
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> create [
	| line |
	line := BlParabollaArcElement new
			clipChildren: false;
			curvatureFraction: self curvatureFraction;
			border: (BlBorder paint: self borderColor width: 1);
			zIndex: -100.
	labelText notNil
		ifTrue: [ line
				addChild: (BrLabel new
						text: labelText;
						background: Color white;
						aptitude: (BrGlamorousLabelAptitude new fontSize: self fontSize);
						margin: (BlInsets top: 10);
						constraintsDo: [ :c | 
							c ignored vertical alignCenterAt: 0.3.
							c ignored horizontal alignCenter.
							c ignoreByLayout ]) ].
	line := line toHead: self arrowHead.
	^ line
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> curvatureFraction [
	^ curvatureFraction
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> curvatureFraction: aFraction [
	curvatureFraction := aFraction
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> defaultArrowHeadType [
	^ #simple
]

{ #category : #initialization }
GtSceneryCurvableConnectionStencil >> defaultCurvatureFraction [
	^ 0
]

{ #category : #initialization }
GtSceneryCurvableConnectionStencil >> defaultFontSize [
	^ 20
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> defaultLabelText [
	"A nil label is not displayed"
	
	^ nil
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> fontSize [
	^ fontSize
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> fontSize: aFontSize [
	fontSize := aFontSize
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
	labelText := aText
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> simpleArrowHead [
	^ BlArrowheadSimpleArrow new
		background: Color black;
		border: (BlBorder paint: Color black)
]

{ #category : #printing }
GtSceneryCurvableConnectionStencil >> storeOn: aStream [
	self storeWithAttributesOn: aStream
]

{ #category : #printing }
GtSceneryCurvableConnectionStencil >> storeOnAttributes [
	^ {#labelText.
		#fontSize.
		#arrowHeadType.
		#curvatureFraction}
]

{ #category : #printing }
GtSceneryCurvableConnectionStencil >> storeOnOLD: aStream [
	super storeOn: aStream.
	aStream 
		nextPutAll: ' labelText: '.
	self labelText storeOn: aStream.
	aStream 
		nextPutAll: '; fontSize: '.
	self fontSize storeOn: aStream.
	aStream 
		nextPutAll: '; curvatureFraction: '.
	self curvatureFraction storeOn: aStream.
	aStream 
		nextPutAll: '; arrowHeadType: '.
	self arrowHeadType storeOn: aStream.
	aStream 
		nextPutAll: '; yourself'.
]

{ #category : #accessing }
GtSceneryCurvableConnectionStencil >> triangleArrowHead [
	^ BlArrowheadTriangle new
		scale: 4;
		border: (BlBorder paint: Color black)
]

{ #category : #'context menu' }
GtSceneryCurvableConnectionStencil >> updateContextMenuItems: aBrMenuItems forSceneryElement: aGtSceneryElement andChildElement: aChildElement [
	| curvatureSubMenuItems brMenuItems |
	brMenuItems := super updateContextMenuItems: aBrMenuItems forSceneryElement: aGtSceneryElement andChildElement: aChildElement.
	
	curvatureSubMenuItems := BrMenuItems new.
	curvatureSubMenuItems
		addItemLabel: 'Curve positively'
		action: [ self curvatureFraction: 0.4.
			aGtSceneryElement redisplay ].
	curvatureSubMenuItems
		addItemLabel: 'Curve negatively'
		action: [ self curvatureFraction: -0.4.
			aGtSceneryElement redisplay ].
	curvatureSubMenuItems
		addItemLabel: 'Be straight'
		action: [ self curvatureFraction: 0.
			aGtSceneryElement redisplay ].

	brMenuItems
		addItem: (BrMenuSubmenuItem new
				label: 'Modify curvature';
				submenu: curvatureSubMenuItems).

	^ brMenuItems
]
