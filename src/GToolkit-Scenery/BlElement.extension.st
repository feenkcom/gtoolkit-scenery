Extension { #name : #BlElement }

{ #category : #'*GToolkit-Scenery' }
BlElement >> isSceneryElement [
	"Ad hoc elements in a GTScenery don't support the TGtSceneryElement API."

	^ false
]
