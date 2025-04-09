"
I am the prefix of an AMAssociation, namely just the source and the message.

I serve to partition sets of observations into those with the same source and message, but possibly different targets.
"
Class {
	#name : #AMPreAssociation,
	#superclass : #Object,
	#instVars : [
		'source',
		'message'
	],
	#category : #'GToolkit-Scenery-Mining'
}

{ #category : #'instance creation' }
AMPreAssociation class >> source: aSourceClass message: aSelector [
	^ self new
		source: aSourceClass;
		message: aSelector;
		yourself
]

{ #category : #comparding }
AMPreAssociation >> = other [
	super = other ifTrue: [ ^ true ].
	^ self ~ other
]

{ #category : #comparding }
AMPreAssociation >> hash [
	^ self source hash bitXor: self message hash
]

{ #category : #accessing }
AMPreAssociation >> message [
	^ message
]

{ #category : #accessing }
AMPreAssociation >> message: aSelector [
	message := aSelector
]

{ #category : #'as yet unclassified' }
AMPreAssociation >> printOn: aStream [
	aStream
		nextPut: $<;
		nextPutAll: self source name;
		nextPut: $,;
		nextPutAll: self message;
		nextPut: $>
]

{ #category : #accessing }
AMPreAssociation >> source [
	^ source
]

{ #category : #accessing }
AMPreAssociation >> source: aClass [
	source := aClass
]

{ #category : #comparding }
AMPreAssociation >> ~ other [
	self class = other class ifFalse: [ ^ false ].
	^ self source = other source and: [ self message = other message ]
]
