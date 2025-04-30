"
I represent an example instance for mining associations between classes.

I consist of an object, and a path. 

The  path is a sequence of symbols, starting with a class or a literal, followed by a sequence of unary message sends, which, when evaluated, produce the object.

In the ideal case, I start as a gtExample, followed by zero or more unary sends.

"
Class {
	#name : #AMExample,
	#superclass : #Object,
	#traits : 'TAMUtility',
	#classTraits : 'TAMUtility classTrait',
	#instVars : [
		'object',
		'timeToRun',
		'path',
		'timeOut'
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

{ #category : #'instance creation' }
AMExample class >> path: anArray [
	^ self new
		path: anArray;
		initializeObjectFromPath;
		yourself
]

{ #category : #converting }
AMExample >> asBlockClosure [
	^ Smalltalk compiler evaluate: self asBlockString
]

{ #category : #converting }
AMExample >> asBlockString [
	^ '[ ' , path first printString , ' ' , (' ' join: path allButFirst) , ' ]'
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

{ #category : #initialization }
AMExample >> defaultTimeOut [
	^ 10 milliseconds
]

{ #category : #initalization }
AMExample >> evaluatePath [
	| result |
	self assert: self path notNil.
	self assert: self path isNotEmpty.
	result := path first.
	path allButFirst do: [ :sel | result := result perform: sel ].
	^ result
]

{ #category : #instantiation }
AMExample >> freshObject [
	"Return a new object instance."

	^ self evaluatePath
]

{ #category : #views }
AMExample >> gtObjectFor: aView [
	<gtView>
	^ aView forward
		title: 'Object';
		priority: 10;
		object: [ self object ];
		view: self objectViewSelector
]

{ #category : #views }
AMExample >> gtPathFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Path';
		priority: 40;
		items: [ self path ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #views }
AMExample >> gtSuccessorsFor: aView [
	<gtView>
	^ (self gtExamplesFor: aView with: self successors)
		title: 'Successors';
		priority: 35
]

{ #category : #views }
AMExample >> gtUnaryMethodsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Unary methods';
		priority: 30;
		items: [ self unaryMethods ];
		column: 'Method' text: [ :each | each gtDisplayString ]
]

{ #category : #initialization }
AMExample >> initializeFromClass: aClass [
	path := {aClass.
			#new}.
	self initializeObject: [ aClass new ]
]

{ #category : #initialization }
AMExample >> initializeFromFactoryMethod: aFactoryMethod [
	path := {aFactoryMethod methodClass.
			aFactoryMethod selector}.
	self
		initializeObject: [ aFactoryMethod methodClass perform: aFactoryMethod selector ]
]

{ #category : #initialization }
AMExample >> initializeFromGtExample: gtExampleMethod [
	path := {gtExampleMethod methodClass.
			#new.
			gtExampleMethod selector}.
	self initializeObject: [ gtExampleMethod gtExample result returnValue ]
]

{ #category : #initialization }
AMExample >> initializeObject: aBlock [
	[ timeToRun := [ object := aBlock onErrorDo: [ :err | err ] ] timeToRun ]
		valueWithin: self timeOut
		onTimeout: [ object := TimedOut new
					messageText: 'Exceeded timeout ' , self timeOut printString ]
]

{ #category : #accessing }
AMExample >> initializeObjectFromPath [
	^ object := self evaluatePath
]

{ #category : #'instance creation' }
AMExample >> navigateToSuccessorSending: aSelector [
	^ AMExample new
		path: self path , {aSelector};
		object: ([ self freshObject perform: aSelector ] onErrorDo: [ :err | err ]);
		yourself
]

{ #category : #accessing }
AMExample >> object [
	^ object ifNil: [ self initializeObjectFromPath ]
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
AMExample >> objectViewSelector [
	"NB: We do not know a priori if there is a #gtLiveFor: view, so instead we just select the first nonempty view provided by the object, in priority order."

	^ ((self object gtViewsInCurrentContext
		reject: [ :v | v isKindOf: GtPhlowEmptyView ]) sortedAs: #priority) first
		methodSelector
]

{ #category : #accessing }
AMExample >> path [
	^ path
]

{ #category : #accessing }
AMExample >> path: anArray [
	"A receiver (class or literal) and a sequence of message sends (selectors)."

	path := anArray
]

{ #category : #printing }
AMExample >> printOn: aStream [
	"super printOn: aStream."
	aStream nextPutAll: self asBlockString
]

{ #category : #querying }
AMExample >> successors [
	"NB: This produces all possible clean successors, not just instances of the classes of interest.
	Do we need this?"

	^ (self unaryMethods
		collect: [ :m | self navigateToSuccessorSending: m selector ])
		collect: #clean
		thenSelect: [ :eg | eg notNil ]
]

{ #category : #initialization }
AMExample >> timeOut [
	^ timeOut ifNil: [ timeOut := self defaultTimeOut ]
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
	^ self objectClass methods
		select: [ :m | m selector isUnary and: [ m isDeprecated not ] ]
]

{ #category : #accessing }
AMExample >> witnesses [
	^ self unaryMethods
		collect: [ :m | 
			| successor |
			successor := self navigateToSuccessorSending: m selector.

			AMWitness
				example: self
				message: m selector
				result: successor ]
]
