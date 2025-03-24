"
I am an abstract parent for various kinds of scenery text label items.
Subclasses should implement `idClass`.
"
Class {
	#name : #GtSceneryEditableTextLabel,
	#superclass : #BrEditableLabel,
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #initalization }
GtSceneryEditableTextLabel >> idClass [
	"A class or a symbol"
	^ self subclassResponsibility
]

{ #category : #initalization }
GtSceneryEditableTextLabel >> initialize [
	"id to be set by GtSceneryElement>>#updateItemIds"

	<tag: #sceneryListeners>
	| resizer |
	super initialize.
	self aptitude: BrGlamorousEditableLabelAptitude new glamorousRegularFontAndSize.
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

{ #category : #testing }
GtSceneryEditableTextLabel >> isAbstract [
	^ self == GtSceneryEditableTextLabel
]
