Class {
	#name : #MethodByNameExamples,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Utilities'
}

{ #category : #example }
MethodByNameExamples >> instantiationByNameOrMethod [
	<gtExample>
	| m1 m2 |
	m1 := MethodByName for: 'MethodByNameExamples>>#instantiationByNameOrMethod'.
	m2 := MethodByName for: MethodByNameExamples >> #instantiationByNameOrMethod.
	self assert: m1 name equals: m2 name.
	self assert: m1 method equals: m2 method.
	^ m1
]

{ #category : #example }
MethodByNameExamples >> invalidMethodNames [
	<gtExample>
	^ {'ClassWithoutMethodSelector'.
		'Class >> #withSpacesBeforeSelector'.
		'invalidClassName>>#name'.
		'NonExistentClass666>>#name'.
		'MethodByNameExamples>>#0invalidSelector'.
		'MethodByNameExamples>>#notExistingMethod'}
]

{ #category : #example }
MethodByNameExamples >> invalidMethodNamesRejected [
	"Check that invalid names are rejected."

	<gtExample>
	| checker |
	checker := MethodByName new.
	self invalidMethodNames
		do: [ :methodName | self assert: (checker methodForName: methodName) isNil ].
	^ checker
]

{ #category : #example }
MethodByNameExamples >> validMethodNames [
	<gtExample>
	^ MethodByName methods collect: #printString
]

{ #category : #example }
MethodByNameExamples >> validMethodNamesAccepted [
	"Check that invalid names are rejected."

	<gtExample>
	| checker result |
	checker := MethodByName new.
	result := self validMethodNames
			collect: [ :methodName | checker methodForName: methodName ].
	result do: [ :each | self assert: each notNil ].
	^ result
]
