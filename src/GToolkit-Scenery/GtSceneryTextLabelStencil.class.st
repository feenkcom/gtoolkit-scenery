"
I am a stencil for a text label that can be specialized by subclasses to show different styles, or to link to wrapped items such as classes or Lepiter pages.

I have a `label` (a string), and several attributes that can be configured.
(Some to be added.)

label — the String label
width — if not zero, the width for wrapping the text label
weight— a symbol (see unary methods of `BlFontWeightAttribute`)
emphasis — a symbol (see `BlFontEmphasisAttribute`)

*to be added:*

fontSize — a number
backgroundColor — a Symbol (see `Color` class methods)



"
Class {
	#name : #GtSceneryTextLabelStencil,
	#superclass : #GtSceneryDraggableItemStencil,
	#instVars : [
		'width',
		'label',
		'weight',
		'emphasis',
		'text'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #acccessing }
GtSceneryTextLabelStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		priority: 10;
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #acccessing }
GtSceneryTextLabelStencil class >> itemCreationSubmenuLabel [
	^ 'Text label'
]

{ #category : #converting }
GtSceneryTextLabelStencil >> asItem [
	^ GtSceneryItem new
		stencil: self;
		extent: self extent;
		resizeOnlyMiddleRight;
		yourself
]

{ #category : #'api - instantiation' }
GtSceneryTextLabelStencil >> create [
	| anEditableLabel |
	anEditableLabel := self elementClass new
			text: self text;
			yourself.
	self width = self defaultWidth
		ifFalse: [ anEditableLabel
				hExact: width;
				vFitContent ].
	^ anEditableLabel
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> defaultEmphasis [
	^ #normal
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> defaultExtent [
	"Let the element choose the extent."

	^ nil
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> defaultLabel [
	^ 'Double click me'
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> defaultWeight [
	^ #regular
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> defaultWidth [
	"Width is only used if not 0."
	^ 0
]

{ #category : #'api - instantiation' }
GtSceneryTextLabelStencil >> elementClass [
	^ GtSceneryTextLabelElement
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> emphasis [
	^ emphasis
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> emphasis: aSymbol [
	"See BlFontEmphasisAttribute"
	emphasis := aSymbol.
	self announceStencilUpdate
]

{ #category : #initialization }
GtSceneryTextLabelStencil >> initialize [
	super initialize.
	emphasis := self defaultEmphasis. "Not used?"
	label := self defaultLabel.
	weight := self defaultWeight. "Not used?"
	width := self defaultWidth
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> initializeText [
	text := self label asRopedText.

	text
		when: BlTextStringsInserted
		do: [ self label: text asString.
			self announceStencilUpdate ].
	text
		when: BlTextsDeleted
		do: [ self label: text asString.
			self announceStencilUpdate ].
			
	"text when: BlTextAttributesAdded do: [self label: text asString ].
	text when: BlTextAttributesRemoved do: [self label: text asString ]."

	^ text
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> label [
	^ label
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> label: aString [
	label := aString.
	self announceStencilUpdate
]

{ #category : #printing }
GtSceneryTextLabelStencil >> postCopy [
	super postCopy.
	label := label copy.
	width := width copy.
]

{ #category : #printing }
GtSceneryTextLabelStencil >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self label;
		nextPut: $)
]

{ #category : #printing }
GtSceneryTextLabelStencil >> storeOn: aStream [
	self storeWithAttributesOn: aStream
]

{ #category : #printing }
GtSceneryTextLabelStencil >> storeOnAttributes [
	"Attributes used in the #storeOn:method"

	^ {#label.
		#emphasis.
		#weight.
		#width}
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> text [
	"I am an editable version of the label for use in the instantiated element.
	Changed to me should be reflected back to the label instance variable state."

	^ text ifNil: [ self initializeText ]
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> text: aText [
	"Deprecated -- use label: instead"
	self label: aText asString
]

{ #category : #menu }
GtSceneryTextLabelStencil >> updateItemContextMenuItems: aBrMenuItems forSceneryElement: aGtSceneryElement andChildElement: aChildElement [
	<todo: 'Not working correctly -- after resizing the element does not adapt its height to the new size of the text.'>
	
"
	| subMenuItems |
	subMenuItems := BrMenuItems new.

	subMenuItems
		addItemLabel: 'Increase font size'
		action: [ aChildElement increaseFontSize.
			self text fontSize: aChildElement fontSize ].
	subMenuItems
		addItemLabel: 'Decrease font size'
		action: [ aChildElement decreaseFontSize.
			self text fontSize: aChildElement fontSize ].
			
	subMenuItems
		addItemLabel: 'Reset font size'
		action: [ aChildElement resetFontSize.
			self text fontSize: aChildElement fontSize ].
	aBrMenuItems
		addItem: (BrMenuSubmenuItem new
				label: 'Modify font';
				submenu: subMenuItems)."

	^ aBrMenuItems
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> weight [
	^ weight
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> weight: aSymbol [
	"See BlFontWeightAttribute"
	weight := aSymbol.
	self announceStencilUpdate
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> width [
	^ width
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> width: aWidth [
	width := aWidth.
	self announceStencilUpdate
]
