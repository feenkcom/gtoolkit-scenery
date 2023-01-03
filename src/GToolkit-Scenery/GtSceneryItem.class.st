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
	element graph model: self.
	element graph beNode.
	resizer := BlResizerElement new preventMouseEvents.
	element
		when: BlFocusOutEvent
			do: [ :e | 
				resizer
					detach;
					removeFromParent ];
		when: BlFocusInEvent
			do: [ :e | 
				aContainerElement addChild: resizer.
				resizer attachTo: element ].
	^ element
		addEventHandler: BlPullHandler new;
		relocate: position
]

{ #category : #accessing }
GtSceneryItem >> initialize [
	super initialize.
	position := 0@0.
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
