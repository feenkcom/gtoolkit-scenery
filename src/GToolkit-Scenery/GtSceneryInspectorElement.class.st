"
I am an element for displaying a GtSceneryInspectorStencil, which wraps some kind of object.

I am a container that can display a full inspector, a specific view, an error view, or a dedicated tool for an object.
"
Class {
	#name : #GtSceneryInspectorElement,
	#superclass : #BlElement,
	#traits : 'TGtSceneryItemElement',
	#classTraits : 'TGtSceneryItemElement classTrait',
	#instVars : [
		'view'
	],
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

{ #category : #accessing }
GtSceneryInspectorElement >> stencil: aGtSceneryInspectorStencil [
	self assert: (aGtSceneryInspectorStencil isKindOf: GtSceneryInspectorStencil).
	self graph model: aGtSceneryInspectorStencil.
	self graph beNode.
	self updateAppearanceFor: aGtSceneryInspectorStencil
]

{ #category : #initialization }
GtSceneryInspectorElement >> stencilClass [
	^ GtSceneryInspectorStencil
]

{ #category : #announcements }
GtSceneryInspectorElement >> updateAppearance [
	| myStencil |
	myStencil := self graph model.
	self
		assert: myStencil notNil
		description: '#updateAppearance sent before #stencil:'.
	self updateAppearanceFor: myStencil
]

{ #category : #announcements }
GtSceneryInspectorElement >> updateAppearanceFor: aStencil [
	| targetValue |
	
	[ targetValue := aStencil targetValue.
	aStencil viewMethodSelector
		ifNil: [ view := targetValue gtViewsFor: GtPhlowView empty ]
		ifNotNil: [ view := targetValue
					perform: aStencil viewMethodSelector
					with: GtPhlowView empty ] ]
		onErrorDo: [ :error | 
			view := (GtSceneryInspectorOnError new errorValue: error)
					gtViewWithExceptionInStencilFor: GtPhlowView empty ].
	
	"targetValue := aStencil targetValue.
	view := targetValue gtViewsFor: GtPhlowView empty."
	"self halt."
	
	self removeChildren.
	self addChild: view asElement
]

{ #category : #accessing }
GtSceneryInspectorElement >> view [
	^ view
]
