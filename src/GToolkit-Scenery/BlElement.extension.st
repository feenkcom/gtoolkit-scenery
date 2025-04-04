Extension { #name : #BlElement }

{ #category : #'*GToolkit-Scenery' }
BlElement >> isUpdatableSceneryEntityElement [
	"Ad hoc elements can't subscribe to scenery item or connection updates."

	^ false
]
