"
I am an abstract parent for GtSceneryConnection stencils.

"
Class {
	#name : #GtSceneryConnectionStencil,
	#superclass : #GtSceneryItemStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #'as yet unclassified' }
GtSceneryConnectionStencil >> isValid [
	self error: 'Use #isValidFrom:to: for connection stencils'.
	^ false
]

{ #category : #'as yet unclassified' }
GtSceneryConnectionStencil >> isValidFrom: fromItem to: toItem [
	^ true
]

{ #category : #printing }
GtSceneryConnectionStencil >> storeOn: aStream [
	self storeWithAttributesOn: aStream
]
