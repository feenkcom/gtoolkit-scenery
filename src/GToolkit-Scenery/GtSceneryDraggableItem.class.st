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
	extent := 50 @ 50
]

{ #category : #accessing }
GtSceneryDraggableItem >> storeOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: ' new'
]
