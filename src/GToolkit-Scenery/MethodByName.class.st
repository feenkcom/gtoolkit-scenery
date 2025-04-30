"
I am a simple utility to  convert stored method names into compiled methods.

I can either be  used as a checker:

MethodByName new methodForName: 'Foo>>#bar'

or as a holder of a method and name.


(MethodByName for: 'Foo>>#bar') method

(MethodByName for: 'Foo>>#bar') name

I can be initialized by either a string or a method.

(MethodByName for: Foo>>#bar) method

"
Class {
	#name : #MethodByName,
	#superclass : #Object,
	#instVars : [
		'method',
		'name'
	],
	#category : #'GToolkit-Scenery-Utilities'
}

{ #category : #utility }
MethodByName class >> for: aStringOrMethod [
	| exampleMethodName |
	aStringOrMethod isString
		ifTrue: [ exampleMethodName := aStringOrMethod ]
		ifFalse: [ self assert: aStringOrMethod isCompiledMethod.
			exampleMethodName := aStringOrMethod printString ].

	^ self new
		name: exampleMethodName;
		yourself
]

{ #category : #'as yet unclassified' }
MethodByName >> gtMethodFor: aView [
	<gtView>
	^ aView forward
		title: 'Method';
		priority: 10;
		object: [ self method ];
		view: #gtSourceFor:
]

{ #category : #accessing }
MethodByName >> method [
	^ method ifNil: [ method := self methodForName: self name ]
]

{ #category : #accessing }
MethodByName >> method: aCompiledMethod [
	method := aCompiledMethod
]

{ #category : #utility }
MethodByName >> methodForName: aMethodName [
	"Return a valid compiled method from aMethodName, or nil.
	The method name must be a String of the form 'ClassName>>#selector'
	where a class named 'ClassName' exists, #selector is a valid selector.
	Based on GtScenery>>#storeStringMethodFor:"

	| parts className selector class method |
	aMethodName ifNil: [ ^ nil ].
	parts := '>>#' split: aMethodName.
	parts size = 2 ifFalse: [ ^ nil ].
	className := parts first.
	selector := parts second asSymbol.
	className isValidGlobalName ifFalse: [ ^ nil ].
	class := className asClassIfAbsent: [ ^ nil ].
	class isClass ifFalse: [ ^ nil ].
	selector isValidSelector ifFalse: [ ^ nil ].
	method := class compiledMethodAt: selector ifAbsent: [ ^ nil ].
	^ method
]

{ #category : #accessing }
MethodByName >> name [
	^ name
]

{ #category : #accessing }
MethodByName >> name: aString [
	name := aString
]
