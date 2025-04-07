Class {
	#name : #AMAssociation,
	#superclass : #Object,
	#instVars : [
		'source',
		'message',
		'target'
	],
	#category : #'GToolkit-Scenery-Mining'
}

{ #category : #accessing }
AMAssociation class >> source: aSourceClass message: aSelector target: aTargetClass [
	^ self new
		source: aSourceClass;
		message: aSelector;
		target: aTargetClass;
		yourself
]

{ #category : #accessing }
AMAssociation >> message [
	^ message
]

{ #category : #accessing }
AMAssociation >> message: anObject [
	message := anObject
]

{ #category : #'as yet unclassified' }
AMAssociation >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self source name;
		nextPut: $,;
		nextPutAll: self message;
		nextPut: $,;
		nextPutAll: self target name;
		nextPut: $)
		
]

{ #category : #accessing }
AMAssociation >> source [
	^ source
]

{ #category : #accessing }
AMAssociation >> source: anObject [
	source := anObject
]

{ #category : #accessing }
AMAssociation >> target [
	^ target
]

{ #category : #accessing }
AMAssociation >> target: anObject [
	target := anObject
]
