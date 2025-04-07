"
I represent an example instance for mining associations between classes.

I consist of an object, and a path. 

The  path is a sequence of symbols, starting with a class or a literal, followed by a sequence of unary message sends, which, when evaluated, produce the object.

In the ideal case, I start as a gtExample, followed by zero or more unary sends.

"
Class {
	#name : #AMExample,
	#superclass : #Object,
	#instVars : [
		'object',
		'timeToRun',
		'path'
	],
	#category : #'GToolkit-Scenery-Mining'
}

{ #category : #'instance creation' }
AMExample class >> forClass: aClass [
	^ self new
		initializeFromClass: aClass;
		yourself
]

{ #category : #'instance creation' }
AMExample class >> forFactoryMethod: aMethod [
	^ self new
		initializeFromFactoryMethod: aMethod;
		yourself
]

{ #category : #'instance creation' }
AMExample class >> forGtExample: aMethod [
	^ self new
		initializeFromGtExample: aMethod;
		yourself
]

{ #category : #converting }
AMExample >> asBlockClosure [
	^ Smalltalk compiler evaluate: self asBlockString
]

{ #category : #converting }
AMExample >> asBlockString [
	^ '[ ' , path first name , ' ' , (' ' join: path allButFirst) , ' ]'
]

{ #category : #initalization }
AMExample >> evaluate [
	| result |
	result := path first.
	path allButFirst do: [ :sel | result := result perform: sel ].
	^ result
]

{ #category : #initialization }
AMExample >> initializeFromClass: aClass [
	path := {aClass.
			#new}.
	self initializeObjectFromPath
]

{ #category : #initialization }
AMExample >> initializeFromFactoryMethod: aFactoryMethod [
	path := {aFactoryMethod methodClass.
			aFactoryMethod selector}.
	self initializeObjectFromPath
]

{ #category : #initialization }
AMExample >> initializeFromGtExample: gtExampleMethod [
	path := {gtExampleMethod methodClass.
			#new.
			gtExampleMethod selector}.
	self initializeObjectFromPath
]

{ #category : #initialization }
AMExample >> initializeObjectFromPath [
	timeToRun := [ object := [ self evaluate ] onErrorDo: [ :err | err ] ]
			timeToRun
]

{ #category : #testing }
AMExample >> isError [
	^ self object isKindOf: Exception
]

{ #category : #accessing }
AMExample >> object [
	^ object
]

{ #category : #accessing }
AMExample >> path [
	^ path
]

{ #category : #'as yet unclassified' }
AMExample >> printOn: aStream [
	"super printOn: aStream."
	aStream nextPutAll: self asBlockString
]

{ #category : #accessing }
AMExample >> timeToRun [
	^ timeToRun
]
