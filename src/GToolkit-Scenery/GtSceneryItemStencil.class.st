"
I am an abstract superclass for stencils of scenery items and connections.

Subclasses should implement `storeOn:` and also `postCopy` so cloning will work correctly.
"
Class {
	#name : #GtSceneryItemStencil,
	#superclass : #BrStencil,
	#traits : 'TGtSceneryShared',
	#classTraits : 'TGtSceneryShared classTrait',
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #'as yet unclassified' }
GtSceneryItemStencil >> handleDoubleClickForItem: anItem andElement: anItemElement inSceneryElement: aSceneryElement [
	"Hook method for subclasses."

	
]

{ #category : #testing }
GtSceneryItemStencil >> isUMLClassStencil [
	^ false
]

{ #category : #testing }
GtSceneryItemStencil >> isValid [
	"Subclasses can override this."
	^ true
]

{ #category : #printing }
GtSceneryItemStencil >> storeOnAttributes [
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
GtSceneryItemStencil >> storeWithAttributesOn: aStream [
	"Can be used by subclasses to implement a #storeOn: method.
	Attributes to be stored should be specified in #storeStringAttributes.
	Iterate over `self storeStringAttributes` and export those
	which differ from the default values."
	
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
						nextPutAll: ': ('.
					attributeValue storeOn: aStream.
					aStream nextPutAll: ')'.
					separator := '; ' ] ]
]

{ #category : #'context menu' }
GtSceneryItemStencil >> updateContextMenuItems: aBrMenuItems forSceneryElement: aGtSceneryElement andChildElement: aChildElement [
	"Hook method for subclasses to provide more specific context menu items. By default do nothing."

	^ aBrMenuItems
]
