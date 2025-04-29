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
		'view',
		'stencil'
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
GtSceneryInspectorElement >> stencil [
	^ stencil
]

{ #category : #accessing }
GtSceneryInspectorElement >> stencil: aGtSceneryInspectorStencil [
	self assert: (aGtSceneryInspectorStencil isKindOf: GtSceneryInspectorStencil).

	stencil := aGtSceneryInspectorStencil.
	self size: self stencil extent.
	self updateAppearance
]

{ #category : #initialization }
GtSceneryInspectorElement >> stencilClass [
	^ GtSceneryInspectorStencil
]

{ #category : #announcements }
GtSceneryInspectorElement >> updateAppearance [
	| targetValue |
	self
		assert: self stencil notNil
		description: '#updateAppearance sent before element is initialized'.
	self size: self stencil extent.
	[ targetValue := self stencil targetValue.
	self stencil viewMethodSelector
		ifNil: [ view := targetValue gtViewsFor: GtPhlowView empty ]
		ifNotNil: [ view := targetValue
					perform: self stencil viewMethodSelector
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
