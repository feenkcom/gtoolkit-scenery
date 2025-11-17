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

{ #category : #menu }
GtSceneryPackageInspectorStencil >> classesSubmenuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	| menu myItem |
	myItem := self gtScenery itemForStencil: self.
	self assert: myItem notNil.
	menu := BrMenuItems new.
	self package classes
		do: [ :c | 
			menu
				addItemLabel: c name
				action: [ self gtScenery
						spawnNewItemFrom: myItem
						using: (GtSceneryUMLClassStencil new
								class: c;
								yourself) ] ].
	^ menu
]

{ #category : #initialization }
GtSceneryPackageInspectorStencil >> defaultPackageName [
	^ Package defaultPackageName
]

{ #category : #initialization }
GtSceneryPackageInspectorStencil >> defaultViewMethodSelector [
	^ #gtPackageOverviewFor:
]

{ #category : #menu }
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

{ #category : #testing }
GtSceneryPackageInspectorStencil >> isPackageStencil [
	^ true
]

{ #category : #menu }
GtSceneryPackageInspectorStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	^ (super
		menuForChildElement: aChildElement
		andSceneryElement: aGtSceneryElement)
		addItemLabel: 'Examples'
			submenu: (self
					examplesSubmenuForChildElement: aChildElement
					andSceneryElement: aGtSceneryElement);
		addItemLabel: 'Classes'
			submenu: (self
					classesSubmenuForChildElement: aChildElement
					andSceneryElement: aGtSceneryElement);
		addItemLabel: 'Spawn package classes from examples'
			action: [ | myItem |
				myItem := self gtScenery itemForStencil: self.
				self assert: myItem notNil.
				self umlClassesFromExamples
					do: [ :each | self gtScenery spawnNewItemFrom: myItem using: each ] ];
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

{ #category : #querying }
GtSceneryPackageInspectorStencil >> umlClassesFromExamples [
	^ self gtScenery umlClassesFromExamplesIn: self package
]
