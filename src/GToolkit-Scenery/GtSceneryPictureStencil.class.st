Class {
	#name : #GtSceneryPictureStencil,
	#superclass : #GtSceneryDraggableItem,
	#instVars : [
		'fileReference'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryPictureStencil >> create [
	| widget |
	widget := BrAsyncFileWidget new
		matchParent.
	fileReference ifNotNil: [ widget file: fileReference ]
]

{ #category : #accessing }
GtSceneryPictureStencil >> fileReference [
	^ fileReference
]

{ #category : #accessing }
GtSceneryPictureStencil >> fileReference: anObject [
	fileReference := anObject
]

{ #category : #accessing }
GtSceneryPictureStencil >> initialize [
	super initialize.
]

{ #category : #copying }
GtSceneryPictureStencil >> postCopy [
	super postCopy.
	fileReference := fileReference copy
]

{ #category : #accessing }
GtSceneryPictureStencil >> storeOn: aStream [
	super storeOn: aStream.
	aStream
		space;
		nextPutAll: 'fileReference: (', fileReference fullName, ')'
]
