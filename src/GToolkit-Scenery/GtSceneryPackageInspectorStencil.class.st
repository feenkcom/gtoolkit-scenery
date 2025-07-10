"
I am an inspector for a package. I provide menu items for exploring a package.
"
Class {
	#name : #GtSceneryPackageInspectorStencil,
	#superclass : #AbstractGtSceneryInspectorStencil,
	#instVars : [
		'packageName'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #menu }
GtSceneryPackageInspectorStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		"priority: 1;"
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #menu }
GtSceneryPackageInspectorStencil class >> itemCreationSubmenuLabel [
	^ 'Package'
]

{ #category : #initialization }
GtSceneryPackageInspectorStencil >> defaultPackageName [
	^ Package defaultPackageName
]

{ #category : #initialization }
GtSceneryPackageInspectorStencil >> defaultViewMethodSelector [
	^ #gtPackageOverviewFor:
]

{ #category : #'as yet unclassified' }
GtSceneryPackageInspectorStencil >> examplesSubmenuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	| menu myItem |
	myItem := self gtScenery itemForStencil: self.
	self assert: myItem notNil.
	menu := BrMenuItems new.
	self package gtExamplesWithReturnPragmasClassified associations sorted
		do: [ :kv | 
			menu
				addItemLabel: kv key
				submenu: [ | submenu |
					submenu := BrMenuItems new.
					kv value
						do: [ :eg | 
							submenu
								addItemLabel: eg name
								action: [ self gtScenery
										spawnNewItemFrom: myItem
										using: eg sceneryInspectorStencil ] ].
					submenu ] value ].
	^ menu
]

{ #category : #initialization }
GtSceneryPackageInspectorStencil >> initialize [
	super initialize.
	packageName := self defaultPackageName
]

{ #category : #'as yet unclassified' }
GtSceneryPackageInspectorStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	^ (super
		menuForChildElement: aChildElement
		andSceneryElement: aGtSceneryElement)
		addItemLabel: 'Examples'
			submenu: (self
					examplesSubmenuForChildElement: aChildElement
					andSceneryElement: aGtSceneryElement);
		yourself
]

{ #category : #accessing }
GtSceneryPackageInspectorStencil >> objectValue [
	^ self package
]

{ #category : #accessing }
GtSceneryPackageInspectorStencil >> package [
	^ self packageName asPackage
]

{ #category : #accessing }
GtSceneryPackageInspectorStencil >> package: aPackage [
	self packageName: aPackage packageName
]

{ #category : #accessing }
GtSceneryPackageInspectorStencil >> packageName [
	^ packageName
]

{ #category : #accessing }
GtSceneryPackageInspectorStencil >> packageName: aPackageName [
	packageName := aPackageName.
	self announceStencilUpdate
]

{ #category : #storing }
GtSceneryPackageInspectorStencil >> storeOnAttributes [
	^ super storeOnAttributes , {#packageName}
]
