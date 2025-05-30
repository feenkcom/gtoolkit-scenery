"
Sceneries to explain GtScenery and related classes.
"
Class {
	#name : #GtSceneryExplanationExamples,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #scenery }
GtSceneryExplanationExamples >> keyClassesUMLScenery [
	"NB: Generated by GtScenery>>#storeAsExampleMethod -- do not edit."

	<gtExample>
	<noTest>
	<storedScenery>
	<return: #GtScenery>
	| scenery item1 item2 item3 item4 item5 item6 item7 item8 item9 item10 item11 item12 item13 item14 |
	scenery := GtScenery new.
	item1 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'GtScenery') asItem.
	item1 position: 130.21819051106775 @ -211.78676350911456.
	item1 extent: 113.24803161621094 @ 40.0.
	item2 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'GtSceneryItem') asItem.
	item2 position: 493.918202718099 @ -96.78676350911456.
	item2 extent: 159.1360321044922 @ 40.0.
	item3 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'GtSceneryEntityStencil') asItem.
	item3 position: 169.19222005208337 @ -86.78676350911456.
	item3 extent: 240.3760528564453 @ 40.0.
	item4 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'GtSceneryTextLabelStencil') asItem.
	item4 position: 284.83453369140625 @ 115.65036010742188.
	item4 extent: 277.0960388183594 @ 40.0.
	item5 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'GtSceneryConnection') asItem.
	item5 position: -169.081797281901 @ -85.78676350911456.
	item5 extent: 228.97604370117188 @ 40.0.
	item6 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'GtSceneryDraggableItemStencil') asItem.
	item6 position: 192.72255452473985 @ 11.080637613932254.
	item6 extent: 328.96002197265625 @ 40.0.
	item7 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'GtSceneryUMLClassStencil') asItem.
	item7 position: 386.68102740384023 @ 246.0837782672741.
	item7 extent: 277.26403808593756 @ 40.0.
	item8 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'BrStencil') asItem.
	item8 position: 236.24680802997494 @ -330.2854736222504.
	item8 extent: 100.45600891113281 @ 40.0.
	item9 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'GtSceneryElement') asItem.
	item9 position: 545.5333532318884 @ -196.83002742205446.
	item9 extent: 196.9600372314453 @ 40.0.
	item10 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'BlElement') asItem.
	item10 position: 645.6791656147636 @ -316.07343465728786.
	item10 extent: 113.94400024414063 @ 40.0.
	item11 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'GtSceneryTextLabelElement') asItem.
	item11 position: 742.0785651552062 @ 109.39505476031388.
	item11 extent: 292.79205322265625 @ 40.0.
	item12 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'GtSceneryUMLClassElement') asItem.
	item12 position: 792.5386028687202 @ 234.39997216059788.
	item12 extent: 292.96002197265625 @ 40.0.
	item13 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'GtSceneryParabollaArcStencil') asItem.
	item13 position: -5.343481586303525 @ 67.85735198908503.
	item13 extent: 308.4639892578125 @ 40.0.
	item14 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new label: 'GtSceneryStraightArcStencil') asItem.
	item14 position: -157.41241366901613 @ 216.00758840800995.
	item14 extent: 292.72003173828125 @ 40.0.
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
	scenery
		storeStringMethodName: 'GtSceneryExplanationExamples>>#keyClassesUMLScenery'.
	^ scenery
]
