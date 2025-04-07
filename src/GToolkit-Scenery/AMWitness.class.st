Class {
	#name : #AMWitness,
	#superclass : #Object,
	#instVars : [
		'example',
		'message',
		'result'
	],
	#category : #'GToolkit-Scenery-Mining'
}

{ #category : #accessing }
AMWitness class >> example: anAMExample message: aSelector result: otherAMExample [ 
^ self new
	example: anAMExample;
	message: aSelector;
	result: otherAMExample;
	yourself
]

{ #category : #accessing }
AMWitness >> example [
	^ example
]

{ #category : #accessing }
AMWitness >> example: anObject [
	example := anObject
]

{ #category : #accessing }
AMWitness >> message [
	^ message
]

{ #category : #accessing }
AMWitness >> message: anObject [
	message := anObject
]

{ #category : #accessing }
AMWitness >> result [
	^ result
]

{ #category : #accessing }
AMWitness >> result: anObject [
	result := anObject
]
