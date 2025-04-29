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
		background: Color white;
		margin: (BlInsets all: 10);
		addAptitude: BrShadowAptitude
]

{ #category : #accessing }
GtSceneryInspectorElement >> stencil: aGtSceneryInspectorStencil [
	self assert: (aGtSceneryInspectorStencil isKindOf: GtSceneryInspectorStencil).

	self size: aGtSceneryInspectorStencil extent.
	self graph model: aGtSceneryInspectorStencil.
	self graph beNode.
	self updateAppearance
]

{ #category : #initialization }
GtSceneryInspectorElement >> stencilClass [
	^ GtSceneryInspectorStencil
]

{ #category : #announcements }
GtSceneryInspectorElement >> updateAppearance [
	| myStencil targetValue |
	myStencil := self graph model.
	self
		assert: myStencil notNil
		description: '#updateAppearance sent before #stencil:'.
	self size: myStencil extent.
	[ targetValue := myStencil targetValue.
	myStencil viewMethodSelector
		ifNil: [ view := targetValue gtViewsFor: GtPhlowView empty ]
		ifNotNil: [ view := targetValue
					perform: myStencil viewMethodSelector
					with: GtPhlowView empty ] ]
		onErrorDo: [ :error | 
			view := (GtSceneryInspectorOnError new errorValue: error)
					gtViewWithExceptionInStencilFor: GtPhlowView empty ].
	self removeChildren.
	self addChild: view asElement
]

{ #category : #accessing }
GtSceneryInspectorElement >> view [
	^ view
]
