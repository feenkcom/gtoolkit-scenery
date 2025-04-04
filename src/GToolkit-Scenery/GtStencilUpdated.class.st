"
I am announced by a stencil (for an item or a connection) when it is updated.

The item or connection can then in turn announce that the item or connection has been updated for its subscribers.
"
Class {
	#name : #GtStencilUpdated,
	#superclass : #Announcement,
	#instVars : [
		'stencil'
	],
	#category : #'GToolkit-Scenery-Announcements'
}

{ #category : #accessing }
GtStencilUpdated >> stencil [
	^ stencil
]

{ #category : #accessing }
GtStencilUpdated >> stencil: anObject [
	stencil := anObject
]
