"
My subclasses are stencils that create an instance of a dedicated Element class, which listens to Scenery events.
They also use the storeOn: facility that outputs just the attributes that do not have default values.
"
Class {
	#name : #NewStyleSceneryItemStencil,
	#superclass : #GtSceneryDraggableItemStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #printing }
NewStyleSceneryItemStencil >> storeOn: aStream [
	self storeWithAttributesOn: aStream
]
