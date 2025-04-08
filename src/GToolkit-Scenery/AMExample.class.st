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

{ #category : #accessing }
AMExample class >> send: aSelector to: anAMExample [
	"Generate a new example by navigating from an existing one."

	^ self new
		initializeFromExample: anAMExample sending: aSelector;
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

{ #category : #utility }
AMExample >> clean [
	"Return a clean example or nil.
	If the example is a collection, select any element, and modify the execution path."

	| someItem |
	self object ifNil: [ ^ nil ].
	(self object isKindOf: Exception) ifTrue: [ ^ nil ].
	(self object isKindOf: Collection)
		ifTrue: [ [ someItem := self object any ] onErrorDo: [ :err | ^ nil ].
			someItem ifNil: [ ^ nil ].
			(someItem isKindOf: Exception) ifTrue: [ ^ nil ].
			(someItem isKindOf: Collection) ifTrue: [ ^ nil ].
			^ AMExample new
				object: someItem;
				path: self path , {#any};
				timeToRun: self timeToRun;
				yourself ].
	^ self
]

{ #category : #initalization }
AMExample >> evaluate [
	| result |
	result := path first.
	path allButFirst do: [ :sel | result := result perform: sel ].
	^ result
]

{ #category : #views }
AMExample >> gtSuccessorsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Successors';
		priority: 10;
		items: [ self successors ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Class'
			text: [ :each  | each objectClass ]
			width: 150;
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #initialization }
AMExample >> initializeFromClass: aClass [
	path := {aClass.
			#new}.
	self initializeObjectFromPath
]

{ #category : #initialization }
AMExample >> initializeFromExample: anExample sending: aSelector [
	path := anExample path , {aSelector}.
	timeToRun := [ object := [ anExample object perform: aSelector ] onErrorDo: [ :err | err ] ]
			timeToRun
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

{ #category : #accessing }
AMExample >> object [
	^ object
]

{ #category : #accessing }
AMExample >> object: anObject [
	^ object := anObject
]

{ #category : #querying }
AMExample >> objectClass [
	^ self object class
]

{ #category : #accessing }
AMExample >> path [
	^ path
]

{ #category : #accessing }
AMExample >> path: anObject [
	path := anObject
]

{ #category : #printing }
AMExample >> printOn: aStream [
	"super printOn: aStream."
	aStream nextPutAll: self asBlockString
]

{ #category : #querying }
AMExample >> successors [
	"NB: This produces all possible successors, not just instances of the classes of interest."

	^ (self unaryMethods collect: [ :m | AMExample send: m selector to: self ])
		collect: #clean
		thenSelect: [ :eg | eg notNil ]
]

{ #category : #accessing }
AMExample >> timeToRun [
	^ timeToRun
]

{ #category : #accessing }
AMExample >> timeToRun: anObject [
	timeToRun := anObject
]

{ #category : #querying }
AMExample >> unaryMethods [
	^ self objectClass methods select: [ :m | m selector isUnary ]
]

{ #category : #accessing }
AMExample >> witnesses [
	^ self unaryMethods
		collect: [ :m | 
			| successor |
			successor := AMExample send: m selector to: self.

			AMWitness
				example: self
				message: m selector
				result: successor ]
]
