"
I am an element for a plain text label.
My subclasses offer different kinds of look and feel and possibly different behaviors.

Subclasses should implement `idClass`.
"
Class {
	#name : #GtSceneryTextLabelElement,
	#superclass : #BrEditableLabel,
	#traits : 'TLeWithFontSize + TGtSceneryItemEement',
	#classTraits : 'TLeWithFontSize classTrait + TGtSceneryItemEement classTrait',
	#instVars : [
		'labelAptitude'
	],
	#category : #'GToolkit-Scenery-UI'
}

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
	self aptitude: self labelAptitude
]

{ #category : #initalization }
GtSceneryTextLabelElement >> initializeLabelAptitude [
	"Empty background and border."

	labelAptitude := BrGlamorousEditableLabelAptitude new
			glamorousRegularFont.
	labelAptitude styleLook
		default: [ :aStyle | 
			aStyle geometry: (BlRoundedRectangleGeometry cornerRadius: 0).
			aStyle background: Color white.
			aStyle border: BlBorder empty ].
	^ labelAptitude
]

{ #category : #accessing }
GtSceneryTextLabelElement >> labelAptitude [
	^ labelAptitude ifNil: [ self initializeLabelAptitude ]
]

{ #category : #acccessing }
GtSceneryTextLabelElement >> size: aPoint [
	"This is essentially a hook to answer requests to resize the item when listening for BlElementExtentChangedEvent in GtSceneryElement>>#createItemElementFor: "

	self graph model
		ifNil: [ super size: aPoint ]
		ifNotNil: [ self graph model stencil width: aPoint x.
			self
				hExact: self width;
				vFitContent ]
]

{ #category : #initalization }
GtSceneryTextLabelElement >> stencilClass [
	^ GtSceneryTextLabelStencil
]

{ #category : #announcements }
GtSceneryTextLabelElement >> updateAppearance [
	| stencil |
	stencil := self graph model stencil.
	stencil width = stencil defaultWidth
		ifFalse: [ self
				hExact: stencil width;
				vFitContent ]
]
