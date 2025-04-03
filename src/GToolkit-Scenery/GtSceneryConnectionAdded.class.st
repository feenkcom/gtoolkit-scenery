"
I am announced by a GtScenery whenever a new connection is added.

"
Class {
	#name : #GtSceneryConnectionAdded,
	#superclass : #GtSceneryUpdateAnnouncement,
	#instVars : [
		'connection'
	],
	#category : #'GToolkit-Scenery-Announcements'
}

{ #category : #accessing }
GtSceneryConnectionAdded >> connection [
	^ connection
]

{ #category : #accessing }
GtSceneryConnectionAdded >> connection: anObject [
	connection := anObject
]
