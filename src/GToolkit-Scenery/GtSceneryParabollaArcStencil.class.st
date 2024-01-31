Class {
	#name : #GtSceneryParabollaArcStencil,
	#superclass : #GtSceneryItemStencil,
	#instVars : [
		'labelText',
		'fontSize',
		'arrowLengthFraction',
		'curvatureFraction'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryParabollaArcStencil >> arrowLengthFraction [
	^ arrowLengthFraction
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> arrowLengthFraction: aSize [
	arrowLengthFraction := aSize
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
	line := line
			toHead: (BlArrowheadSimpleArrow new
					background: Color black;
					arrowLengthFraction: self arrowLengthFraction;
					border: (BlBorder paint: Color black)).
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
GtSceneryParabollaArcStencil >> fontSize [
	^ fontSize
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> fontSize: aFontSize [
	fontSize := aFontSize
]

{ #category : #accessing }
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
GtSceneryParabollaArcStencil >> labelText: anObject [
	labelText := anObject
]

{ #category : #printing }
GtSceneryParabollaArcStencil >> storeOn: aStream [
	super storeOn: aStream.
	aStream 
		nextPutAll: ' labelText: '.
	self labelText storeOn: aStream.
	aStream 
		nextPutAll: '; curvatureFraction: '.
	self curvatureFraction storeOn: aStream.
	aStream 
		nextPutAll: '; arrowLengthFraction: '.
	self arrowLengthFraction storeOn: aStream.
	aStream 
		nextPutAll: '; yourself'.
]
