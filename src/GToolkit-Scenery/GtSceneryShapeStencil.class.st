"
I represent a variety of shapes. I should replace {{gtClass:name=GtSceneryRectangleStencil}}.
For the moment only my `geometry` can be set.
Later it should be possible to style me:
- border width and color
- background color
- text label (?)
"
Class {
	#name : #GtSceneryShapeStencil,
	#superclass : #GtSceneryDraggableItemStencil,
	#instVars : [
		'geometry',
		'backgroundColorSelector'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #acccessing }
GtSceneryShapeStencil class >> itemCreationSubmenuLabel [
	^ 'Shape'
]

{ #category : #accessing }
GtSceneryShapeStencil >> backgroundColor [
	^ Color perform: self backgroundColorSelector
]

{ #category : #accessing }
GtSceneryShapeStencil >> backgroundColor: aColor [
	"For backward compatibility"
	self backgroundColorSelector: aColor name asSymbol
]

{ #category : #accessing }
GtSceneryShapeStencil >> backgroundColorSelector [
	^ backgroundColorSelector
]

{ #category : #accessing }
GtSceneryShapeStencil >> backgroundColorSelector: aSelector [
	self
		assert: (Color registeredColorNames includes: aSelector)
		description: aSelector , ' is not a registered Color name'.
	backgroundColorSelector := aSelector
]

{ #category : #'instance creation' }
GtSceneryShapeStencil >> create [
	^ BlElement new
		size: extent;
		background: self backgroundColor;
		geometry: self geometry;
		border: Color black;
		margin: (BlInsets all: 10)
]

{ #category : #accessing }
GtSceneryShapeStencil >> defaultBackgroundColorSelector [
	^ #white
]

{ #category : #initialization }
GtSceneryShapeStencil >> defaultExtent [
	^ 200 @ 200
]

{ #category : #initialization }
GtSceneryShapeStencil >> defaultGeometry [
	^ self defaultGeometryClass new
]

{ #category : #initialization }
GtSceneryShapeStencil >> defaultGeometryClass [
	^ BlRectangleGeometry
]

{ #category : #accessing }
GtSceneryShapeStencil >> geometry [
	^ geometry ifNil: [ geometry := self defaultGeometry ]
]

{ #category : #accessing }
GtSceneryShapeStencil >> geometry: anObject [
	geometry := anObject
]

{ #category : #'as yet unclassified' }
GtSceneryShapeStencil >> handleDoubleClickForItem: anItem andElement: anItemElement inSceneryElement: aSceneryElement [
	"Inspect the stencil."

	aSceneryElement inspectItem: anItem  forElement: anItemElement
]

{ #category : #initialization }
GtSceneryShapeStencil >> initialize [
	super initialize.
	geometry := self defaultGeometry.
	backgroundColorSelector := self defaultBackgroundColorSelector
]

{ #category : #printing }
GtSceneryShapeStencil >> storeOn: aStream [
	"self storeOnOLD: aStream"
	self storeWithAttributesOn: aStream
]

{ #category : #accessing }
GtSceneryShapeStencil >> storeOnAttributes [
	^ {#geometry.
		#backgroundColorSelector}
]

{ #category : #printing }
GtSceneryShapeStencil >> storeOnOLD: aStream [
	super storeOn: aStream.
	aStream
		space;
		nextPutAll: 'geometry: ('.
	self geometry storeOn: aStream.
	aStream
		space;
		nextPutAll: ');';
		cr;
		nextPutAll: ' backgroundColor: ('.
	self backgroundColor storeOn: aStream.
	aStream
		space;
		nextPutAll: ')'
]
