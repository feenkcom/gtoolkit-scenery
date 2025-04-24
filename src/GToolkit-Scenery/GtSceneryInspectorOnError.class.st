Class {
	#name : #GtSceneryInspectorOnError,
	#superclass : #Object,
	#instVars : [
		'errorValue'
	],
	#category : #'GToolkit-Scenery-Utilities'
}

{ #category : #accessing }
GtSceneryInspectorOnError >> errorValue [
	^ errorValue
]

{ #category : #accessing }
GtSceneryInspectorOnError >> errorValue: anObject [
	errorValue := anObject
]

{ #category : #'as yet unclassified' }
GtSceneryInspectorOnError >> gtViewWithExceptionInStencilFor: aView [
	<gtView>
	^ aView explicit
		title: 'Error in stencil';
		priority: 50;
		stencil: [ errorValue signal.
			BlElement new ]
]
