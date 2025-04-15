Class {
	#name : #GtSceneryItemCreationContextMenuCollector,
	#superclass : #LeContextMenuSnippetItemsCollector,
	#category : #'GToolkit-Scenery-Utilities'
}

{ #category : #building }
GtSceneryItemCreationContextMenuCollector >> pragmaRootClass [
	"Where to start searching for pragmas."

	^ GtSceneryDraggableItemStencil
]

{ #category : #building }
GtSceneryItemCreationContextMenuCollector >> pragmaSelector [
	^ #sceneryItemCreationSpecification
]
