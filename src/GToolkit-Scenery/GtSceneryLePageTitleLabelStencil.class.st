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
	"| subMenuItems |"

	<todo: 'spawn superclass or subclass nodes'>
"	self startPage allOutgoingTargets
		do: [ :aPage | 
			[ aGtSceneryElement
				fireEvent: (GtSceneryAddNewConnection new
						fromItemElement: self;
						toStencil: self stencilClass new;
						yourself) ] ].	"
						
	"
	(self isValidClass and: [ self asClass isAbstract not ])
		ifTrue: [ aBrMenuItems
				addItemLabel: 'Inspect example'
				action: [ :elt | aChildElement fireEvent: (GtSceneryObjectToSpawn new object: self example) ] ].

	subMenuItems := BrMenuItems new.
	subMenuItems addItemLabel: 'Superclass' action: [  ].
	subMenuItems addItemLabel: 'Subclasses' action: [  ]."	"aBrMenuItems
		addItem: (BrMenuSubmenuItem new
				label: 'Spawn outgoing link';
				submenu: subMenuItems)."

	^ aBrMenuItems
]
