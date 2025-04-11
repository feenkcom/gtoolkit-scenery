"
I am announced by a connection when its stencil is updated, or when the connected items are updated.

NB: my stencil must announce GtStencilUpdated. 
Stencils that are subclasses of GtSceneryEntityStencil can do this by sending `#announceUpdate`.

Elements that use the trait `TGtSceneryUpdatableElement` can implement `updateAppearance` to react to me. 
"
Class {
	#name : #GtSceneryConnectionUpdated,
	#superclass : #GtSceneryConnectionAnnouncement,
	#category : #'GToolkit-Scenery-Announcements'
}
