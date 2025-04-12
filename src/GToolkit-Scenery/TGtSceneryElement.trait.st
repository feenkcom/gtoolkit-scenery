"
I am a trait for scenery elements that subscribe to update events from items or connections.

# API:

`#updateAppearance` — updates appearance in reaction to a GtSceneryItemUpdated or GtSceneryConnectionUpdated announcement.

"
Trait {
	#name : #TGtSceneryElement,
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #testing }
TGtSceneryElement >> isSceneryElement [
	"I support the TGtSceneryElement API. In partiuclar I subscribe to update events and support #updateAppearance."

	^ true
]

{ #category : #announcements }
TGtSceneryElement >> updateAppearance [
	"Sent in reponse to a GtSceneryItemUpdated or GtSceneryConnectionUpdated announcement.
	The trait user should override this."
]
