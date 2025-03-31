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
	^ self text asString asClassIfAbsent: [ UndefinedClass ]
]

{ #category : #'as yet unclassified' }
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

	anItemElement
		fireEvent: (GtSceneryObjectToSpawn new object: (GtClassCoderTool forClass: self asClass))
]

{ #category : #connecting }
GtSceneryUMLClassStencil >> stencilForConnectionWithItemStencil: anItemStencil [
	"Hook to let the stencil decide the connection stencil to use."

	self class = anItemStencil class
		ifTrue: [ ^ GtSceneryUMLConnectionStencil new ].

	^ GtSceneryStraightArcStencil new
]

{ #category : #'as yet unclassified' }
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
