"
I offer a common API for scenery items. 

# API

"
Trait {
	#name : #TGtSceneryConnectionElement,
	#traits : 'TGtSceneryElement',
	#classTraits : 'TGtSceneryElement classTrait',
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #announcements }
TGtSceneryConnectionElement >> resetConnectionColor [
	"Used to reset the connection color after hovering, or after changing the border color.
	Subclasses should implement me."
	<todo: 'Move default implementation here?'>
]

{ #category : #announcements }
TGtSceneryConnectionElement >> setHoverConnectionColor [
	"Used to set the connection color during hovering.
	Subclasses should implement me."
	<todo: 'Move default implementation here?'>
]
