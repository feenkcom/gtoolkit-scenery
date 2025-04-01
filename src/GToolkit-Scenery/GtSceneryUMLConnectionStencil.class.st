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
	self relationshipType: #association
]

{ #category : #converting }
GtSceneryUMLConnectionStencil >> beInheritance [
	self relationshipType: #inheritance
]

{ #category : #accessing }
GtSceneryUMLConnectionStencil >> defaultRelationshipType [
	^ #association
]

{ #category : #initialization }
GtSceneryUMLConnectionStencil >> initialize [
	super initialize.
	relationshipType := self defaultRelationshipType
]

{ #category : #testing }
GtSceneryUMLConnectionStencil >> isValidFrom: fromItem to: toItem [
	"For inheritance only:"

	<todo: 'implement #association validity check'>
	self relationshipType = #inheritance
		ifTrue: [ ^ self isValidInheritanceFrom: fromItem to: toItem ].

	^ true
]

{ #category : #testing }
GtSceneryUMLConnectionStencil >> isValidInheritanceFrom: fromItem to: toItem [
	fromItem isValid ifFalse: [ ^ false ].
	toItem isValid ifFalse: [ ^ false ].
	^ fromItem stencil asClass superclass = toItem stencil asClass
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
	relationshipType := aSymbol.
	self updateArrowhead
]

{ #category : #constants }
GtSceneryUMLConnectionStencil >> relationshipTypes [
	"Currently supported UML class diagram relationship types."

	^ {#association.
		#inheritance}
]

{ #category : #printing }
GtSceneryUMLConnectionStencil >> storeOnAttributes [
	"NB: we replace #arrowHeadType by #relationshipType"

	^ {#labelText.
		#fontSize.
		#relationshipType.
		#curvatureFraction}
]

{ #category : #printing }
GtSceneryUMLConnectionStencil >> storeOnOLD: aStream [
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

{ #category : #accessing }
GtSceneryUMLConnectionStencil >> updateArrowhead [
	self relationshipType = #association ifTrue: [ ^ self arrowHeadType: #simple ].
	self relationshipType = #inheritance
		ifTrue: [ ^ self arrowHeadType: #triangle ]
]

{ #category : #'context menu' }
GtSceneryUMLConnectionStencil >> updateContextMenuItems: aBrMenuItems forSceneryElement: aGtSceneryElement andChildElement: aChildElement [
	| relationshipTypeSubMenuItems brMenuItems |
	brMenuItems := super
			updateContextMenuItems: aBrMenuItems
			forSceneryElement: aGtSceneryElement
			andChildElement: aChildElement.

	relationshipTypeSubMenuItems := BrMenuItems new.
	relationshipTypeSubMenuItems
		addItemLabel: 'Association'
		action: [ self beAssociation.
			aGtSceneryElement redisplay ].
	relationshipTypeSubMenuItems
		addItemLabel: 'Inheritance'
		action: [ self beInheritance.
			aGtSceneryElement redisplay ].

	brMenuItems
		addItem: (BrMenuSubmenuItem new
				label: 'Modify relationship';
				submenu: relationshipTypeSubMenuItems).

	^ brMenuItems
]
