"
I am an element for a mindmap item.
I support a `tab` shortcut to create new subitems.
"
Class {
	#name : #GtSceneryMindMapNodeElement,
	#superclass : #GtSceneryTextLabelElement,
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #initalization }
GtSceneryMindMapNodeElement >> initializeLabelAptitude [
	"Default label with grey background, rounded rectangle and no border."

	labelAptitude := BrGlamorousEditableLabelAptitude new glamorousRegularFontAndSize.
	^ labelAptitude
]

{ #category : #initalization }
GtSceneryMindMapNodeElement >> stencilClass [
	^ GtSceneryMindMapNodeStencil
]
