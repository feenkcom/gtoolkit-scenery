Class {
	#name : #GtSceneryInspectorStencil,
	#superclass : #GtSceneryDraggableItem,
	#instVars : [
		'targetBlock'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryInspectorStencil >> create [
	^ (self targetValue gtViewsFor: GtPhlowView empty)
		asElementDo: [ :e | 
			e
				size: extent;
				background: Color white;
				margin: (BlInsets all: 10);
				addAptitude: BrShadowAptitude ]
]

{ #category : #accessing }
GtSceneryInspectorStencil >> initialize [
	super initialize.
	targetBlock := [ nil ].
	extent := 200@400.
]

{ #category : #accessing }
GtSceneryInspectorStencil >> storeOn: aStream [
	super storeOn: aStream.
	aStream
		nextPutAll: '; ';
		nextPutAll: 'target: ', targetBlock asString
]

{ #category : #accessing }
GtSceneryInspectorStencil >> target: aBlock [
	targetBlock := aBlock 
]

{ #category : #accessing }
GtSceneryInspectorStencil >> targetValue [
	^ targetBlock value
]
