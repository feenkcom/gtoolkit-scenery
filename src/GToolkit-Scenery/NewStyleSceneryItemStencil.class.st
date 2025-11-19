"
My subclasses are stencils that create an instance of a dedicated Element class, which listens to Scenery events.
They also use the storeOn: facility that outputs just the attributes that do not have default values.
"
Class {
	#name : #NewStyleSceneryItemStencil,
	#superclass : #GtSceneryDraggableItemStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
NewStyleSceneryItemStencil >> item [
	^ self gtScenery itemForStencil: self
]

{ #category : #menu }
NewStyleSceneryItemStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	"To do:
	- organize into sorted submenus by type
	- don't offer connections already existing"

	| menu sourceItem submenu |
	menu := super
			menuForChildElement: aChildElement
			andSceneryElement: aGtSceneryElement.
	sourceItem := aChildElement graph model.

	menu
		addItemLabel: 'Link to item'
		submenu: [ submenu := BrMenuItems new.
			self gtScenery items
				do: [ :anItem | 
					anItem = sourceItem
						ifFalse: [ submenu
								addItemLabel: anItem stencil summaryDisplay , ' ('
										, anItem stencil class itemCreationSubmenuLabel , ')'
								action: [ self gtScenery addConnectionFrom: sourceItem to: anItem ] ] ].
			submenu ] value.

	^ menu
]

{ #category : #printing }
NewStyleSceneryItemStencil >> storeOn: aStream [
	self storeWithAttributesOn: aStream
]
