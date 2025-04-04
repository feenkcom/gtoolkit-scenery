"
I am a trait for scenery elements that subscribe to update events from items or connections.

My users should implement the update method ...
"
Trait {
	#name : #TGtSceneryUpdatableElement,
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #testing }
TGtSceneryUpdatableElement >> isUpdatableSceneryEntityElement [
	^ true
]

{ #category : #announcements }
TGtSceneryUpdatableElement >> updateAppearance [
	"Sent in reponse to a GtSceneryItemUpdated or GtSceneryConnectionUpdated announcement.
	The trait user should override this."
]
