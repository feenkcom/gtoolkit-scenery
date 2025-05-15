Class {
	#name : #GtSceneryPictureStencil,
	#superclass : #AbstractGtSceneryInspectorStencil,
	#instVars : [
		'fileReference'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #menu }
GtSceneryPictureStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #menu }
GtSceneryPictureStencil class >> itemCreationSubmenuLabel [
	^ 'Picture file'
]

{ #category : #accessing }
GtSceneryPictureStencil >> create [
	^ super create
		hideShadow;
		yourself
]

{ #category : #initialization }
GtSceneryPictureStencil >> defaultFileReference [
	^ self gtPng
]

{ #category : #accessing }
GtSceneryPictureStencil >> defaultViewMethodSelector [
	^ #gtFigureFor:
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
	<return: #FileLocator>
	^ FileLocator gtResource / 'feenkcom' / 'gtoolkit' / 'doc' / 'gtoolkit.png'
]

{ #category : #accessing }
GtSceneryPictureStencil >> initialize [
	super initialize.
	extent := 450 @ 150
]

{ #category : #accessing }
GtSceneryPictureStencil >> objectValue [
	^ self fileReference
]

{ #category : #copying }
GtSceneryPictureStencil >> postCopy [
	super postCopy.
	fileReference := fileReference copy
]

{ #category : #storing }
GtSceneryPictureStencil >> storeOnAttributes [
	^ super storeOnAttributes , {#fileReference}
]
