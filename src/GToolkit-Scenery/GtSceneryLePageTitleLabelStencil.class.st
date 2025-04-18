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

{ #category : #'as yet unclassified' }
GtSceneryLePageTitleLabelStencil class >> leJsonV4Name [
	"The name (symbol) for this type of stencil in the JSON representation."
	^ #sceneryLePageTitleLabelStencil
]

{ #category : #'as yet unclassified' }
GtSceneryLePageTitleLabelStencil >> defaultLabel [
	^ self defaultPageName
]

{ #category : #'api - instantiation' }
GtSceneryLePageTitleLabelStencil >> elementClass [
	^ GtSceneryLePageTitleLabelElement
]

{ #category : #listeners }
GtSceneryLePageTitleLabelStencil >> handleDoubleClickForItem: anItem andElement: anItemElement inSceneryElement: aSceneryElement [
	"Spawn the page"
	self database
		pageNamed: self pageName
		ifPresent: [ anItemElement
				fireEvent: (GtSceneryObjectToSpawn new object: self startPage asPagePhlowTool) ]
		ifAbsent: [  ]
]

{ #category : #accessing }
GtSceneryLePageTitleLabelStencil >> hoverColor [
	^ self database
		pageNamed: self pageName
		ifPresent: [ Color paleBlue ]
		ifAbsent: [ Color pink ]
]

{ #category : #testing }
GtSceneryLePageTitleLabelStencil >> isValid [
	^ self database hasPageNamed: self pageName
]

{ #category : #menu }
GtSceneryLePageTitleLabelStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	"Create menu items for every outgoing link, and every incoming link within the same database."

	<todo: 'Remove duplicates!'>
	<todo: 'Rewrite to get rid of asBrMenuItems'>
	| menu sourceItem submenu |
	menu := BrMenuItems new.
	self isValid ifFalse: [ ^ menu ].
	sourceItem := aChildElement graph model.

	menu
		addItemLabel: 'Spawn outgoing link'
		submenu: [ submenu := BrMenuItems new.
			self startPage allOutgoingTargets
				do: [ :aPage | 
					submenu
						addItemLabel: aPage title
						action: [ aGtSceneryElement gtScenery
								spawnConnectionFrom: sourceItem
								to: (self class new
										pageName: aPage title;
										databaseName: self databaseName;
										yourself) ] ].
			submenu ] value.
	menu
		addItemLabel: 'Spawn incoming link'
		submenu: [ submenu := BrMenuItems new.
			(self startPage incomingLinks
				collect: [ :aLink | aLink origin page ]
				thenSelect: [ :aPage | aPage database databaseName = self databaseName ])
				do: [ :aPage | 
					submenu
						addItemLabel: aPage title
						action: [ aGtSceneryElement gtScenery
								spawnConnectionTo: sourceItem
								from: (self class new
										pageName: aPage title;
										databaseName: self databaseName;
										yourself) ] ].
			submenu ] value.
	^ menu
]

{ #category : #accessing }
GtSceneryLePageTitleLabelStencil >> pageName [
	"We ignore the instance variable from the trait and use the label instead."
	^ self label
]

{ #category : #copying }
GtSceneryLePageTitleLabelStencil >> pageName: aString [
	self label: aString
]

{ #category : #copying }
GtSceneryLePageTitleLabelStencil >> postCopy [
	"NB: In this class we use label to store the pageName."

	super postCopy.
	databaseName := self databaseName copy	"pageName:= self pageName copy"
]
