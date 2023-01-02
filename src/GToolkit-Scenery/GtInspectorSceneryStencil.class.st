Class {
	#name : #GtInspectorSceneryStencil,
	#superclass : #GtSceneryDraggableItem,
	#instVars : [
		'targetBlock'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtInspectorSceneryStencil >> create [
	^ (self targetValue gtViewsFor: GtPhlowView empty)
		asElementDo: [ :e | 
			e
				size: extent;
				background: Color white;
				margin: (BlInsets all: 10);
				addAptitude: BrShadowAptitude ]
]

{ #category : #accessing }
GtInspectorSceneryStencil >> initialize [
	super initialize.
	targetBlock := [ nil ].
	extent := 200@400.
]

{ #category : #accessing }
GtInspectorSceneryStencil >> target: aBlock [
	targetBlock := aBlock 
]

{ #category : #accessing }
GtInspectorSceneryStencil >> targetValue [
	^ targetBlock value
]
