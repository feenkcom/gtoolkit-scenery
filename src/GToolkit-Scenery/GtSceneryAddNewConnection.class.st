"
I am a request from an item to add a new connected item, for example, from a mindmap node to add a new subnode.

`fromItem` — the source item of the element in the view
`toStencil` — the stencil for the new, connected item to be created
*Caveat:* In other cases where we spawn new elements we have the scenery element in hand, so we can directly ask the scenery to spawn the new items and connections. Perhaps we do not need this at all ...

"
Class {
	#name : #GtSceneryAddNewConnection,
	#superclass : #GtPhlowObjectEvent,
	#instVars : [
		'toStencil',
		'fromItem'
	],
	#category : #'GToolkit-Scenery-Announcements'
}

{ #category : #accessing }
GtSceneryAddNewConnection >> fromItem [
	^ fromItem
]

{ #category : #accessing }
GtSceneryAddNewConnection >> fromItem: aGtSceneryItem [
	fromItem := aGtSceneryItem
]

{ #category : #accessing }
GtSceneryAddNewConnection >> toStencil [
	^ toStencil
]

{ #category : #accessing }
GtSceneryAddNewConnection >> toStencil: aGtSceneryStencil [
	toStencil := aGtSceneryStencil
]
