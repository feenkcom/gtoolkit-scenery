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

{ #category : #accessing }
GtSceneryPictureStencil >> dataFolders [
	^ self gtScenery dataFolders
]

{ #category : #initialization }
GtSceneryPictureStencil >> defaultExtent [
	^ 300 @ 200
]

{ #category : #initialization }
GtSceneryPictureStencil >> defaultFileReference [
	^ self gtPng
]

{ #category : #accessing }
GtSceneryPictureStencil >> defaultViewMethodSelector [
	^ #gtFigureFor:
]

{ #category : #converting }
GtSceneryPictureStencil >> fileLocatorFor: aFileReference [
	"Convert a FileReference with a full path into a FileLocator relative to the gtResource folder."

	| fileLocator |
	aFileReference isFileLocator ifTrue: [ ^ aFileReference ].
	self assert: aFileReference isFileReference.

	self
		assert: (self fileReference pathString
				beginsWith: FileLocator gtResource pathString , '/').
	fileLocator := FileLocator gtResource
			/ (aFileReference pathString
					withoutPrefix: FileLocator gtResource pathString , '/').
	self assert: fileLocator isFileLocator.
	^ fileLocator
]

{ #category : #accessing }
GtSceneryPictureStencil >> fileReference [
	^ fileReference ifNil: [ fileReference := self defaultFileReference ]
]

{ #category : #accessing }
GtSceneryPictureStencil >> fileReference: aFileReference [
	aFileReference isFileReference
		ifTrue: [ fileReference := self fileLocatorFor: aFileReference ]
		ifFalse: [ self assert: aFileReference isFileLocator.
			fileReference := aFileReference ].
	self announceStencilUpdate
]

{ #category : #example }
GtSceneryPictureStencil >> gtPng [
	<gtExample>
	<return: #FileLocator>
	^ FileLocator gtResource / 'feenkcom' / 'gtoolkit' / 'doc' / 'gtoolkit.png'
]

{ #category : #accessing }
GtSceneryPictureStencil >> imageFiles [
	^ (self dataFolders
		flatCollect: [ :f | 
			{'jpg'.
				'jpeg'.
				'png'} flatCollect: [ :ext | f allChildrenMatching: '*.' , ext ] ])
		sortedAs: #basename
]

{ #category : #menu }
GtSceneryPictureStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	^ (super
		menuForChildElement: aChildElement
		andSceneryElement: aGtSceneryElement)
		addItemLabel: 'Set picture file'
			submenu: [ | submenu |
				submenu := BrMenuItems new.
				self imageFiles
					do: [ :f | 
						submenu
							addItemLabel: f basenameWithoutExtension
							action: [ self fileReference: f ] ].
				submenu ] value;
		yourself
]

{ #category : #accessing }
GtSceneryPictureStencil >> objectValue [
	^ self fileReference
]

{ #category : #querying }
GtSceneryPictureStencil >> packages [
	"All  packages of entities in this stencil."

	^ {}
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
