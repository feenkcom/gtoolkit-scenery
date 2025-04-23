"
I serve as an abstract superclass for the kinds of entities found in a scenery, i.e., items and connections.
"
Class {
	#name : #GtSceneryEntity,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'stencil'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #comparing }
GtSceneryEntity >> = otherEntity [
	<todo: 'Should equality for items take position and extent into account, or ignore them?'>
	self == otherEntity ifTrue: [ ^ true ].
	self class = otherEntity class ifFalse: [ ^ false ].
	^ self stencil = otherEntity stencil
]

{ #category : #announcements }
GtSceneryEntity >> announce: anAnnouncement [
	self announcer announce: anAnnouncement
]

{ #category : #announcements }
GtSceneryEntity >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #comparing }
GtSceneryEntity >> hash [
^ self stencil hash
]

{ #category : #accessing }
GtSceneryEntity >> stencil [
	^ stencil
]
