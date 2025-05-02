"
I represent a variety of shapes. I should replace `GtSceneryRectangleStencil`.
For the moment only my `geometry` can be set.
Later it should be possible to style me:
- border width and color
- background color
- text label (?)
"
Class {
	#name : #GtSceneryShapeStencil,
	#superclass : #NewStyleSceneryItemStencil,
	#instVars : [
		'geometry',
		'backgroundColorSelector'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #menu }
GtSceneryShapeStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #menu }
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

	self backgroundColorSelector: aColor name asSymbol.
	self announceStencilUpdate
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
	backgroundColorSelector := aSelector.
	self announceStencilUpdate
]

{ #category : #'instance creation' }
GtSceneryShapeStencil >> create [
	^ GtSceneryShapeElement new
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
GtSceneryShapeStencil >> geometry: aGeometry [
	geometry := aGeometry.
	self announceStencilUpdate
]

{ #category : #listeners }
GtSceneryShapeStencil >> handleDoubleClickForItemElement: anItemElement inSceneryElement: aSceneryElement [
	"Inspect the stencil."

	aSceneryElement inspectItemForElement: anItemElement
]

{ #category : #initialization }
GtSceneryShapeStencil >> initialize [
	super initialize.
	geometry := self defaultGeometry.
	backgroundColorSelector := self defaultBackgroundColorSelector
]

{ #category : #menu }
GtSceneryShapeStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	^ BrMenuItems new
		addItemLabel: 'Modify geometry'
			submenu: (BrMenuItems new
					addItemLabel: 'Be circular'
						action: [ self geometry: BlCircleGeometry new ];
					addItemLabel: 'Be rectangular'
						action: [ self geometry: BlRectangleGeometry new ];
					yourself);
		yourself
]

{ #category : #accessing }
GtSceneryShapeStencil >> storeOnAttributes [
	^ {#geometry.
		#backgroundColorSelector}
]

{ #category : #'as yet unclassified' }
GtSceneryShapeStencil >> summaryDisplay [
	"Text to display in the items or stencil view."
	^ self geometry
]
