"
I am a stencil for a curved connection between scenery items.

Probably you should use `GtSceneryCurvableConnectionStencil` instead.
"
Class {
	#name : #GtSceneryParabollaArcStencil,
	#superclass : #GtSceneryConnectionStencil,
	#instVars : [
		'labelText',
		'fontSize',
		'arrowLengthFraction',
		'curvatureFraction',
		'arrowHeadType'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryParabollaArcStencil >> arrowHead [
	self arrowHeadType = #triangle ifTrue: [ ^ self triangleArrowHead ].
	^ self simpleArrowHead
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> arrowHeadType [
	^ arrowHeadType ifNil: [ arrowHeadType := self defaultArrowHeadType ]
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> arrowHeadType: aSymbol [
	"Currently #simple or #triangle"
	arrowHeadType := aSymbol
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> arrowLengthFraction [
	^ arrowLengthFraction
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> arrowLengthFraction: aSize [
	arrowLengthFraction := aSize
]

{ #category : #initialization }
GtSceneryParabollaArcStencil >> beStraight [
	"Make me look like GtSceneryLineStencil"

	labelText := nil.
	fontSize := 20.
	arrowLengthFraction := 2.5.
	curvatureFraction := 0
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> borderColor [
	^ Color black
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> create [
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
GtSceneryParabollaArcStencil >> curvatureFraction [
	^ curvatureFraction
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> curvatureFraction: aFraction [
	curvatureFraction := aFraction
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> defaultArrowHeadType [
	^ #simple
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> fontSize [
	^ fontSize
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> fontSize: aFontSize [
	fontSize := aFontSize
]

{ #category : #initialization }
GtSceneryParabollaArcStencil >> initialize [
	super initialize.
	labelText := nil.
	fontSize := 20.
	arrowLengthFraction := 10.
	curvatureFraction := 0.2.
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> labelText [
	^ labelText
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> labelText: aText [
	labelText := aText
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> simpleArrowHead [
	^ BlArrowheadSimpleArrow new
		background: Color black;
		arrowLengthFraction: self arrowLengthFraction;
		border: (BlBorder paint: Color black)
]

{ #category : #printing }
GtSceneryParabollaArcStencil >> storeOn: aStream [
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
		nextPutAll: '; arrowLengthFraction: '.
	self arrowLengthFraction storeOn: aStream.
	aStream 
		nextPutAll: '; arrowHeadType: '.
	self arrowHeadType storeOn: aStream.
	aStream 
		nextPutAll: '; yourself'.
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> triangleArrowHead [
	^ BlArrowheadTriangle new
		scale: 4;
		border: (BlBorder paint: Color black)
]

{ #category : #'context menu' }
GtSceneryParabollaArcStencil >> updateItemContextMenuItems: aBrMenuItems forSceneryElement: aGtSceneryElement andChildElement: aChildElement [
	"NB: Since we create a plain BlParabollaArcElement we cannot set up announcements to update the element when the connection stencil changes, so we just locally redisplay the scenery element instead."
	| curvatureSubMenuItems brMenuItems |
	brMenuItems := super updateItemContextMenuItems: aBrMenuItems forSceneryElement: aGtSceneryElement andChildElement: aChildElement.
	
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
