"
I am announced by a GtScenery whenever a new item is added.

"
Class {
	#name : #GtSceneryItemAdded,
	#superclass : #GtSceneryUpdateAnnouncement,
	#instVars : [
		'item'
	],
	#category : #'GToolkit-Scenery-Announcements'
}

{ #category : #accessing }
GtSceneryItemAdded >> item [
	^ item
]

{ #category : #accessing }
GtSceneryItemAdded >> item: anItemStencil [ 
	item := anItemStencil
]
