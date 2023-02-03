Class {
	#name : #GtSceneryRectangleStencil,
	#superclass : #GtSceneryDraggableItem,
	#instVars : [
		'targetBlock'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryRectangleStencil >> create [
	^ BlElement new
				size: extent;
				background: Color white;
				border: Color black;
				margin: (BlInsets all: 10)
]

{ #category : #accessing }
GtSceneryRectangleStencil >> initialize [
	super initialize.
	targetBlock := [ nil ].
	extent := 200 @ 300
]
