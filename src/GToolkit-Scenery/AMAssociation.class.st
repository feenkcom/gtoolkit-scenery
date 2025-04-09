Class {
	#name : #AMAssociation,
	#superclass : #AMPreAssociation,
	#instVars : [
		'target'
	],
	#category : #'GToolkit-Scenery-Mining'
}

{ #category : #'instance creation' }
AMAssociation class >> source: aSourceClass message: aSelector target: aTargetClass [
	^ self new
		source: aSourceClass;
		message: aSelector;
		target: aTargetClass;
		yourself
]

{ #category : #comparing }
AMAssociation >> = other [
	^ super = other and: [ self target = other target ]
]

{ #category : #converting }
AMAssociation >> asAnonymousAssociation [
	"Used to group associations with the same source and target."
	^ AMAssociation source: self source message: #anonymous target: self target
]

{ #category : #converting }
AMAssociation >> asPreassociation [
	^ AMPreAssociation source: self source message: self message
]

{ #category : #'instance creation' }
AMAssociation >> copyWithMessage: aSelector [
	^ self class source: self source message: aSelector target: self target
]

{ #category : #'instance creation' }
AMAssociation >> copyWithTarget: aTargetClass [
	^ self class source: self source message: self message target: aTargetClass
]

{ #category : #comparing }
AMAssociation >> hash [
	^ super hash bitXor: self target hash
]

{ #category : #printing }
AMAssociation >> printOn: aStream [
	aStream
		nextPut: $<;
		nextPutAll: self source name;
		nextPut: $,;
		nextPutAll: self message;
		nextPut: $,;
		nextPutAll: self target name;
		nextPut: $>
]

{ #category : #accessing }
AMAssociation >> target [
	^ target
]

{ #category : #accessing }
AMAssociation >> target: aClass [
	target := aClass
]
