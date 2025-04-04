Class {
	#name : #GtSceneryShapeElement,
	#superclass : #BlElement,
	#traits : 'TGtSceneryUpdatableElement',
	#classTraits : 'TGtSceneryUpdatableElement classTrait',
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #announcements }
GtSceneryShapeElement >> updateAppearance [
	| item |
	item := self graph model.
	self
		size: item extent;
		background: item stencil backgroundColor;
		geometry: item stencil geometry
]
