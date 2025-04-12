"
I am a BlParabollaArcElement that can be extended with Connection-specific behavior.
"
Class {
	#name : #GtSceneryCurvableConnectionElement,
	#superclass : #BlParabollaArcElement,
	#traits : 'TGtSceneryConnectionElement',
	#classTraits : 'TGtSceneryConnectionElement classTrait',
	#instVars : [
		'label',
		'borderColor',
		'borderWidth'
	],
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #accessing }
GtSceneryCurvableConnectionElement >> borderColor [
	"May be dynamically updated in subclasses."

	^ borderColor ifNil: [ borderColor := Color black ]
]

{ #category : #accessing }
GtSceneryCurvableConnectionElement >> borderColor: aColor [
	borderColor := aColor
]

{ #category : #accessing }
GtSceneryCurvableConnectionElement >> borderWidth [
	^ borderWidth ifNil: [ borderWidth := 2 ]
]

{ #category : #accessing }
GtSceneryCurvableConnectionElement >> borderWidth: aNumber [
	borderWidth := aNumber
]

{ #category : #accessing }
GtSceneryCurvableConnectionElement >> hoverColor [
	^ Color blue
]

{ #category : #initalization }
GtSceneryCurvableConnectionElement >> initialize [
	super initialize.
	"self border: (BlBorder paint: self borderColor width: self borderWidth)."
	label := (BrLabel new
						background: Color white;
						margin: (BlInsets top: 10);
						constraintsDo: [ :c | 
							c ignored vertical alignCenterAt: 0.3.
							c ignored horizontal alignCenter.
							c ignoreByLayout ]).
	self addChild: self label.
	self label visibility: BlVisibility gone.
	self
		clipChildren: false;
		zIndex: -100
]

{ #category : #accessing }
GtSceneryCurvableConnectionElement >> label [
	^ label
]

{ #category : #painting }
GtSceneryCurvableConnectionElement >> resetConnectionColor [
	self border: (BlBorder paint: self borderColor width: self borderWidth)
]

{ #category : #painting }
GtSceneryCurvableConnectionElement >> setHoverConnectionColor [
	self border: (BlBorder paint: self hoverColor width: self borderWidth)
]

{ #category : #'as yet unclassified' }
GtSceneryCurvableConnectionElement >> updateAppearance [
	| stencil |
	stencil := self graph model stencil.
	self curvatureFraction: stencil curvatureFraction.
	stencil labelText notNil
		ifTrue: [ self label
				text: stencil labelText;
				background: Color white;
				aptitude: (BrGlamorousLabelAptitude new fontSize: stencil fontSize).
			self label visibility: BlVisibility visible ]
		ifFalse: [ self label visibility: BlVisibility gone ].
	self toHead: stencil arrowHead.
	self resetConnectionColor
]
