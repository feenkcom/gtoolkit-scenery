Class {
	#name : #AMObservation,
	#superclass : #Object,
	#instVars : [
		'key',
		'value'
	],
	#category : #'GToolkit-Scenery-Mining'
}

{ #category : #views }
AMObservation class >> for: anAssociation [
	^ self new
		key: anAssociation key;
		value: anAssociation value;
		yourself
]

{ #category : #accessing }
AMObservation >> key [
	^ key
]

{ #category : #accessing }
AMObservation >> key: anObject [
	key := anObject
]

{ #category : #accessing }
AMObservation >> value [
	^ value
]

{ #category : #accessing }
AMObservation >> value: anObject [
	value := anObject
]
