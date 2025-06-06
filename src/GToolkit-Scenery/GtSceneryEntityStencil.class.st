"
I am an abstract superclass for stencils of scenery items and connections.
I have an announcer, so my subclasses can announce updates using `#announceStencilUpdate`.

Subclasses should implement `storeOn:` and also `postCopy` so cloning will work correctly.
"
Class {
	#name : #GtSceneryEntityStencil,
	#superclass : #BrStencil,
	#traits : 'TGtSceneryShared',
	#classTraits : 'TGtSceneryShared classTrait',
	#instVars : [
		'announcer',
		'gtScenery'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #jsonV4 }
GtSceneryEntityStencil class >> leJsonV4AttributeMapping [
	"Answer the Collection of attribute to store keys.
	Subclasses should override this with their own attributes.
	Subclasses should also define the class  method leJsonV4Name"

	^ OrderedCollection new
]

{ #category : #comparing }
GtSceneryEntityStencil >> = otherStencil [
	self == otherStencil ifTrue: [ ^ true ].
	self class = otherStencil class ifFalse: [ ^ false ].
	self storeOnAttributes
		do: [ :getter | (self perform: getter) = (otherStencil perform: getter) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #announcements }
GtSceneryEntityStencil >> announce: anAnnouncement [
	self announcer announce: anAnnouncement
]

{ #category : #announcements }
GtSceneryEntityStencil >> announceStencilUpdate [
	self announce: (GtStencilUpdated new stencil: self)
]

{ #category : #announcements }
GtSceneryEntityStencil >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GtSceneryEntityStencil >> elementClass [
	"NB: Not used by all subclasses, but perhaps should be."
	^ self subclassResponsibility
]

{ #category : #accessing }
GtSceneryEntityStencil >> gtScenery [
	self assert: gtScenery notNil description: 'gtScenery has not been updated'.
	^ gtScenery
]

{ #category : #accessing }
GtSceneryEntityStencil >> gtScenery: aScenery [
	"To be set by the scenery when the item (or connection) is added."
	gtScenery := aScenery
]

{ #category : #listeners }
GtSceneryEntityStencil >> handleDoubleClickForItemElement: anItemElement inSceneryElement: aSceneryElement [
	"Hook method for subclasses."

	
]

{ #category : #comparing }
GtSceneryEntityStencil >> hash [
	| hash |
	hash := super hash.
	self storeOnAttributes
		do: [ :getter | hash := hash bitXor: (self perform: getter) hash ].
	^ hash
]

{ #category : #testing }
GtSceneryEntityStencil >> isSceneryStencil [
	"Only scenery stencils have announcers and a #gtScenery setter and getter ."

	^ true
]

{ #category : #testing }
GtSceneryEntityStencil >> isUMLClassStencil [
	^ false
]

{ #category : #menu }
GtSceneryEntityStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	"Hook method for subclasses to provide more specific context menu items to be composed into the parent menu."

	^ BrMenuItems new
]

{ #category : #reporting }
GtSceneryEntityStencil >> reportOn: aStream in: anItem [
	"To be implemented by all subclasses that implement #isValidIn:."
	^ self subclassResponsibility
]

{ #category : #printing }
GtSceneryEntityStencil >> storeOnAttributes [
	"Attributes used in the #storeOn:method.
	Each attribute #x should have a getter #x, setter #x: and a default #defaultX.
	NB: the actual value need not be stored in an instance variable `x`,
	but could be stored anywhere else.
	A subclass should implement #storeOn: using #storeWithAttributesOn:
	Further subclasses need only extend this method with further attributes
	(or replace it)."

	^ {}
]

{ #category : #printing }
GtSceneryEntityStencil >> storeWithAttributesOn: aStream [
	"Can be used by subclasses to implement a #storeOn: method.
	Attributes to be stored should be specified in #storeStringAttributes.
	Iterate over `self storeStringAttributes` and export those
	which differ from the default values.
	NB: #storeOn: for blocks is broken, so we add a special case."

	<todo: 'Add assertions to check that getters, setters and defaults exist?'>
	| separator |
	aStream
		nextPutAll: self class name;
		nextPutAll: ' new'.
	separator := String space.
	self storeOnAttributes
		do: [ :attribute | 
			| defaultValue attributeValue |
			defaultValue := #default , attribute capitalized.
			attributeValue := self perform: attribute.
			attributeValue = (self perform: defaultValue)
				ifFalse: [ aStream
						nextPutAll: separator;
						nextPutAll: attribute asString;
						nextPutAll: ': '.
					attributeValue isClosure
						ifTrue: [ attributeValue printOn: aStream ]
						ifFalse: [ aStream nextPutAll: '('.
							attributeValue storeOn: aStream.
							aStream nextPutAll: ')' ].

					separator := '; ' ] ]
]

{ #category : #printing }
GtSceneryEntityStencil >> summaryDisplay [
	"Text to display in the items or stencil view."
	^ self printString
]
