"
My subclasses are older Scenery stencils that do not have dedicated elements that listen to Scenery events, and do not yet use the generic storeOn: facility that collects non-default values of storeOnAttributes.

These classes should be migrated to become subclasses of NewStyleSceneryItemStencil, or replaced by new stencils.
"
Class {
	#name : #OldStyleSceneryItemStencil,
	#superclass : #GtSceneryDraggableItemStencil,
	#instVars : [
		'extent'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #'as yet unclassified' }
OldStyleSceneryItemStencil >> setIsSpawnedTrue [
	"For compatibility"
]
