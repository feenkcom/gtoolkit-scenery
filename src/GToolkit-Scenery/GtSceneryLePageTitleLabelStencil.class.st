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

{ #category : #menu }
GtSceneryLePageTitleLabelStencil >> updateItemContextMenuItems: aBrMenuItems forSceneryElement: aGtSceneryElement andChildElement: aChildElement [
	"Create menu items for every outgoing link, and every incoming link within the same database."

	| incomingFromMyDb outgoing sourceItem |
	self isValid ifFalse: [ ^ aBrMenuItems ].
	sourceItem := aChildElement graph model.
	outgoing := self startPage allOutgoingTargets.
	outgoing
		ifNotEmpty: [ | subMenu |
			outgoing
				do: [ :aPage | 
					subMenu := BrMenuItems new.
					subMenu
						addItemLabel: aPage title
						action: [ aGtSceneryElement gtScenery
								spawnConnectionFrom: sourceItem
								to: (self class new
										pageName: aPage title;
										databaseName: self databaseName;
										yourself) ] ].

			aBrMenuItems
				addItem: (BrMenuSubmenuItem new
						label: 'Spawn outgoing link';
						submenu: subMenu) ].

	incomingFromMyDb := self startPage incomingLinks
			collect: [ :aLink | aLink origin page ]
			thenSelect: [ :aPage | aPage database databaseName = self databaseName ].
	incomingFromMyDb
		ifNotEmpty: [ | subMenu |
			subMenu := BrMenuItems new.
			incomingFromMyDb
				do: [ :aPage | 
					subMenu
						addItemLabel: aPage title
						action: [ aGtSceneryElement gtScenery
								spawnConnectionTo: sourceItem
								from: (self class new
										pageName: aPage title;
										databaseName: self databaseName;
										yourself) ] ].
			aBrMenuItems
				addItem: (BrMenuSubmenuItem new
						label: 'Spawn incoming link';
						submenu: subMenu) ].

	^ aBrMenuItems
]
