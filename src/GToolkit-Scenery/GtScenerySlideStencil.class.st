Class {
	#name : #GtScenerySlideStencil,
	#superclass : #GtSceneryExampleStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #menu }
GtScenerySlideStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #menu }
GtScenerySlideStencil class >> itemCreationSubmenuLabel [
	^ 'Slide'
]

{ #category : #initialization }
GtScenerySlideStencil >> defaultExampleMethodName [
	^ 'DemoSlideshow>>#title:'
]

{ #category : #initialization }
GtScenerySlideStencil >> defaultExtent [
	^ 300 @ 200
]

{ #category : #initialization }
GtScenerySlideStencil >> defaultViewMethodSelector [
	^ #gtLiveFor:
]

{ #category : #storing }
GtScenerySlideStencil >> exampleBlockStringForUMLClassStencil [
	^ '[ (',self exampleMethodName, ') asScalableSlide ]'
]

{ #category : #accessing }
GtScenerySlideStencil >> exampleMethodName: aStringOrMethod [
	| methodByName |
	methodByName := MethodByName for: aStringOrMethod.
	self assert: (methodByName method hasPragmaNamed: #gtSlide).
	exampleMethodName := methodByName name.
	self announceStencilUpdate
]

{ #category : #menu }
GtScenerySlideStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	<todo: 'extend the item menu for the embedded scenery stencil'>
	^ super menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement
]

{ #category : #accessing }
GtScenerySlideStencil >> objectValue [
	^ self exampleMethod asScalableSlide
]
