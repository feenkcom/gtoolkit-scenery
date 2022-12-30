Class {
	#name : #GtSceneryElement,
	#superclass : #BlElement,
	#instVars : [
		'container'
	],
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #accessing }
GtSceneryElement >> addSceneryChild: anElement [ 
	| wrapper |
	wrapper := BrVerticalPane new fitContent addEventHandler: BlPullHandler new.
	wrapper addChild: anElement.
	container addChild: wrapper.
]

{ #category : #accessing }
GtSceneryElement >> initialize [
	super initialize.
	container := BlCanvassableElement new
		background: Color white;
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ].
	self addChild: container
]

{ #category : #accessing }
GtSceneryElement >> zoomLevel: aNumber [ 
	container zoomLevel: aNumber
]
