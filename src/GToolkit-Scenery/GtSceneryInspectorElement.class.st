"
I am an element for displaying a GtSceneryInspectorStencil, which wraps some kind of object.

I am a container that can display a full inspector, a specific view, an error view, or a dedicated tool for an object.
"
Class {
	#name : #GtSceneryInspectorElement,
	#superclass : #BlElement,
	#traits : 'TGtSceneryItemElement',
	#classTraits : 'TGtSceneryItemElement classTrait',
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #initialization }
GtSceneryInspectorElement >> initialize [
	"I am a container for an inspector view, which will depend on the kind of object I am inspecting."

	<tag: #sceneryListeners>
	super initialize.
	self
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		background: Color white;
		margin: (BlInsets all: 10);
		addAptitude: BrShadowAptitude
]

{ #category : #initialization }
GtSceneryInspectorElement >> stencilClass [
	^ GtSceneryInspectorStencil
]

{ #category : #announcements }
GtSceneryInspectorElement >> updateAppearance [
	"Sent in reponse to a GtSceneryItemUpdated or GtSceneryConnectionUpdated announcement.
	The trait user should override this."

	<todo: 'Update when the view is changed ...'>
	self updateViewFor: self graph model stencil
]

{ #category : #initialization }
GtSceneryInspectorElement >> updateViewFor: anInspectorStencil [
	| targetValue newView |
	[ targetValue := anInspectorStencil targetValue.
	anInspectorStencil viewMethodSelector
		ifNil: [ newView := targetValue gtViewsFor: GtPhlowView empty ]
		ifNotNil: [ newView := targetValue
					perform: anInspectorStencil viewMethodSelector
					with: GtPhlowView empty ] ]
		onErrorDo: [ :error | 
			newView := (GtSceneryInspectorOnError new errorValue: error)
					gtViewWithExceptionInStencilFor: GtPhlowView empty ].
	self removeChildren.
	view := newView.
	self addChild: view asElement
]
