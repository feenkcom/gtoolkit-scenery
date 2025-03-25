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
			glamorousRegularFontAndSize.
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

{ #category : #initalization }
GtSceneryTextLabelElement >> idClass [
	"A class or a symbol"
	^ GtSceneryTextLabelId
]

{ #category : #initalization }
GtSceneryTextLabelElement >> initialize [
	"id to be set by GtSceneryElement>>#updateItemIds"

	<tag: #sceneryListeners>
	| resizer |
	super initialize.
	self aptitude: self defaultLabelAptitude.
	resizer := BlResizerElement new preventMouseEvents zIndex: 100.
	self
		when: BlFocusOutEvent
			do: [ :e | 
				resizer
					detach;
					removeFromParent ];
		when: BlFocusInEvent
			do: [ :e | 
				resizer
					detach;
					removeFromParent.
				self parent addChild: resizer.
				resizer attachTo: self.
				self
					when: BlResizerResizedEvent
					do: [ :evt | 
						self width: evt extent x.
						self
							hExact: self width;
							vFitContent ] ]
]

{ #category : #initalization }
GtSceneryTextLabelElement >> stencilClass [
	^ GtSceneryTextLabelStencil
]
