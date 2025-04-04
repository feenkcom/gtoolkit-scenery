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
					label: 'GtScenery';
					width: 73.70001220703125) asItem.
	item1 position: 196.21819051106775 @ -199.78676350911456.
	item1 extent: 73.70001220703125 @ 28.0.
	item2 := scenery
			addItem: (GtSceneryUMLClassStencil new
					label: 'GtSceneryItem';
					width: 102.27401733398438) asItem.
	item2 position: 421.918202718099 @ -81.78676350911456.
	item2 extent: 102.27401733398438 @ 28.0.
	item3 := scenery
			addItem: (GtSceneryUMLClassStencil new
					label: 'GtSceneryEntityStencil';
					width: 144.44200134277344) asItem.
	item3 position: 144.19222005208337 @ -73.78676350911456.
	item3 extent: 144.44200134277344 @ 28.0.
	item4 := scenery
			addItem: (GtSceneryUMLClassStencil new
					label: 'GtSceneryTextLabelStencil';
					width: 175.41000366210938) asItem.
	item4 position: 284.83453369140625 @ 115.65036010742188.
	item4 extent: 175.41000366210938 @ 28.0.
	item5 := scenery
			addItem: (GtSceneryUMLClassStencil new
					label: 'GtSceneryConnection';
					width: 144.28799438476563) asItem.
	item5 position: -91.081797281901 @ -81.78676350911456.
	item5 extent: 144.28799438476563 @ 28.0.
	item6 := scenery
			addItem: (GtSceneryUMLClassStencil new
					label: 'GtSceneryDraggableItemStencil';
					width: 201.2023352603582) asItem.
	item6 position: 194.72255452473985 @ 23.080637613932254.
	item6 extent: 201.2023352603582 @ 28.0.
	item7 := scenery
			addItem: (GtSceneryUMLClassStencil new
					label: 'GtSceneryUMLClassStencil';
					width: 174.52798461914068) asItem.
	item7 position: 403.68102740384023 @ 248.0837782672741.
	item7 extent: 174.52798461914068 @ 28.0.
	item8 := scenery
			addItem: (GtSceneryUMLClassStencil new
					label: 'BrStencil';
					width: 66.20999145507813) asItem.
	item8 position: 352.24680802997494 @ -291.2854736222504.
	item8 extent: 66.20999145507813 @ 28.0.
	item9 := scenery
			addItem: (GtSceneryUMLClassStencil new
					label: 'GtSceneryElement';
					width: 125.24800109863281) asItem.
	item9 position: 545.5333532318884 @ -196.83002742205446.
	item9 extent: 125.24800109863281 @ 28.0.
	item10 := scenery
			addItem: (GtSceneryUMLClassStencil new
					label: 'BlElement';
					width: 74.02198791503906) asItem.
	item10 position: 642.6791656147636 @ -285.07343465728786.
	item10 extent: 74.02198791503906 @ 28.0.
	item11 := scenery
			addItem: (GtSceneryUMLClassStencil new
					label: 'GtSceneryTextLabelElement';
					width: 184.79000854492188) asItem.
	item11 position: 691.0785651552062 @ 119.39505476031388.
	item11 extent: 184.79000854492188 @ 28.0.
	item12 := scenery
			addItem: (GtSceneryUMLClassStencil new
					label: 'GtSceneryUMLClassElement';
					width: 183.90798950195313) asItem.
	item12 position: 729.5386028687202 @ 247.39997216059788.
	item12 extent: 183.90798950195313 @ 28.0.
	item13 := scenery
			addItem: (GtSceneryUMLClassStencil new
					label: 'GtSceneryParabollaArcStencil';
					width: 194.84202575683594) asItem.
	item13 position: -5.343481586303525 @ 67.85735198908503.
	item13 extent: 194.84202575683594 @ 28.0.
	item14 := scenery
			addItem: (GtSceneryUMLClassStencil new
					label: 'GtSceneryStraightArcStencil';
					width: 185.86801147460938) asItem.
	item14 position: -123.41241366901613 @ 188.00758840800995.
	item14 extent: 185.86801147460938 @ 28.0.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new labelText: 'holds')
		from: item1
		to: item2.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new labelText: 'holds')
		from: item1
		to: item5.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				arrowHeadType: #triangle)
		from: item6
		to: item3.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				arrowHeadType: #triangle)
		from: item4
		to: item6.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				arrowHeadType: #triangle)
		from: item7
		to: item4.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new labelText: 'holds')
		from: item2
		to: item7.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				arrowHeadType: #triangle)
		from: item1
		to: item8.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				arrowHeadType: #triangle)
		from: item3
		to: item8.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				arrowHeadType: #triangle)
		from: item9
		to: item10.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				labelText: 'creates')
		from: item7
		to: item12.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				labelText: 'creates')
		from: item4
		to: item11.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				arrowHeadType: #triangle)
		from: item11
		to: item10.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				arrowHeadType: #triangle)
		from: item12
		to: item11.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				labelText: 'creates')
		from: item1
		to: item9.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				arrowHeadType: #triangle)
		from: item13
		to: item3.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				arrowHeadType: #triangle)
		from: item14
		to: item13.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new labelText: 'holds')
		from: item5
		to: item14.

	^ scenery
]
