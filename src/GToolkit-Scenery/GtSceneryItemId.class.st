"
I am the id for SceneryItem elements.
I am also a parent for other, more specific kinds of items (not yet used).
"
Class {
	#name : #GtSceneryItemId,
	#superclass : #GtCoderElementId,
	#category : #'GToolkit-Scenery-Ids'
}

{ #category : #accessing }
GtSceneryItemId >> asSymbol [
	^ #'gt-scenery-item'
]
