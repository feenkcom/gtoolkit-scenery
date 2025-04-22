"
I collect examples validating the behavior of the storeString facility for sceneries.
I also make use of equality for sceneries, ietms, stencils and connections.

GtSceneryEntityStencil expects subclasses to implement #storeOnAttributes listing the attributes to be stored.

Each attribute `x` should have a getter `#x`, a setter `#x:` and also a `#defaultX` method, which is used not only to initialize `x`, but also to check if the value is notthe default one during storeString generation.

Subclasses can use `GtSceneryEntityStencil>>#storeWithAttributesOn:` to implement `#storeOn:`.
"
Class {
	#name : #GtSceneryStoreStringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #example }
GtSceneryStoreStringExamples >> circleShapeScenery [
	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryShapeStencil new geometry: BlCircleGeometry new) asItem.
	item1 position: 67.74245198567701 @ 69.517333984375.
	item1 extent: 200.0 @ 200.0.
	^ scenery
]

{ #category : #example }
GtSceneryStoreStringExamples >> circleShapeSceneryRestored [
	<gtExample>
	| scenery |
	scenery := self circleShapeScenery.
	self assert: scenery equals: scenery restored.
	^ scenery
]

{ #category : #accessing }
GtSceneryStoreStringExamples >> compositeScenery [
	<gtExample>
	| scenery |
	scenery := self emptyScenery.
	{self circleShapeSceneryRestored.
		self gtBookLabelSceneryRestored.
		self gtLogoFileSceneryRestored.
		self gtSceneryClassSceneryRestored.
		self inspectorOn42SceneryRestored.
		self mindmapBubbleSceneryRestored.
		self textLabelSceneryRestored} do: [ :each | scenery addScenery: each ].
	self assert: scenery equals: scenery restored.
	^ scenery
]

{ #category : #example }
GtSceneryStoreStringExamples >> emptyScenery [
	<gtExample>
	| scenery |
	scenery := GtScenery new.
	self assert: scenery items isEmpty.
	self assert: scenery connections isEmpty.
	self assert: scenery equals: GtScenery new.
	^ scenery
]

{ #category : #example }
GtSceneryStoreStringExamples >> gtBookLabelScenery [
	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryLePageTitleLabelStencil new width: 157.8820343017578) asItem.
	item1 position: 73.34053548177076 @ 70.0040181477865.
	item1 extent: 157.8820343017578 @ 28.0.
	^ scenery
]

{ #category : #example }
GtSceneryStoreStringExamples >> gtBookLabelSceneryRestored [
	<gtExample>
	| scenery |
	scenery := self gtBookLabelScenery.
	self assert: scenery equals: scenery restored.
	^ scenery
]

{ #category : #example }
GtSceneryStoreStringExamples >> gtLogoFileScenery [
	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryPictureStencil new
					fileReference: FileLocator gtResource / 'feenkcom' / 'gtoolkit' / 'doc' / 'gtoolkit.png')
					asItem.
	item1 position: 114.6820068359375 @ 242.44258626302087.
	item1 extent: 450.0 @ 150.0.
	^ scenery
]

{ #category : #example }
GtSceneryStoreStringExamples >> gtLogoFileSceneryRestored [
	<gtExample>
	| scenery |
	scenery := self gtLogoFileScenery.
	self assert: scenery equals: scenery restored.
	^ scenery
]

{ #category : #example }
GtSceneryStoreStringExamples >> gtSceneryClassScenery [
	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryUMLClassStencil new
					label: 'GtScenery';
					width: 75.74499003092455) asItem.
	item1 position: 96.35630289713549 @ 191.2457987467448.
	item1 extent: 75.74499003092455 @ 28.0.
	^ scenery
]

{ #category : #example }
GtSceneryStoreStringExamples >> gtSceneryClassSceneryRestored [
	<gtExample>
	| scenery |
	scenery := self gtSceneryClassScenery.
	self assert: scenery equals: scenery restored.
	^ scenery
]

{ #category : #example }
GtSceneryStoreStringExamples >> inspectorOn42Scenery [
	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery addItem: (GtSceneryInspectorStencil new target: [ 42 ]) asItem.
	item1 position: -105.833251953125 @ 192.30275472005212.
	item1 extent: 355.784912109375 @ 202.16888427734375.
	^ scenery
]

{ #category : #example }
GtSceneryStoreStringExamples >> inspectorOn42SceneryRestored [
	<gtExample>
	| scenery |
	scenery := self inspectorOn42Scenery.
	self assert: scenery equals: scenery restored.
	^ scenery
]

{ #category : #example }
GtSceneryStoreStringExamples >> mindmapBubbleScenery [
	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryMindMapNodeStencil new
					label: 'A mind map bubble';
					width: 126.5262896560282) asItem.
	item1 position: 5.5452868217392215 @ 973.7566582612488.
	item1 extent: 126.5262896560282 @ 28.0.
	^ scenery
]

{ #category : #example }
GtSceneryStoreStringExamples >> mindmapBubbleSceneryRestored [
	<gtExample>
	| scenery |
	scenery := self mindmapBubbleScenery.
	self assert: scenery equals: scenery restored.
	^ scenery
]

{ #category : #example }
GtSceneryStoreStringExamples >> textLabelScenery [
	<gtExample>
	| scenery item1 item2 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryTextLabelStencil new
					label: 'I am a text label';
					width: 101.5040283203125) asItem.
	item1 position: 174.287618001302 @ 188.26188151041669.
	item1 extent: 101.5040283203125 @ 28.0.
	item2 := scenery
			addItem: (GtSceneryTextLabelStencil new
					label: 'Me too!';
					width: 53.67999267578125) asItem.
	item2 position: 254.0374755859375 @ 291.11924235026044.
	item2 extent: 53.67999267578125 @ 28.0.
	^ scenery
]

{ #category : #example }
GtSceneryStoreStringExamples >> textLabelSceneryRestored [
	<gtExample>
	| scenery |
	scenery := self textLabelScenery.
	self assert: scenery equals: scenery restored.
	^ scenery
]
