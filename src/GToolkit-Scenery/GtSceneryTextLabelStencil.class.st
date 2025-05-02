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
	#superclass : #NewStyleSceneryItemStencil,
	#instVars : [
		'width',
		'label',
		'weight',
		'emphasis',
		'text',
		'fontSize'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #menu }
GtSceneryTextLabelStencil class >> itemCreationMenuSpecification [
	<sceneryItemCreationSpecification>
	^ LeContextMenuItemSpecification new
		priority: 10;
		snippetClass: self;
		title: self itemCreationSubmenuLabel
]

{ #category : #menu }
GtSceneryTextLabelStencil class >> itemCreationSubmenuLabel [
	^ 'Text label'
]

{ #category : #jsonV4 }
GtSceneryTextLabelStencil class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: #label -> #label;
		add: #emphasis -> #emphasis;
		add: #weight -> #weight;
		add: #width -> #width;
		yourself
]

{ #category : #jsonV4 }
GtSceneryTextLabelStencil class >> leJsonV4Name [
	"The name (symbol) for this type of stencil in the JSON representation."
	^ #sceneryTextLabelStencil
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
GtSceneryTextLabelStencil >> defaultFontSize [
	^ 14
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

{ #category : #accessing }
GtSceneryTextLabelStencil >> fontSize [
	^ fontSize
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> fontSize: aFontSize [
	fontSize := aFontSize.
	self text fontSize: fontSize
]

{ #category : #initialization }
GtSceneryTextLabelStencil >> initialize [
	super initialize.
	emphasis := self defaultEmphasis. "Not used?"
	label := self defaultLabel.
	weight := self defaultWeight.
	fontSize := self defaultFontSize.
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

{ #category : #menu }
GtSceneryTextLabelStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	<todo: 'Not working correctly -- after resizing the element does not adapt its height to the new size of the text.'>
	^ BrMenuItems new
		addItemLabel: 'Modify font'
			submenu: [ | submenu |
				submenu := BrMenuItems new.
				self weightSymbols
					do: [ :symbol | 
						submenu
							addItemLabel: symbol asString capitalized
							action: [ self weight: symbol ] ].
				#(12 14 16 18 24 30 36 48 72)
					do: [ :size | submenu addItemLabel: size printString , ' pt' action: [ self fontSize: size ] ].

				submenu ] value;
		yourself
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

{ #category : #storing }
GtSceneryTextLabelStencil >> storeOnAttributes [
	"Attributes used in the #storeOn:method"

	^ {#label.
		#emphasis.
		#weight.
		#fontSize.
		#width}
]

{ #category : #printing }
GtSceneryTextLabelStencil >> summaryDisplay [
	"Text to display in the items or stencil view."
	^ self label
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

{ #category : #accessing }
GtSceneryTextLabelStencil >> weight [
	^ weight
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> weight: aSymbolOrNumber [
	"See BlFontWeightAttribute and TBlTextStyleable.
	We have to handle the special case for Strings to deal with the JSON encoding."

	| newWeight |
	newWeight := aSymbolOrNumber.
	newWeight isNumber
		ifTrue: [ weight := newWeight.
			^ self text weight: weight ].
	newWeight isString ifTrue: [ newWeight := newWeight asSymbol ].
	newWeight isSymbol
		ifTrue: [ self assert: (self weightSymbols includes: newWeight).
			weight := newWeight.
			^ self text perform: weight ].
	AssertionFailure signal: newWeight printString , ' is not a Symbol or a Number'
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> weightSymbols [
	"Selected weight methods of TBlTextStyleable understood by a BlRunRopedText"
	^ {#thin.
		#light.
		#regular.
		#medium.
		#bold}
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
