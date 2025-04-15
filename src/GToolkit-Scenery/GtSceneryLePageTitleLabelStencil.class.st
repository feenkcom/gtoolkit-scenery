Class {
	#name : #GtSceneryLePageTitleLabelStencil,
	#superclass : #GtSceneryTextLabelStencil,
	#traits : 'TGtSceneryLePageWrapper',
	#classTraits : 'TGtSceneryLePageWrapper classTrait',
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryLePageTitleLabelStencil class >> defaultWeight [
	^ #bold
]

{ #category : #accessing }
GtSceneryLePageTitleLabelStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #accessing }
GtSceneryLePageTitleLabelStencil class >> itemCreationSubmenuLabel [
	^ 'Lepiter page title'
]

{ #category : #'api - instantiation' }
GtSceneryLePageTitleLabelStencil >> elementClass [
	^ GtSceneryLePageTitleLabelElement
]
