"
I am announced by a GtScenery whenever a new item is added.

NB: currently not listened to by GtSceneryElement, but should be ...

"
Class {
	#name : #GtSceneryItemAdded,
	#superclass : #Announcement,
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
