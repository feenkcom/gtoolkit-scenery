"
Sceneries to explain GtScenery and related classes.
"
Class {
	#name : #GtSceneryExplanationExamples,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #example }
GtSceneryExplanationExamples >> keyClassesUMLScenery [
<gtExample>
| scenery item1 item2 item3 item4 item5 item6 item7 item8 item9 item10 item11 item12 item13 item14 |
scenery := GtScenery new.
item1 := scenery
		addItem: (GtSceneryUMLClassStencil new
				text: ((BlRunRopedText string: 'GtScenery')
						attributeRuns: (BlRunTree basicNew
								instVarAt: 1
									put: (BlRunTreeLeafNode basicNew
											instVarAt: 1 put: 10;
											instVarAt: 2
												put: ((Array new: 3)
														at: 1 put: (BlFontWeightAttribute new weight: 700);
														at: 2
															put: (BlFontFamilyAttribute new beNotOverwritableByStyler name: 'Source Sans Pro');
														at: 3
															put: (BlTextForegroundAttribute new beNotOverwritableByStyler
																	paint: (Color
																			r: 0.0
																			g: 0.0
																			b: 0.0
																			alpha: 1.0));
														yourself);
											yourself);
								yourself)) asRopedText) asItem.
item1 position: 196.21819051106775 @ -199.78676350911456.
item1 extent: 73.70001220703125 @ 28.0.
item2 := scenery
		addItem: (GtSceneryUMLClassStencil new
				text: ((BlRunRopedText string: 'GtSceneryItem')
						attributeRuns: (BlRunTree basicNew
								instVarAt: 1
									put: (BlRunTreeLeafNode basicNew
											instVarAt: 1 put: 14;
											instVarAt: 2
												put: ((Array new: 3)
														at: 1 put: (BlFontWeightAttribute new weight: 700);
														at: 2
															put: (BlFontFamilyAttribute new beNotOverwritableByStyler name: 'Source Sans Pro');
														at: 3
															put: (BlTextForegroundAttribute new beNotOverwritableByStyler
																	paint: (Color
																			r: 0.0
																			g: 0.0
																			b: 0.0
																			alpha: 1.0));
														yourself);
											yourself);
								yourself)) asRopedText) asItem.
item2 position: 421.918202718099 @ -81.78676350911456.
item2 extent: 102.27401733398438 @ 28.0.
item3 := scenery
		addItem: (GtSceneryUMLClassStencil new
				text: ((BlRunRopedText string: 'GtSceneryItemStencil')
						attributeRuns: (BlRunTree basicNew
								instVarAt: 1
									put: (BlRunTreeLeafNode basicNew
											instVarAt: 1 put: 21;
											instVarAt: 2
												put: ((Array new: 3)
														at: 1 put: (BlFontWeightAttribute new weight: 700);
														at: 2
															put: (BlFontFamilyAttribute new beNotOverwritableByStyler name: 'Source Sans Pro');
														at: 3
															put: (BlTextForegroundAttribute new beNotOverwritableByStyler
																	paint: (Color
																			r: 0.0
																			g: 0.0
																			b: 0.0
																			alpha: 1.0));
														yourself);
											yourself);
								yourself)) asRopedText) asItem.
item3 position: 134.19222005208337 @ -57.786763509114564.
item3 extent: 144.44200134277344 @ 28.0.
item4 := scenery
		addItem: (GtSceneryUMLClassStencil new
				text: ((BlRunRopedText string: 'GtSceneryTextLabelStencil')
						attributeRuns: (BlRunTree basicNew
								instVarAt: 1
									put: (BlRunTreeLeafNode basicNew
											instVarAt: 1 put: 26;
											instVarAt: 2
												put: ((Array new: 3)
														at: 1 put: (BlFontWeightAttribute new weight: 700);
														at: 2
															put: (BlFontFamilyAttribute new beNotOverwritableByStyler name: 'Source Sans Pro');
														at: 3
															put: (BlTextForegroundAttribute new beNotOverwritableByStyler
																	paint: (Color
																			r: 0.0
																			g: 0.0
																			b: 0.0
																			alpha: 1.0));
														yourself);
											yourself);
								yourself)) asRopedText) asItem.
item4 position: 274.83453369140625 @ 120.65036010742188.
item4 extent: 175.41000366210938 @ 28.0.
item5 := scenery
		addItem: (GtSceneryUMLClassStencil new
				text: ((BlRunRopedText string: 'GtSceneryConnection')
						attributeRuns: (BlRunTree basicNew
								instVarAt: 1
									put: (BlRunTreeLeafNode basicNew
											instVarAt: 1 put: 20;
											instVarAt: 2
												put: ((Array new: 3)
														at: 1 put: (BlFontWeightAttribute new weight: 700);
														at: 2
															put: (BlFontFamilyAttribute new beNotOverwritableByStyler name: 'Source Sans Pro');
														at: 3
															put: (BlTextForegroundAttribute new beNotOverwritableByStyler
																	paint: (Color
																			r: 0.0
																			g: 0.0
																			b: 0.0
																			alpha: 1.0));
														yourself);
											yourself);
								yourself)) asRopedText) asItem.
item5 position: -88.081797281901 @ -84.78676350911456.
item5 extent: 144.28799438476563 @ 28.0.
item6 := scenery
		addItem: (GtSceneryUMLClassStencil new
				text: ((BlRunRopedText string: 'GtSceneryDraggableItem')
						attributeRuns: (BlRunTree basicNew
								instVarAt: 1
									put: (BlRunTreeLeafNode basicNew
											instVarAt: 1 put: 23;
											instVarAt: 2
												put: ((Array new: 3)
														at: 1 put: (BlFontWeightAttribute new weight: 700);
														at: 2
															put: (BlFontFamilyAttribute new beNotOverwritableByStyler name: 'Source Sans Pro');
														at: 3
															put: (BlTextForegroundAttribute new beNotOverwritableByStyler
																	paint: (Color
																			r: 0.0
																			g: 0.0
																			b: 0.0
																			alpha: 1.0));
														yourself);
											yourself);
								yourself)) asRopedText) asItem.
item6 position: 194.72255452473985 @ 23.080637613932254.
item6 extent: 165.06402587890625 @ 28.0.
item7 := scenery
		addItem: (GtSceneryUMLClassStencil new
				text: ((BlRunRopedText string: 'GtSceneryUMLClassStencil')
						attributeRuns: (BlRunTree basicNew
								instVarAt: 1
									put: (BlRunTreeLeafNode basicNew
											instVarAt: 1 put: 25;
											instVarAt: 2
												put: ((Array new: 3)
														at: 1 put: (BlFontWeightAttribute new weight: 700);
														at: 2
															put: (BlFontFamilyAttribute new beNotOverwritableByStyler name: 'Source Sans Pro');
														at: 3
															put: (BlTextForegroundAttribute new beNotOverwritableByStyler
																	paint: (Color
																			r: 0.0
																			g: 0.0
																			b: 0.0
																			alpha: 1.0));
														yourself);
											yourself);
								yourself)) asRopedText) asItem.
item7 position: 403.68102740384023 @ 248.0837782672741.
item7 extent: 174.52798461914068 @ 28.0.
item8 := scenery
		addItem: (GtSceneryUMLClassStencil new
				text: ((BlRunRopedText string: 'BrStencil')
						attributeRuns: (BlRunTree basicNew
								instVarAt: 1
									put: (BlRunTreeLeafNode basicNew
											instVarAt: 1 put: 10;
											instVarAt: 2
												put: ((Array new: 3)
														at: 1 put: (BlFontWeightAttribute new weight: 700);
														at: 2
															put: (BlFontFamilyAttribute new beNotOverwritableByStyler name: 'Source Sans Pro');
														at: 3
															put: (BlTextForegroundAttribute new beNotOverwritableByStyler
																	paint: (Color
																			r: 0.0
																			g: 0.0
																			b: 0.0
																			alpha: 1.0));
														yourself);
											yourself);
								yourself)) asRopedText) asItem.
item8 position: 352.24680802997494 @ -291.2854736222504.
item8 extent: 66.20999145507813 @ 28.0.
item9 := scenery
		addItem: (GtSceneryUMLClassStencil new
				text: ((BlRunRopedText string: 'GtSceneryElement')
						attributeRuns: (BlRunTree basicNew
								instVarAt: 1
									put: (BlRunTreeLeafNode basicNew
											instVarAt: 1 put: 17;
											instVarAt: 2
												put: ((Array new: 3)
														at: 1 put: (BlFontWeightAttribute new weight: 700);
														at: 2
															put: (BlFontFamilyAttribute new beNotOverwritableByStyler name: 'Source Sans Pro');
														at: 3
															put: (BlTextForegroundAttribute new beNotOverwritableByStyler
																	paint: (Color
																			r: 0.0
																			g: 0.0
																			b: 0.0
																			alpha: 1.0));
														yourself);
											yourself);
								yourself)) asRopedText) asItem.
item9 position: 545.5333532318884 @ -196.83002742205446.
item9 extent: 125.24800109863281 @ 28.0.
item10 := scenery
		addItem: (GtSceneryUMLClassStencil new
				text: ((BlRunRopedText string: 'BlElement')
						attributeRuns: (BlRunTree basicNew
								instVarAt: 1
									put: (BlRunTreeLeafNode basicNew
											instVarAt: 1 put: 10;
											instVarAt: 2
												put: ((Array new: 3)
														at: 1 put: (BlFontWeightAttribute new weight: 700);
														at: 2
															put: (BlFontFamilyAttribute new beNotOverwritableByStyler name: 'Source Sans Pro');
														at: 3
															put: (BlTextForegroundAttribute new beNotOverwritableByStyler
																	paint: (Color
																			r: 0.0
																			g: 0.0
																			b: 0.0
																			alpha: 1.0));
														yourself);
											yourself);
								yourself)) asRopedText) asItem.
item10 position: 642.6791656147636 @ -285.07343465728786.
item10 extent: 74.02198791503906 @ 28.0.
item11 := scenery
		addItem: (GtSceneryUMLClassStencil new
				text: ((BlRunRopedText string: 'GtSceneryTextLabelElement')
						attributeRuns: (BlRunTree basicNew
								instVarAt: 1
									put: (BlRunTreeLeafNode basicNew
											instVarAt: 1 put: 26;
											instVarAt: 2
												put: ((Array new: 3)
														at: 1 put: (BlFontWeightAttribute new weight: 700);
														at: 2
															put: (BlFontFamilyAttribute new beNotOverwritableByStyler name: 'Source Sans Pro');
														at: 3
															put: (BlTextForegroundAttribute new beNotOverwritableByStyler
																	paint: (Color
																			r: 0.0
																			g: 0.0
																			b: 0.0
																			alpha: 1.0));
														yourself);
											yourself);
								yourself)) asRopedText) asItem.
item11 position: 691.0785651552062 @ 119.39505476031388.
item11 extent: 184.79000854492188 @ 28.0.
item12 := scenery
		addItem: (GtSceneryUMLClassStencil new
				text: ((BlRunRopedText string: 'GtSceneryUMLClassElement')
						attributeRuns: (BlRunTree basicNew
								instVarAt: 1
									put: (BlRunTreeLeafNode basicNew
											instVarAt: 1 put: 25;
											instVarAt: 2
												put: ((Array new: 3)
														at: 1 put: (BlFontWeightAttribute new weight: 700);
														at: 2
															put: (BlFontFamilyAttribute new beNotOverwritableByStyler name: 'Source Sans Pro');
														at: 3
															put: (BlTextForegroundAttribute new beNotOverwritableByStyler
																	paint: (Color
																			r: 0.0
																			g: 0.0
																			b: 0.0
																			alpha: 1.0));
														yourself);
											yourself);
								yourself)) asRopedText) asItem.
item12 position: 729.5386028687202 @ 247.39997216059788.
item12 extent: 183.90798950195313 @ 28.0.
item13 := scenery
		addItem: (GtSceneryUMLClassStencil new
				text: ((BlRunRopedText string: 'GtSceneryParabollaArcStencil')
						attributeRuns: (BlRunTree basicNew
								instVarAt: 1
									put: (BlRunTreeLeafNode basicNew
											instVarAt: 1 put: 29;
											instVarAt: 2
												put: ((Array new: 3)
														at: 1 put: (BlFontWeightAttribute new weight: 700);
														at: 2
															put: (BlFontFamilyAttribute new beNotOverwritableByStyler name: 'Source Sans Pro');
														at: 3
															put: (BlTextForegroundAttribute new beNotOverwritableByStyler
																	paint: (Color
																			r: 0.0
																			g: 0.0
																			b: 0.0
																			alpha: 1.0));
														yourself);
											yourself);
								yourself)) asRopedText) asItem.
item13 position: -6.343481586303525 @ 71.85735198908503.
item13 extent: 194.84202575683594 @ 28.0.
item14 := scenery
		addItem: (GtSceneryUMLClassStencil new
				text: ((BlRunRopedText string: 'GtSceneryStraightArcStencil')
						attributeRuns: (BlRunTree basicNew
								instVarAt: 1
									put: (BlRunTreeLeafNode basicNew
											instVarAt: 1 put: 28;
											instVarAt: 2
												put: ((Array new: 3)
														at: 1 put: (BlFontWeightAttribute new weight: 700);
														at: 2
															put: (BlFontFamilyAttribute new beNotOverwritableByStyler name: 'Source Sans Pro');
														at: 3
															put: (BlTextForegroundAttribute new beNotOverwritableByStyler
																	paint: (Color
																			r: 0.0
																			g: 0.0
																			b: 0.0
																			alpha: 1.0));
														yourself);
											yourself);
								yourself)) asRopedText) asItem.
item14 position: -123.41241366901613 @ 188.00758840800995.
item14 extent: 185.86801147460938 @ 28.0.
scenery
	addConnectionWithStencil: (GtSceneryStraightArcStencil new
			labelText: 'holds';
			fontSize: 20;
			curvatureFraction: 0;
			arrowLengthFraction: 2.5;
			arrowHeadType: #simple;
			yourself)
	from: item1
	to: item2.
scenery
	addConnectionWithStencil: (GtSceneryStraightArcStencil new
			labelText: 'holds';
			fontSize: 20;
			curvatureFraction: 0;
			arrowLengthFraction: 2.5;
			arrowHeadType: #simple;
			yourself)
	from: item1
	to: item5.
scenery
	addConnectionWithStencil: (GtSceneryStraightArcStencil new
			labelText: nil;
			fontSize: 20;
			curvatureFraction: 0;
			arrowLengthFraction: 2.5;
			arrowHeadType: #triangle;
			yourself)
	from: item6
	to: item3.
scenery
	addConnectionWithStencil: (GtSceneryStraightArcStencil new
			labelText: nil;
			fontSize: 20;
			curvatureFraction: 0;
			arrowLengthFraction: 2.5;
			arrowHeadType: #triangle;
			yourself)
	from: item4
	to: item6.
scenery
	addConnectionWithStencil: (GtSceneryStraightArcStencil new
			labelText: nil;
			fontSize: 20;
			curvatureFraction: 0;
			arrowLengthFraction: 2.5;
			arrowHeadType: #triangle;
			yourself)
	from: item7
	to: item4.
scenery
	addConnectionWithStencil: (GtSceneryStraightArcStencil new
			labelText: 'holds';
			fontSize: 20;
			curvatureFraction: 0;
			arrowLengthFraction: 2.5;
			arrowHeadType: #simple;
			yourself)
	from: item2
	to: item7.
scenery
	addConnectionWithStencil: (GtSceneryStraightArcStencil new
			labelText: nil;
			fontSize: 20;
			curvatureFraction: 0;
			arrowLengthFraction: 2.5;
			arrowHeadType: #triangle;
			yourself)
	from: item1
	to: item8.
scenery
	addConnectionWithStencil: (GtSceneryStraightArcStencil new
			labelText: nil;
			fontSize: 20;
			curvatureFraction: 0;
			arrowLengthFraction: 2.5;
			arrowHeadType: #triangle;
			yourself)
	from: item3
	to: item8.
scenery
	addConnectionWithStencil: (GtSceneryStraightArcStencil new
			labelText: nil;
			fontSize: 20;
			curvatureFraction: 0;
			arrowLengthFraction: 2.5;
			arrowHeadType: #triangle;
			yourself)
	from: item9
	to: item10.
scenery
	addConnectionWithStencil: (GtSceneryStraightArcStencil new
			labelText: 'creates';
			fontSize: 20;
			curvatureFraction: 0;
			arrowLengthFraction: 2.5;
			arrowHeadType: #simple;
			yourself)
	from: item7
	to: item12.
scenery
	addConnectionWithStencil: (GtSceneryStraightArcStencil new
			labelText: 'creates';
			fontSize: 20;
			curvatureFraction: 0;
			arrowLengthFraction: 2.5;
			arrowHeadType: #simple;
			yourself)
	from: item4
	to: item11.
scenery
	addConnectionWithStencil: (GtSceneryStraightArcStencil new
			labelText: nil;
			fontSize: 20;
			curvatureFraction: 0;
			arrowLengthFraction: 2.5;
			arrowHeadType: #triangle;
			yourself)
	from: item11
	to: item10.
scenery
	addConnectionWithStencil: (GtSceneryStraightArcStencil new
			labelText: nil;
			fontSize: 20;
			curvatureFraction: 0;
			arrowLengthFraction: 2.5;
			arrowHeadType: #triangle;
			yourself)
	from: item12
	to: item11.
scenery
	addConnectionWithStencil: (GtSceneryStraightArcStencil new
			labelText: 'creates';
			fontSize: 20;
			curvatureFraction: 0;
			arrowLengthFraction: 2.5;
			arrowHeadType: #simple;
			yourself)
	from: item1
	to: item9.
scenery
	addConnectionWithStencil: (GtSceneryStraightArcStencil new
			labelText: nil;
			fontSize: 20;
			curvatureFraction: 0;
			arrowLengthFraction: 2.5;
			arrowHeadType: #triangle;
			yourself)
	from: item13
	to: item3.
scenery
	addConnectionWithStencil: (GtSceneryStraightArcStencil new
			labelText: nil;
			fontSize: 20;
			curvatureFraction: 0;
			arrowLengthFraction: 2.5;
			arrowHeadType: #triangle;
			yourself)
	from: item14
	to: item13.
scenery
	addConnectionWithStencil: (GtSceneryStraightArcStencil new
			labelText: 'holds';
			fontSize: 20;
			curvatureFraction: 0;
			arrowLengthFraction: 2.5;
			arrowHeadType: #simple;
			yourself)
	from: item5
	to: item14.
scenery.
^ scenery
]
