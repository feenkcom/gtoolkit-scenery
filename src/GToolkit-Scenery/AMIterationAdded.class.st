Class {
	#name : #AMIterationAdded,
	#superclass : #Announcement,
	#instVars : [
		'iteration'
	],
	#category : #'GToolkit-Scenery-Mining'
}

{ #category : #accessing }
AMIterationAdded >> iteration [
	^ iteration
]

{ #category : #accessing }
AMIterationAdded >> iteration: anObject [
	iteration := anObject
]
