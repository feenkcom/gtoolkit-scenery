"
I am a BlParabollaArcElement that can be extended with Connection-specific behavior.
"
Class {
	#name : #GtSceneryCurvableConnectionElement,
	#superclass : #BlParabollaArcElement,
	#traits : 'TGtSceneryUpdatableElement',
	#classTraits : 'TGtSceneryUpdatableElement classTrait',
	#instVars : [
		'label'
	],
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #accessing }
GtSceneryCurvableConnectionElement >> borderColor [
	^ Color black
]

{ #category : #initalization }
GtSceneryCurvableConnectionElement >> initialize [
	super initialize.
	self border: (BlBorder paint: self borderColor width: 1).
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

{ #category : #announcements }
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
	self toHead: stencil arrowHead
]

{ #category : #painting }
GtSceneryCurvableConnectionElement >> updateConnectionColor: aColor [
	self border: (BlBorder paint: aColor)
]
