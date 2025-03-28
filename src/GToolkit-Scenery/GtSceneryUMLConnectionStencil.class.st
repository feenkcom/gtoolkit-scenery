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
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #initialization }
GtSceneryUMLConnectionStencil >> initialize [
	super initialize.
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
		addItemLabel: 'Simple arrow'
		action: [ self arrowHeadType: #simple.
			aGtSceneryElement redisplay ].
	arrowTypeSubMenuItems
		addItemLabel: 'UML subclass arrow'
		action: [ self arrowHeadType: #triangle.
			aGtSceneryElement redisplay ].

	brMenuItems
		addItem: (BrMenuSubmenuItem new
				label: 'Modify arrow type';
				submenu: arrowTypeSubMenuItems).

	^ brMenuItems
]
