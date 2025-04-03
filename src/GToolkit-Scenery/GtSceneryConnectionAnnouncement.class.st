"
I am an abstract superclass for all scenery connection announcements.
"
Class {
	#name : #GtSceneryConnectionAnnouncement,
	#superclass : #GtSceneryUpdateAnnouncement,
	#instVars : [
		'connection'
	],
	#category : #'GToolkit-Scenery-Announcements'
}

{ #category : #accessing }
GtSceneryConnectionAnnouncement >> connection [
	^ connection
]

{ #category : #accessing }
GtSceneryConnectionAnnouncement >> connection: anObject [
	connection := anObject
]
