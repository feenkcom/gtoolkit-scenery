"
I am a request from an item to add a new connected item, for example, from a mindmap node to add a new subnode.

`fromItemElement` — the source element in the view
`toStencil` — the stencil for the new, connected item to be created


"
Class {
	#name : #GtSceneryAddNewConnection,
	#superclass : #GtPhlowObjectEvent,
	#instVars : [
		'toStencil',
		'fromItemElement'
	],
	#category : #'GToolkit-Scenery-Announcements'
}

{ #category : #accessing }
GtSceneryAddNewConnection >> fromItem [
	^ fromItemElement graph model
]

{ #category : #accessing }
GtSceneryAddNewConnection >> fromItemElement [
	^ fromItemElement
]

{ #category : #accessing }
GtSceneryAddNewConnection >> fromItemElement: anObject [
	fromItemElement := anObject
]

{ #category : #accessing }
GtSceneryAddNewConnection >> toStencil [
	^ toStencil
]

{ #category : #accessing }
GtSceneryAddNewConnection >> toStencil: anObject [
	toStencil := anObject
]
