"
These examples highlight which class diagrams are valid or invalid.
"
Class {
	#name : #GtSceneryUMLClassExamples,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #scenery }
GtSceneryUMLClassExamples >> byteStringCharacterAssociation [
	"Example to be used for checking validity of associations.
	The byteString should be associated with an example eg 'hello world'.
	The association needs a name.
	The association needs a navigation snippet.
	"

	<gtExample>
	<return: #GtScenery>
	| scenery item1 item2 |
	scenery := GtScenery new.
	item1 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new
					label: 'ByteString';
					width: 113.99201965332031;
					exampleBlockString: '[ ''hello world'' ]') asItem.
	item1 position: 277.1608072916665 @ 274.9241129557292.
	item1 extent: 113.99201965332031 @ 40.0.
	item2 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new
					label: 'Character';
					exampleBlockString: '[ $a  ]') asItem.
	item2 position: 484.3033854166665 @ 272.5660400390625.
	item2 extent: 107.41598510742188 @ 40.0.
	scenery
		addConnectionWithStencil: (GtSceneryUMLConnectionStencil new
				labelText: 'holds';
				navigationBlockString: '[ :aByteString | aByteString first ]')
		from: item1
		to: item2.
	^ scenery
]

{ #category : #scenery }
GtSceneryUMLClassExamples >> collectionObjectInheritanceIsInvalid [
	<gtExample>
	<return: #GtScenery>
	| scenery item1 item2 |
	scenery := GtScenery new.
	item1 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'Object') asItem.
	item1 position: -44.0 @ -48.0.
	item1 extent: 48.41600036621094 @ 28.0.
	item2 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'Collection') asItem.
	item2 position: -19.0 @ 26.0.
	item2 extent: 69.33201599121094 @ 28.0.
	scenery
		addConnectionWithStencil: (GtSceneryUMLConnectionStencil new
				relationshipType: #inheritance)
		from: item1
		to: item2.

	self assert: scenery connections first isInvalid.
	self assert: scenery isInvalid.

	^ scenery
]

{ #category : #scenery }
GtSceneryUMLClassExamples >> multipleInvalidItemsAndConnections [
	"Demo multiple things that can be wrong."

	<gtExample>
	<return: #GtScenery>
	| scenery dotItem foobarItem objectClassItem bagClassItem collectionClassItem bagObjectInheritance objectFoobarInheritance collectionObjectInheritance |
	scenery := GtScenery new.
	dotItem := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: '.') asItem.
	dotItem position: -80.53841145833339 @ 5.2789306640625.
	dotItem extent: 27.24616013286034 @ 28.0.
	foobarItem := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'NonExistentFoobarClass') asItem.
	foobarItem position: -11.459635416666572 @ -89.27231852213544.
	foobarItem extent: 152.10000610351563 @ 28.0.
	objectClassItem := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'Object') asItem.
	objectClassItem position: 39.86914062499994 @ 9.736796061197936.
	objectClassItem extent: 48.41600036621094 @ 28.0.
	bagClassItem := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'Bag') asItem.
	bagClassItem position: 130.94075520833343 @ 109.9392700195313.
	bagClassItem extent: 32.343994140625 @ 28.0.
	collectionClassItem := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'Collection') asItem.
	collectionClassItem position: -9.871744791666572 @ 115.7810668945313.
	collectionClassItem extent: 69.33201599121094 @ 28.0.
	bagObjectInheritance := scenery
			addConnectionWithStencil: (GtSceneryUMLConnectionStencil new
					relationshipType: #inheritance)
			from: bagClassItem
			to: objectClassItem.
	objectFoobarInheritance := scenery
			addConnectionWithStencil: (GtSceneryUMLConnectionStencil new
					relationshipType: #inheritance)
			from: objectClassItem
			to: foobarItem.
	collectionObjectInheritance := scenery
			addConnectionWithStencil: (GtSceneryUMLConnectionStencil new
					relationshipType: #inheritance)
			from: collectionClassItem
			to: objectClassItem.

	self assert: dotItem isInvalid.
	self assert: foobarItem isInvalid.
	self assert: objectClassItem isValid.
	self assert: bagClassItem isValid.
	self assert: collectionClassItem isValid.

	self assert: bagObjectInheritance isInvalid.
	self assert: objectFoobarInheritance isInvalid.
	self assert: collectionObjectInheritance isValid.

	^ scenery
]

{ #category : #scenery }
GtSceneryUMLClassExamples >> nonsenseClassNameIsNotValid [
	"Double-clicking is disabled."

	<gtExample>
	<return: #GtScenery>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'a few good men') asItem.
	self assert: item1 isInvalid.
	self assert: scenery isInvalid.
	^ scenery
]

{ #category : #scenery }
GtSceneryUMLClassExamples >> objectBagInheritanceIsInvalid [
	<gtExample>
	<return: #GtScenery>
	| scenery item1 item2 |
	scenery := GtScenery new.
	item1 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'Object') asItem.
	item1 position: -44.0 @ -48.0.
	item2 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'Bag') asItem.
	item2 position: -19.0 @ 26.0.
	scenery
		addConnectionWithStencil: (GtSceneryUMLConnectionStencil new
				relationshipType: #inheritance)
		from: item2
		to: item1.

	self assert: scenery connections first isInvalid.
	self assert: scenery isInvalid.

	^ scenery
]

{ #category : #scenery }
GtSceneryUMLClassExamples >> objectClassIsValid [
	"Double-clicking goes to the class"

	<gtExample>
	<return: #GtScenery>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'Object') asItem.
	self assert: item1 isValid.
	self assert: scenery isValid.
	^ scenery
]

{ #category : #scenery }
GtSceneryUMLClassExamples >> objectCollectionInheritanceIsValid [
	<gtExample>
	<return: #GtScenery>
	| scenery item1 item2 |
	scenery := GtScenery new.
	item1 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'Object') asItem.
	item1 position: -44.0 @ -48.0.
	item2 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'Collection') asItem.
	item2 position: -19.0 @ 26.0.
	scenery
		addConnectionWithStencil: (GtSceneryUMLConnectionStencil new
				relationshipType: #inheritance)
		from: item2
		to: item1.

	self assert: scenery connections first isValid.
	self assert: scenery isValid.

	^ scenery
]
