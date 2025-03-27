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
GtSceneryMindMapNodeElement >> defaultLabelAptitude [
	"Default label with grey background, rounded rectangle and no border."

	^ BrGlamorousEditableLabelAptitude new glamorousRegularFontAndSize
]

{ #category : #initalization }
GtSceneryMindMapNodeElement >> stencilClass [
	^ GtSceneryMindMapNodeStencil
]
