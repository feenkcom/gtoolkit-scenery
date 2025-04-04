"
I am an abstract parent for GtSceneryConnection stencils.

"
Class {
	#name : #GtSceneryConnectionStencil,
	#superclass : #GtSceneryEntityStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #printing }
GtSceneryConnectionStencil >> storeOn: aStream [
	self storeWithAttributesOn: aStream
]
