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
		'relationshipType',
		'navigationBlockString'
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
GtSceneryUMLConnectionStencil >> defaultNavigationBlockString [
	^ ''
]

{ #category : #accessing }
GtSceneryUMLConnectionStencil >> defaultRelationshipType [
	^ #association
]

{ #category : #'instance creation' }
GtSceneryUMLConnectionStencil >> elementClass [
	^ GtSceneryUMLConnectionElement
]

{ #category : #initialization }
GtSceneryUMLConnectionStencil >> initialize [
	super initialize.
	relationshipType := self defaultRelationshipType.
	navigationBlockString := self defaultNavigationBlockString
]

{ #category : #validity }
GtSceneryUMLConnectionStencil >> isValidAssociationFrom: fromItem to: toItem [
	"We check that the navigating from the example using the navigation block
	in fact gives us a result of the target class."

	| example result |
	
	true ifTrue: [^ true]. "for now, disable checking"
	
	fromItem isValid ifFalse: [ ^ false ].
	toItem isValid ifFalse: [ ^ false ].
	self navigationBlockString isEmpty ifTrue: [ ^ false ].
	[ example := fromItem stencil example ] onErrorDo: [ ^ false ].
	result := [ (Smalltalk compiler evaluate: self navigationBlockString)
			value: example ] onErrorDo: [ ^ false ].
	^ result class = toItem stencil asClass
]

{ #category : #validity }
GtSceneryUMLConnectionStencil >> isValidIn: aConnection [
	self relationshipType = #inheritance
		ifTrue: [ ^ self isValidInheritanceFrom: aConnection from to: aConnection to ].
	self relationshipType = #association
		ifTrue: [ ^ self isValidAssociationFrom: aConnection from to: aConnection to ].
	^ true
]

{ #category : #validity }
GtSceneryUMLConnectionStencil >> isValidInheritanceFrom: fromItem to: toItem [
	fromItem isValid ifFalse: [ ^ false ].
	toItem isValid ifFalse: [ ^ false ].
	^ fromItem stencil asClass superclass = toItem stencil asClass
]

{ #category : #accessing }
GtSceneryUMLConnectionStencil >> navigationBlockString [
	^ navigationBlockString
]

{ #category : #accessing }
GtSceneryUMLConnectionStencil >> navigationBlockString: aClosureOrString [
	"We store a string instead of a block to avoid capturing any free variables."

	navigationBlockString := aClosureOrString isClosure
			ifTrue: [ aClosureOrString printString ]
			ifFalse: [ aClosureOrString ].
	self announceStencilUpdate
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
	self updateArrowhead.
	self announceStencilUpdate
]

{ #category : #constants }
GtSceneryUMLConnectionStencil >> relationshipTypes [
	"Currently supported UML class diagram relationship types."

	^ {#association.
		#inheritance}
]

{ #category : #validity }
GtSceneryUMLConnectionStencil >> reportInvalidInheritance: aStream in: aConnection [
	| fromItem toItem |
	fromItem := aConnection from.
	toItem := aConnection to.

	fromItem isInvalid
		ifTrue: [ aStream
				nextPutAll: fromItem stencil label;
				nextPutAll: ' is not a valid subclass';
				cr ].

	toItem isInvalid
		ifTrue: [ aStream
				nextPutAll: toItem stencil label;
				nextPutAll: ' is not a valid superclass';
				cr ].

	(fromItem isValid
		and: [ toItem isValid
				and: [ fromItem stencil asClass superclass ~= toItem stencil asClass ] ])
		ifTrue: [ aStream
				nextPutAll: fromItem stencil asClass name;
				nextPutAll: ' is not a subclass of ';
				nextPutAll: toItem stencil asClass name;
				cr ]
]

{ #category : #validity }
GtSceneryUMLConnectionStencil >> reportOn: aStream in: aConnection [
	<todo: 'Implement for #association'>
	self relationshipType = #inheritance
		ifTrue: [ self reportInvalidInheritance: aStream in: aConnection ]
]

{ #category : #printing }
GtSceneryUMLConnectionStencil >> storeOnAttributes [
	"NB: we replace #arrowHeadType by #relationshipType"

	^ {#labelText.
		#fontSize.
		#relationshipType.
		#navigationBlockString.
		#curvatureFraction}
]

{ #category : #accessing }
GtSceneryUMLConnectionStencil >> updateArrowhead [
	self relationshipType = #association ifTrue: [ ^ self arrowHeadType: #simple ].
	self relationshipType = #inheritance
		ifTrue: [ ^ self arrowHeadType: #triangle ]
]

{ #category : #'context menu' }
GtSceneryUMLConnectionStencil >> updateItemContextMenuItems: aBrMenuItems forSceneryElement: aGtSceneryElement andChildElement: aChildElement [
	| relationshipTypeSubMenuItems brMenuItems |
	brMenuItems := super
			updateItemContextMenuItems: aBrMenuItems
			forSceneryElement: aGtSceneryElement
			andChildElement: aChildElement.

	relationshipTypeSubMenuItems := BrMenuItems new.
	relationshipTypeSubMenuItems
		addItemLabel: 'Association'
		action: [ self beAssociation ].
	relationshipTypeSubMenuItems
		addItemLabel: 'Inheritance'
		action: [ self beInheritance ].

	brMenuItems
		addItem: (BrMenuSubmenuItem new
				label: 'Modify relationship';
				submenu: relationshipTypeSubMenuItems).

	^ brMenuItems
]
