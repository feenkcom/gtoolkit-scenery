"
These examples have been created directly editing a Scenery and saving the storeString.
"
Class {
	#name : #GtSceneryEditedExamples,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #example }
GtSceneryEditedExamples >> eyeconScenery [
	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryPictureStencil new
					fileReference: FileLocator gtResource / 'feenkcom' / 'gtoolkit-demos' / 'doc' / 'reflection'
							/ 'eyecon.png') asItem.
	item1 extent: 184.8927882491589 @ 150.0.
	^ scenery
]

{ #category : #'as yet unclassified' }
GtSceneryEditedExamples >> foobarTextLabelScenery [
	<gtExample>
	| scenery item1 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryTextLabelStencil new label: 'Foobar') asItem.
	^ scenery
]

{ #category : #'as yet unclassified' }
GtSceneryEditedExamples >> newScenery [
	<gtExample>
	| emptyScenery |
	emptyScenery := GtScenery new.
	self assert: emptyScenery items isEmpty.
	self assert: emptyScenery connections isEmpty.
	^ emptyScenery
]

{ #category : #example }
GtSceneryEditedExamples >> reflectionScenery [
	<gtExample>
	| scenery item1 item2 item3 item4 item5 item6 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryShapeStencil new
					geometry: BlRectangleGeometry new;
					backgroundColor: (Color
							r: 0.0
							g: 0.0
							b: 0.0
							alpha: 1.0)) asItem.
	item1 position: 153.95426432291697 @ 173.91152954101563.
	item1 extent: 544.977010091146 @ 5.116780598958371.
	item2 := scenery
			addItem: (GtSceneryTextLabelStencil new
					text: ((BlRunRopedText string: 'Metaobjects')
							attributeRuns: (BlRunTree basicNew
									instVarAt: 1
										put: (BlRunTreeLeafNode basicNew
												instVarAt: 1 put: 12;
												instVarAt: 2
													put: ((Array new: 4)
															at: 1
																put: (BlFontFamilyAttribute new beNotOverwritableByStyler name: 'Source Sans Pro');
															at: 2 put: (BlFontSizeAttribute new size: 24);
															at: 3
																put: (BlTextForegroundAttribute new beNotOverwritableByStyler
																		paint: (Color
																				r: 0.0
																				g: 0.0
																				b: 0.0
																				alpha: 1.0));
															at: 4 put: (BlFontWeightAttribute new weight: 700);
															yourself);
												yourself);
									yourself)) asRopedText) asItem.
	item2 position: 163.71016438802064 @ 83.55168660481766.
	item2 extent: 147.1851650119288 @ 40.0.
	item3 := scenery
			addItem: (GtSceneryTextLabelStencil new
					text: ((BlRunRopedText string: 'Objects')
							attributeRuns: (BlRunTree basicNew
									instVarAt: 1
										put: (BlRunTreeLeafNode basicNew
												instVarAt: 1 put: 8;
												instVarAt: 2
													put: ((Array new: 4)
															at: 1
																put: (BlFontFamilyAttribute new beNotOverwritableByStyler name: 'Source Sans Pro');
															at: 2 put: (BlFontSizeAttribute new size: 24);
															at: 3
																put: (BlTextForegroundAttribute new beNotOverwritableByStyler
																		paint: (Color
																				r: 0.0
																				g: 0.0
																				b: 0.0
																				alpha: 1.0));
															at: 4 put: (BlFontWeightAttribute new weight: 700);
															yourself);
												yourself);
									yourself)) asRopedText) asItem.
	item3 position: 167.99812825520814 @ 224.44733683268225.
	item3 extent: 94.23641954617011 @ 40.0.
	item4 := scenery
			addItem: (GtSceneryPictureStencil new
					fileReference: FileLocator gtResource / 'feenkcom' / 'gtoolkit-demos' / 'doc' / 'reflection'
							/ 'eyecon.png') asItem.
	item4 position: 329.0800063175572 @ 232.03615315755206.
	item4 extent: 67.20118595638962 @ 45.76359066473759.
	item5 := scenery
			addItem: (GtSceneryShapeStencil new
					geometry: BlRectangleGeometry new;
					backgroundColor: (Color
							r: 1.0
							g: 1.0
							b: 1.0
							alpha: 1.0)) asItem.
	item5 position: 569.3061116536459 @ 231.68322796988605.
	item5 extent: 44.7463383174902 @ 44.81071937711897.
	item6 := scenery
			addItem: (GtSceneryShapeStencil new
					geometry: BlCircleGeometry new;
					backgroundColor: (Color
							r: 1.0
							g: 1.0
							b: 1.0
							alpha: 1.0)) asItem.
	item6 position: 563.4649668169094 @ 17.831766804367987.
	item6 extent: 54.3755840619865 @ 55.64617258186533.
	scenery
		addConnectionWithStencil: (GtSceneryCurvableConnectionStencil new
				labelText: 'introspection';
				fontSize: 10;
				curvatureFraction: 0;
				arrowLengthFraction: 2.5;
				yourself)
		from: item4
		to: item5.
	scenery
		addConnectionWithStencil: (GtSceneryCurvableConnectionStencil new
				labelText: 'reflection';
				fontSize: 10;
				curvatureFraction: 0.4;
				arrowLengthFraction: 2.5;
				yourself)
		from: item5
		to: item6.
	scenery
		addConnectionWithStencil: (GtSceneryCurvableConnectionStencil new
				labelText: 'reification';
				fontSize: 10;
				curvatureFraction: 0.4;
				arrowLengthFraction: 2.5;
				yourself)
		from: item6
		to: item5.
	scenery.
	^ scenery
]

{ #category : #example }
GtSceneryEditedExamples >> sceneryMindmap [
	"A basic mindmap without any styling of the nodes or edges."

	<gtExample>
	| scenery item1 item2 item3 item4 item5 item6 item7 item8 item9 item10 item11 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryMindMapNodeStencil new label: 'Scenery') asItem.
	item1 position: 126.64542643229174 @ 226.8690083821615.
	item1 extent: 56.858001708984375 @ 28.0.
	item2 := scenery
			addItem: (GtSceneryMindMapNodeStencil new label: 'Items') asItem.
	item2 position: 271.5034281412761 @ 110.8690083821615.
	item2 extent: 42.634002685546875 @ 28.0.
	item3 := scenery
			addItem: (GtSceneryMindMapNodeStencil new label: 'Connections') asItem.
	item3 position: 253.50342814127612 @ 229.8690083821615.
	item3 extent: 83.37400817871094 @ 28.0.
	item4 := scenery
			addItem: (GtSceneryMindMapNodeStencil new label: 'Created with stencils') asItem.
	item4 position: 396.137430826823 @ 69.8690083821615.
	item4 extent: 131.00201416015625 @ 28.0.
	item5 := scenery
			addItem: (GtSceneryMindMapNodeStencil new label: 'Connect two items') asItem.
	item5 position: 392.87743631998705 @ 207.8690083821615.
	item5 extent: 119.1300048828125 @ 28.0.
	item6 := scenery
			addItem: (GtSceneryMindMapNodeStencil new label: 'Rendered with stencils') asItem.
	item6 position: 393.87743631998705 @ 271.8690083821615.
	item6 extent: 142.0060272216797 @ 28.0.
	item7 := scenery
			addItem: (GtSceneryMindMapNodeStencil new label: 'Encapsulate any kind of graph node')
					asItem.
	item7 position: 395.137430826823 @ 144.8690083821615.
	item7 extent: 218.20803833007813 @ 28.0.
	item8 := scenery
			addItem: (GtSceneryMindMapNodeStencil new label: 'Use  cases') asItem.
	item8 position: 255.50342814127612 @ 371.8690083821615.
	item8 extent: 69.36000061035156 @ 28.0.
	item9 := scenery
			addItem: (GtSceneryMindMapNodeStencil new label: 'Mind maps') asItem.
	item9 position: 394.8634287516277 @ 317.8690083821615.
	item9 extent: 74.14801025390625 @ 28.0.
	item10 := scenery
			addItem: (GtSceneryMindMapNodeStencil new label: 'UML diagrams') asItem.
	item10 position: 393.8634287516277 @ 371.8690083821615.
	item10 extent: 93.18800354003906 @ 28.0.
	item11 := scenery
			addItem: (GtSceneryMindMapNodeStencil new label: 'Lepiter roadmaps') asItem.
	item11 position: 392.8634287516277 @ 428.8690083821615.
	item11 extent: 113.166015625 @ 28.0.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item1
		to: item2.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item1
		to: item3.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item2
		to: item4.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item3
		to: item5.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item3
		to: item6.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item2
		to: item7.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item1
		to: item8.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item8
		to: item9.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item8
		to: item10.
	scenery
		addConnectionWithStencil: GtSceneryLineStencil new
		from: item8
		to: item11.

	^ scenery
]

{ #category : #'as yet unclassified' }
GtSceneryEditedExamples >> simpleClassDiagram [
	"Just a fragment to illustrate different arrow types."

	<gtExample>
	| scenery item1 item2 item3 item4 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryUMLClassStencil new label: 'GtScenery') asItem.
	item1 position: 79.21819051106775 @ 81.21323649088544.
	item1 extent: 73.70001220703125 @ 28.0.
	item2 := scenery
			addItem: (GtSceneryUMLClassStencil new label: 'GtSceneryItem') asItem.
	item2 position: 192.918202718099 @ 81.21323649088544.
	item2 extent: 102.27401733398438 @ 28.0.
	item3 := scenery
			addItem: (GtSceneryUMLClassStencil new label: 'GtSceneryItemStencil') asItem.
	item3 position: 335.19222005208337 @ 81.21323649088544.
	item3 extent: 144.44200134277344 @ 28.0.
	item4 := scenery
			addItem: (GtSceneryUMLClassStencil new label: 'GtSceneryTextLabelStencil') asItem.
	item4 position: 322.83453369140625 @ 198.65036010742188.
	item4 extent: 175.41000366210938 @ 28.0.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item1
		to: item2.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item2
		to: item3.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				arrowHeadType: #triangle)
		from: item4
		to: item3.
	^ scenery
]
