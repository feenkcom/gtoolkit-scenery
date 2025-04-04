"
I serve as an abstract superclass for the kinds of entities found in a scenery, i.e., items and connections.
"
Class {
	#name : #GtSceneryEntity,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #announcements }
GtSceneryEntity >> announce: anAnnouncement [
	self announcer announce: anAnnouncement
]

{ #category : #announcements }
GtSceneryEntity >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]
