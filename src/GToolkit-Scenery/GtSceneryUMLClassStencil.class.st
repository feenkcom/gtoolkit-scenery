"
I am a text label for a class that can serve as a UML class box.

To do:
• Double-click to browse the class.
• Spawn UML specialization connections to sublasses or superclasses.
• Highlight name in red of the class is not valid.
• Auto-completion for valid class names.

"
Class {
	#name : #GtSceneryUMLClassStencil,
	#superclass : #GtSceneryTextLabelStencil,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtSceneryUMLClassStencil class >> itemCreationSubmenuLabel [
	^ 'UML Class'
]

{ #category : #conversion }
GtSceneryUMLClassStencil >> asClass [
	"nil needed for #isValid"
	^ self label asClassIfAbsent: [ nil ]
]

{ #category : #initialization }
GtSceneryUMLClassStencil >> defaultLabel [
	^ 'Click and return to edit'
]

{ #category : #'api - instantiation' }
GtSceneryUMLClassStencil >> elementClass [
	^ GtSceneryUMLClassElement
]

{ #category : #'as yet unclassified' }
GtSceneryUMLClassStencil >> handleDoubleClickForItem: anItem andElement: anItemElement inSceneryElement: aSceneryElement [
	"Hook method for subclasses."

	self isValidClass
		ifTrue: [ anItemElement
				fireEvent: (GtSceneryObjectToSpawn new object: (GtClassCoderTool forClass: self asClass)) ]
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> invalidForegroundColor [
	^ Color red
]

{ #category : #testing }
GtSceneryUMLClassStencil >> isUMLClassStencil [
	^ true
]

{ #category : #testing }
GtSceneryUMLClassStencil >> isValidClass [
	^ self asClass isNotNil
]

{ #category : #testing }
GtSceneryUMLClassStencil >> isValidIn: aSceneryContext [
	"We don't need the context."

	^ self isValidClass
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> label: aString [
	super label: aString.
	self isValidClass
		ifTrue: [ self text foreground: self validForegroundColor ]
		ifFalse: [ self text foreground: self invalidForegroundColor ]
]

{ #category : #validity }
GtSceneryUMLClassStencil >> reportOn: aStream in: anItem [
	self isValidClass
		ifFalse: [ aStream
				nextPutAll: '“';
				nextPutAll: self label;
				nextPutAll: '” does not exist as a class';
				cr ]
]

{ #category : #connecting }
GtSceneryUMLClassStencil >> stencilForConnectionWithItemStencil: anItemStencil [
	"Hook to let the stencil decide the connection stencil to use."

	self class = anItemStencil class
		ifTrue: [ ^ GtSceneryUMLConnectionStencil new ].

	^ GtSceneryStraightArcStencil new
]

{ #category : #'context menu' }
GtSceneryUMLClassStencil >> updateContextMenuItems: aBrMenuItems forSceneryElement: aGtSceneryElement andChildElement: aChildElement [
	<todo: 'spawn superclass or subclass nodes'>
	
	|  subMenuItems |

	subMenuItems := BrMenuItems new.
	subMenuItems
		addItemLabel: 'Superclass'
		action: [ 
			aGtSceneryElement redisplay ].
	subMenuItems
		addItemLabel: 'Subclasses'
		action: [
			aGtSceneryElement redisplay ].
			
	aBrMenuItems
		addItem: (BrMenuSubmenuItem new
				label: 'Spawn';
				submenu: subMenuItems).
				
	^ aBrMenuItems
]

{ #category : #accessing }
GtSceneryUMLClassStencil >> validForegroundColor [
	^ Color black
]
