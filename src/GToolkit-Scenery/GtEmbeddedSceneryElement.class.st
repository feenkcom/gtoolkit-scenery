Class {
	#name : #GtEmbeddedSceneryElement,
	#superclass : #GtSceneryInspectorElement,
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #announcements }
GtEmbeddedSceneryElement >> updateAppearance [
	super updateAppearance.
	"self children first disableBackgroundDragging"
]
