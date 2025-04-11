"
I am announced by aconnection when its stencil is updated.

NB: the stencil must announce GtStencilUpdated. 
Stencils that are subclasses of GtSceneryEntityStencil can do this by sending `#announceUpdate`.
"
Class {
	#name : #GtSceneryConnectionUpdated,
	#superclass : #GtSceneryConnectionAnnouncement,
	#category : #'GToolkit-Scenery-Announcements'
}
