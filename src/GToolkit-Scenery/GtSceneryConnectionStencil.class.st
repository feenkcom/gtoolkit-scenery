"
I am an abstract parent for GtSceneryConnection stencils.

"
Class {
	#name : #GtSceneryConnectionStencil,
	#superclass : #GtSceneryItemStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #printing }
GtSceneryConnectionStencil >> storeOn: aStream [
	self storeWithAttributesOn: aStream
]
