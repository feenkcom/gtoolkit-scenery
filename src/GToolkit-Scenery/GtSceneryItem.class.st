Class {
	#name : #GtSceneryItem,
	#superclass : #BrStencil,
	#instVars : [
		'position',
		'size'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryItem >> create [
	^ self createContent
		addEventHandler: BlPullHandler new;
		addAptitude: BrGlamorousWithVerticalResizerAptitude
				+ BrGlamorousWithHorizontalResizerAptitude;
		relocate: position
]

{ #category : #accessing }
GtSceneryItem >> createContent [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtSceneryItem >> initialize [ 
	super initialize.
	position := 0@0.
	size := 50 @ 50
]
