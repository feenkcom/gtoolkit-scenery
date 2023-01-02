Class {
	#name : #GtSceneryDraggableItem,
	#superclass : #GtSceneryItemStencil,
	#instVars : [
		'extent'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryDraggableItem >> extent: aPoint [
	extent := aPoint
]

{ #category : #accessing }
GtSceneryDraggableItem >> initialize [ 
	super initialize.
	position := 0@0.
	extent := 50 @ 50
]

{ #category : #accessing }
GtSceneryDraggableItem >> position: aPoint [ 
	position := aPoint
]
