"
I am announced by an item when its stencil is updated.

NB: the stencil must announce GtStencilUpdated. 
Stencils that are subclasses of GtSceneryEntityStencil can do this by sending `#announceStencilUpdate`.

Elements that use the trait `TGtSceneryUpdatableElement` can implement `updateAppearance` to react to me. 
"
Class {
	#name : #GtSceneryItemUpdated,
	#superclass : #GtSceneryItemAnnouncement,
	#category : #'GToolkit-Scenery-Announcements'
}
