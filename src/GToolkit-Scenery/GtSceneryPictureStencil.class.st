Class {
	#name : #GtSceneryPictureStencil,
	#superclass : #GtSceneryDraggableItemStencil,
	#instVars : [
		'fileReference'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #acccessing }
GtSceneryPictureStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #acccessing }
GtSceneryPictureStencil class >> itemCreationSubmenuLabel [
	^ 'Picture file'
]

{ #category : #accessing }
GtSceneryPictureStencil >> create [
	^ BrAsyncFileWidget new
		matchParent;
		file: self fileReference
]

{ #category : #initialization }
GtSceneryPictureStencil >> defaultFileReference [
	^ self gtPng
]

{ #category : #accessing }
GtSceneryPictureStencil >> fileReference [
	^ fileReference ifNil: [ fileReference := self defaultFileReference ]
]

{ #category : #accessing }
GtSceneryPictureStencil >> fileReference: aFileReference [
	fileReference := aFileReference.
	self announceStencilUpdate
]

{ #category : #example }
GtSceneryPictureStencil >> gtPng [
	<gtExample>
	^ FileLocator gtResource / 'feenkcom' / 'gtoolkit' / 'doc' / 'gtoolkit.png'
]

{ #category : #accessing }
GtSceneryPictureStencil >> initialize [
	super initialize.
	extent := 450 @ 150
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
		nextPutAll: 'fileReference: ('.
	fileReference storeOn: aStream.
	aStream
		nextPut: $).
]
