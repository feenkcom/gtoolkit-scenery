"
I am an element for a plain text label.
My subclasses offer different kinds of look and feel and possibly different behaviors.

Subclasses should implement `idClass`.
"
Class {
	#name : #GtSceneryTextLabelElement,
	#superclass : #BrEditableLabel,
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #initalization }
GtSceneryTextLabelElement >> defaultLabelAptitude [
	"Empty background and border."

	| labelAptitude |
	labelAptitude := BrGlamorousEditableLabelAptitude new
			glamorousRegularFont.
	labelAptitude styleLook
		default: [ :aStyle | 
			aStyle geometry: (BlRoundedRectangleGeometry cornerRadius: 0).
			aStyle background: Color white.
			aStyle border: BlBorder empty ].
	^ labelAptitude
]

{ #category : #initalization }
GtSceneryTextLabelElement >> defaultLabelShortcuts [
	^ {BrEditorShortcut new
			name: 'Add subnode';
			description: 'Add a subnode.';
			combination: BlKeyCombination tab;
			performBlock: [ self
					fireEvent: (GtSceneryAddNewConnection new
							fromItemElement: self;
							toStencil: self stencilClass new;
							yourself) ];
			yourself} , super defaultLabelShortcuts
]

{ #category : #acccessing }
GtSceneryTextLabelElement >> extent: aPoint [
	"This is mainly a hook to answer requests to resize the item when listening for BlElementExtentChangedEvent"

	self width: aPoint x.
	self
		hExact: self width;
		vFitContent
]

{ #category : #initalization }
GtSceneryTextLabelElement >> idClass [
	"A class or a symbol"
	^ GtSceneryTextLabelId
]

{ #category : #initalization }
GtSceneryTextLabelElement >> initialize [
	"id to be set by GtSceneryElement>>#updateItemIds"

	<tag: #sceneryListeners>
	super initialize.
	self aptitude: self defaultLabelAptitude
]

{ #category : #initalization }
GtSceneryTextLabelElement >> stencilClass [
	^ GtSceneryTextLabelStencil
]
