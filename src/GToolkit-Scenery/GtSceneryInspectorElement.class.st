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
		'stencil',
		'shadowAptitude'
	],
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #accessing }
GtSceneryInspectorElement >> hideShadow [
	self shadowAptitude color: Color transparent
]

{ #category : #initialization }
GtSceneryInspectorElement >> initialize [
	"I am a container for an inspector view, which will depend on the kind of object I am inspecting."

	<tag: #sceneryListeners>
	super initialize.
	self
		layout: BlFrameLayout new;
		background: Color white;
		margin: (BlInsets all: 10);
		addAptitude: self shadowAptitude
]

{ #category : #accessing }
GtSceneryInspectorElement >> shadowAptitude [
	^ shadowAptitude ifNil: [ shadowAptitude := BrShadowAptitude new ]
]

{ #category : #accessing }
GtSceneryInspectorElement >> shadowAptitude: anObject [
	shadowAptitude := anObject
]

{ #category : #accessing }
GtSceneryInspectorElement >> showShadow [
	self shadowAptitude color: self shadowAptitude theme default defaultShadowColor
]

{ #category : #accessing }
GtSceneryInspectorElement >> stencil [
	^ stencil
]

{ #category : #accessing }
GtSceneryInspectorElement >> stencil: aGtSceneryInspectorStencil [
	self
		assert: (aGtSceneryInspectorStencil isKindOf: AbstractGtSceneryInspectorStencil).

	stencil := aGtSceneryInspectorStencil.
	self size: self stencil defaultExtent.
	self updateAppearance
]

{ #category : #initialization }
GtSceneryInspectorElement >> stencilClass [
	"Default to add subnodes ..."
	<todo: 'Perhaps stencilClass should depend on the current stencil'>
	^ GtSceneryInspectorStencil
]

{ #category : #announcements }
GtSceneryInspectorElement >> updateAppearance [
	| objectValue |
	self
		assert: self stencil notNil
		description: '#updateAppearance sent before element is initialized'.
	self size: self stencil defaultExtent.
	[ objectValue := self stencil objectValue.
	self stencil viewMethodSelector
		ifNil: [ view := objectValue gtViewsFor: GtPhlowView empty ]
		ifNotNil: [ view := objectValue
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
