Class {
	#name : #GtSceneryParabollaArcStencil,
	#superclass : #GtSceneryItemStencil,
	#instVars : [
		'labelText'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryParabollaArcStencil >> borderColor [
	^ Color black
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> create [
	| line |
	line := BlParabollaArcElement new
			clipChildren: false;
			curvatureFraction: 0.2;
			border: (BlBorder paint: self borderColor width: 1);
			zIndex: -100.
	labelText notNil
		ifTrue: [ line
				addChild: (BrLabel new
						text: labelText;
						background: Color white;
						aptitude: (BrGlamorousLabelAptitude new fontSize: 20);
						margin: (BlInsets top: 10);
						constraintsDo: [ :c | 
							c ignored vertical alignCenterAt: 0.3.
							c ignored horizontal alignCenter.
							c ignoreByLayout ]) ].
	line := line
			toHead: (BlArrowheadSimpleArrow new
					background: Color black;
					arrowLengthFraction: 10;
					border: (BlBorder paint: Color black)).
	^ line
]

{ #category : #accessing }
GtSceneryParabollaArcStencil >> initialize [ 
	super initialize.
	labelText := nil.
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
	aStream nextPutAll: ' labelText: '.
	self labelText storeOn: aStream
]
