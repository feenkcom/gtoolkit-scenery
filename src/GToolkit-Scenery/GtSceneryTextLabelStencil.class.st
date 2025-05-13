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
		'fontSize',
		'backgroundColor'
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
		extent: self defaultExtent;
		resizeOnlyMiddleRight;
		yourself
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> backgroundColor [
	^ backgroundColor
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> backgroundColor: aColor [
	backgroundColor := aColor.
	self announceStencilUpdate
]

{ #category : #menu }
GtSceneryTextLabelStencil >> backgroundColors [
	^ Color class selectors select: [:s | s beginsWith: 'pale']
]

{ #category : #'api - instantiation' }
GtSceneryTextLabelStencil >> create [
	| anEditableLabel |
	anEditableLabel := self elementClass new
			text: self text copy;
			yourself.
	self width = self defaultWidth
		ifFalse: [ anEditableLabel
				hExact: width;
				vFitContent ].
	^ anEditableLabel
]

{ #category : #initialization }
GtSceneryTextLabelStencil >> defaultBackgroundColor [
	^ Color white
]

{ #category : #initialization }
GtSceneryTextLabelStencil >> defaultEmphasis [
	^ #normal
]

{ #category : #initialization }
GtSceneryTextLabelStencil >> defaultExtent [
	"Let the element choose the extent."

	^ 0@0
]

{ #category : #initialization }
GtSceneryTextLabelStencil >> defaultFontSize [
	^ 14
]

{ #category : #initialization }
GtSceneryTextLabelStencil >> defaultLabel [
	^ 'Double click me'
]

{ #category : #initialization }
GtSceneryTextLabelStencil >> defaultWeight [
	^ #regular
]

{ #category : #initialization }
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
	"NB: JSON encoding is a String."
	| symbol |
	symbol := aSymbol asSymbol.
	self assert: (self emphasisSymbols includes: symbol).
	emphasis := symbol.
	self text perform: emphasis
]

{ #category : #menu }
GtSceneryTextLabelStencil >> emphasisSymbols [
	"Selected emphasis methods of TBlTextStyleable understood by a BlRunRopedText"

	^ {#italic.
		#normal.
		#oblique}
]

{ #category : #converting }
GtSceneryTextLabelStencil >> emptyCopy [
	"Return a clone with the same attributes, but with default content."
	^ self copy
		resetContent
]

{ #category : #menu }
GtSceneryTextLabelStencil >> fitHorizontally [
	"If width = 0 then fit content horizontally"
	^ self width: 0
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

{ #category : #menu }
GtSceneryTextLabelStencil >> fontSizes [
	^ #(12 14 16 18 24 30 36 48 72)
]

{ #category : #initialization }
GtSceneryTextLabelStencil >> initialize [
	super initialize.
	emphasis := self defaultEmphasis. "Not used?"
	label := self defaultLabel.
	weight := self defaultWeight.
	fontSize := self defaultFontSize.
	width := self defaultWidth.
	backgroundColor := self defaultBackgroundColor
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> initializeText [
	text := self label asRopedText.
	self updateWeight.

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
	label := aString..
	text := nil.
	self announceStencilUpdate
]

{ #category : #menu }
GtSceneryTextLabelStencil >> menuForChildElement: aChildElement andSceneryElement: aGtSceneryElement [
	^ BrMenuItems new
		addItemLabel: 'Adjust width to text' action: [ self fitHorizontally ];
		addItemLabel: 'Modify font'
			submenu: [ | submenu |
				submenu := BrMenuItems new.
				self weightSymbols
					do: [ :symbol | 
						submenu
							addItemLabel: symbol asString capitalized
							action: [ self weight: symbol ] ].
				self emphasisSymbols
					do: [ :symbol | 
						submenu
							addItemLabel: symbol asString capitalized
							action: [ self emphasis: symbol ] ].
				self fontSizes
					do: [ :size | submenu addItemLabel: size printString , ' pt' action: [ self fontSize: size ] ].
				submenu ] value;
		addItemLabel: 'Modify background'
			submenu: [ | submenu |
				submenu := BrMenuItems new.
				self backgroundColors
					do: [ :symbol | 
						submenu
							addItemLabel: symbol asString capitalized
							action: [ self backgroundColor: (Color perform: symbol) ] ].
				submenu ] value;
		yourself
]

{ #category : #accessing }
GtSceneryTextLabelStencil >> neededHeight [
	^ self fontSize * 2
]

{ #category : #printing }
GtSceneryTextLabelStencil >> postCopy [
	super postCopy.
	label := label copy.
	text := text copy
]

{ #category : #printing }
GtSceneryTextLabelStencil >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self label;
		nextPut: $)
]

{ #category : #converting }
GtSceneryTextLabelStencil >> resetContent [
	label := self defaultLabel.
	text := nil
]

{ #category : #storing }
GtSceneryTextLabelStencil >> storeOnAttributes [
	"Attributes used in the #storeOn:method"

	^ {#label.
		#emphasis.
		#weight.
		#fontSize.
		#width.
		#backgroundColor}
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

{ #category : #updating }
GtSceneryTextLabelStencil >> updateWeight [
	self weight isNumber ifTrue: [ ^ self text weight: weight ].
	self weight isSymbol ifTrue: [ ^ self text perform: weight ]
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
		ifTrue: [ weight := newWeight ]
		ifFalse: [ newWeight isString ifTrue: [ newWeight := newWeight asSymbol ].

			newWeight isSymbol
				ifTrue: [ self assert: (self weightSymbols includes: newWeight).
					weight := newWeight ]
				ifFalse: [ AssertionFailure
						signal: newWeight printString , ' is not a Symbol or a Number' ] ].
	^ self updateWeight
]

{ #category : #menu }
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
