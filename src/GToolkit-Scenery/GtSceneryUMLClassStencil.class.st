"
I am a text label for a class that can serve as a UML class box.

To do:
• Double-click to browse the class.
• Spawn UML specialization connections to sublasses or superclasses.
• Highlight name in red of the class is not valid.
• Auto-completion for valid class names.

"
Class {
	#name : #GtSceneryUMLClassStencil,
	#superclass : #GtSceneryTextLabelStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryUMLClassStencil class >> itemCreationSubmenuLabel [
	^ 'UML Class'
]

{ #category : #'api - instantiation' }
GtSceneryUMLClassStencil >> elementClass [
	^ GtSceneryUMLClassElement
]

{ #category : #'as yet unclassified' }
GtSceneryUMLClassStencil >> handleDoubleClickForItem: anItem andElement: anItemElement inSceneryElement: aSceneryElement [
	"Hook method for subclasses."

	| class |
	class := self text asString asClassIfAbsent: [ nil ].
	class
		ifNotNil: [ anItemElement
				fireEvent: (GtSceneryObjectToSpawn new object: (GtClassCoderTool forClass: class)) ]
]

{ #category : #initalization }
GtSceneryUMLClassStencil >> initialize [
	super initialize.
	text := 'Click and return to edit' asRopedText bold.
	self extent: nil
]
