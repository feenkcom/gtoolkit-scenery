"
I am a simple utility to  convert stored method names into compiled methods.
"
Class {
	#name : #MethodByName,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Utilities'
}

{ #category : #utility }
MethodByName class >> for: aString [
	^ self new methodForName: aString
]

{ #category : #example }
MethodByName >> invalidMethodNames [
"Examples of method names that should not be used to set GtScenery>>#storeStringMethodName:"
	<gtExample>
	^ {'ClassWithoutMethodSelector'.
		'Class >> #withSpacesBeforeSelector'.
		'invalidClassName>>#name'.
		'NonExistentClass666>>#name'.
		'MethodByName>>#0invalidSelector'.
		'MethodByName>>#notExistingMethod'}
]

{ #category : #example }
MethodByName >> invalidMethodNamesRejected [
	"Check that invalid names are rejected."

	<gtExample>
	| checker |
	checker := MethodByName new.
	self invalidMethodNames
		do: [ :methodName | self assert: (checker methodForName: methodName) isNil ].
	^ checker
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

{ #category : #example }
MethodByName >> validMethodNames [
"Examples of method names that should not be used to set GtScenery>>#storeStringMethodName:"
	<gtExample>
	^ MethodByName methods collect: #printString
]

{ #category : #example }
MethodByName >> validMethodNamesAccepted [
	"Check that invalid names are rejected."

	<gtExample>
	| checker result |
	checker := MethodByName new.
	result := self validMethodNames
			collect: [ :methodName | checker methodForName: methodName ].
	result do: [ :each | self assert: each notNil ].
	^ result
]
