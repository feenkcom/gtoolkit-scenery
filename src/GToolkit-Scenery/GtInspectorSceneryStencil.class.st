Class {
	#name : #GtInspectorSceneryStencil,
	#superclass : #GtSceneryItem,
	#instVars : [
		'targetBlock'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtInspectorSceneryStencil >> createContent [
	^ (self targetValue gtViewsFor: GtPhlowView empty)
		asElementDo: [ :e | 
			e
				size: size;
				background: Color white;
				margin: (BlInsets all: 10);
				addAptitude: BrShadowAptitude ]
]

{ #category : #accessing }
GtInspectorSceneryStencil >> initialize [
	super initialize.
	targetBlock := [ nil ].
	size := 200 @ 300
]

{ #category : #accessing }
GtInspectorSceneryStencil >> position: aPoint [ 
	position := aPoint
]

{ #category : #accessing }
GtInspectorSceneryStencil >> target: aBlock [
	targetBlock := aBlock 
]

{ #category : #accessing }
GtInspectorSceneryStencil >> targetValue [
	^ targetBlock value
]
