"
I represent a UML connection between two UML class items.

I represent either a navigable association or an inheritance (specialization) relationship.
(Other types not yet supported.)

To do:
Based on examples, I check that the link is semantically valid.

"
Class {
	#name : #GtSceneryUMLConnectionStencil,
	#superclass : #GtSceneryStraightArcStencil,
	#instVars : [
		'relationshipType'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #converting }
GtSceneryUMLConnectionStencil >> beAssociation [
	self relationshipType: #association.
	self arrowHeadType: #simple
]

{ #category : #converting }
GtSceneryUMLConnectionStencil >> beInheritance [
	self relationshipType: #inheritance.
	self arrowHeadType: #triangle
]

{ #category : #initialization }
GtSceneryUMLConnectionStencil >> initialize [
	super initialize.
]

{ #category : #accessing }
GtSceneryUMLConnectionStencil >> relationshipType [
	^ relationshipType
]

{ #category : #accessing }
GtSceneryUMLConnectionStencil >> relationshipType: aSymbol [
	self
		assert: (self relationshipTypes includes: aSymbol)
		description: aSymbol printString , ' is not a known relationship type'.
	relationshipType := aSymbol
]

{ #category : #constants }
GtSceneryUMLConnectionStencil >> relationshipTypes [
	"Currently supported UML class diagram relationship types."

	^ {#association.
		#inheritance}
]

{ #category : #printing }
GtSceneryUMLConnectionStencil >> storeOn: aStream [
	aStream nextPutAll: self class name; nextPutAll: ' new'.
	aStream 
		nextPutAll: ' labelText: '.
	self labelText storeOn: aStream.
	aStream 
		nextPutAll: '; fontSize: '.
	self fontSize storeOn: aStream.
	aStream 
		nextPutAll: '; curvatureFraction: '.
	self curvatureFraction storeOn: aStream.
	aStream 
		nextPutAll: '; relationshipType: '.
	self relationshipType storeOn: aStream.
	aStream 
		nextPutAll: '; yourself'.
]

{ #category : #'context menu' }
GtSceneryUMLConnectionStencil >> updateContextMenuItems: aBrMenuItems forSceneryElement: aGtSceneryElement andChildElement: aChildElement [
	| arrowTypeSubMenuItems brMenuItems |
	brMenuItems := super
			updateContextMenuItems: aBrMenuItems
			forSceneryElement: aGtSceneryElement
			andChildElement: aChildElement.

	arrowTypeSubMenuItems := BrMenuItems new.
	arrowTypeSubMenuItems
		addItemLabel: 'Association'
		action: [ self arrowHeadType: #simple.
			aGtSceneryElement redisplay ].
	arrowTypeSubMenuItems
		addItemLabel: 'Inheritance'
		action: [ self arrowHeadType: #triangle.
			aGtSceneryElement redisplay ].

	brMenuItems
		addItem: (BrMenuSubmenuItem new
				label: 'Modify relationship';
				submenu: arrowTypeSubMenuItems).

	^ brMenuItems
]
