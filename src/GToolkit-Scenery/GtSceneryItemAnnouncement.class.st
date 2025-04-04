"
I am an abstract superclass for all scenery item announcements.
"
Class {
	#name : #GtSceneryItemAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'item'
	],
	#category : #'GToolkit-Scenery-Announcements'
}

{ #category : #accessing }
GtSceneryItemAnnouncement >> item [
	^ item
]

{ #category : #accessing }
GtSceneryItemAnnouncement >> item: anItemStencil [ 
	item := anItemStencil
]
