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
