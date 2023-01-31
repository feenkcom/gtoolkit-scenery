Class {
	#name : #GtSceneryItem,
	#superclass : #Object,
	#instVars : [
		'stencil',
		'position',
		'extent'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryItem >> asElementIn: aContainerElement forScenery: aScenery [
	| element resizer |
	element := stencil asElement.
	element states
		addState: BrLayoutVerticalResizerState exact;
		addState: BrLayoutVerticalResizerState exact.	"this is needed to support complicated widgets"
"	element size: extent."
	element graph model: self.
	element graph beNode.
	resizer := BlResizerElement new preventMouseEvents zIndex: 100.
	element beFocusable.
	element
		when: BlClickEvent
			do: [ :e | 
				e currentTarget requestFocus.
				e consumed: true ];
		when: BlFocusOutEvent
			do: [ :e | 
				resizer
					detach;
					removeFromParent ];
		when: BlFocusInEvent
			do: [ :e | 
				aContainerElement addChild: resizer.
				resizer attachTo: element ].
	element userData at: #sceneryItem put: true.
	^ element
		addEventHandler: BlPullHandler new;
		relocate: position
]

{ #category : #accessing }
GtSceneryItem >> extent [
	^ extent
]

{ #category : #accessing }
GtSceneryItem >> extent: aPoint [
	extent := aPoint
]

{ #category : #accessing }
GtSceneryItem >> initialize [
	super initialize.
	position := 0@0.
	extent := 200 @ 200
]

{ #category : #accessing }
GtSceneryItem >> position [
	^ position
]

{ #category : #accessing }
GtSceneryItem >> position: aPoint [ 
	position := aPoint
]

{ #category : #accessing }
GtSceneryItem >> stencil [
	^ stencil
]

{ #category : #accessing }
GtSceneryItem >> stencil: anItemStencil [ 
	stencil := anItemStencil
]
