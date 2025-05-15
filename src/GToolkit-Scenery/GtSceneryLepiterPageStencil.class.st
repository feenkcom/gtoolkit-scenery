Class {
	#name : #GtSceneryLepiterPageStencil,
	#superclass : #AbstractGtSceneryInspectorStencil,
	#traits : 'TGtSceneryLePageWrapper',
	#classTraits : 'TGtSceneryLePageWrapper classTrait',
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #menu }
GtSceneryLepiterPageStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #menu }
GtSceneryLepiterPageStencil class >> itemCreationSubmenuLabel [
	^ 'Lepiter page'
]

{ #category : #required }
GtSceneryLepiterPageStencil >> announceStencilUpdate [
	"Actually we inherit this, but we make the trait happy by duplicating the code."

	self announce: (GtStencilUpdated new stencil: self)
]

{ #category : #initialization }
GtSceneryLepiterPageStencil >> defaultExtent [
	^ 500 @ 400
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> defaultPageName [
	^ 'Glamorous Toolkit'
]

{ #category : #initialization }
GtSceneryLepiterPageStencil >> defaultViewMethodSelector [
	^ #gtLiveFor:
]

{ #category : #listeners }
GtSceneryLepiterPageStencil >> handleDoubleClickForItemElement: anItemElement inSceneryElement: aSceneryElement [
	"Spawn the page"

	anItemElement
		fireEvent: (GtSceneryObjectToSpawn new object: self startPage asPagePhlowTool)
]

{ #category : #accessing }
GtSceneryLepiterPageStencil >> objectValue [
	^ self startPage
]

{ #category : #printing }
GtSceneryLepiterPageStencil >> storeOnAttributes [
	^ super storeOnAttributes
		, {#pageName.
				#databaseName}
]
