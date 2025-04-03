Class {
	#name : #GtSceneryInScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #examples }
GtSceneryInScripterExamples >> dragNodeEdge_id1ZoomLevel15Factor250DragX120Y30 [
	<gtExample>
	| aScripter |
	aScripter := self mindmapWithTwoSubnodes.

	self
		scripter: aScripter
		sceneryZoomLevel: 1.5
		childrenTranslationFactor: 250.

	self
		scripter: aScripter
		dragNodeEdgeFromItemId: (GtSceneryItemId indexed: 1)
		by: 120 @ 30.

	^ aScripter
]

{ #category : #examples }
GtSceneryInScripterExamples >> dragNodeEdge_id1ZoomLevel15Factor250DragX120Y30_releaseDragging [
	<gtExample>
	| aScripter |
	aScripter := self dragNodeEdge_id1ZoomLevel15Factor250DragX120Y30.
	self releaseDragging: aScripter.

	^ aScripter
]

{ #category : #examples }
GtSceneryInScripterExamples >> dragNodeEdge_id2ZoomLevel05Factor200DragX120Y30 [
	<gtExample>
	| aScripter |
	aScripter := self mindmapWithTwoSubnodes.

	self
		scripter: aScripter
		sceneryZoomLevel: 0.5
		childrenTranslationFactor: 200.

	self
		scripter: aScripter
		dragNodeEdgeFromItemId: (GtSceneryItemId indexed: 2)
		by: 120 @ 30.

	^ aScripter
]

{ #category : #examples }
GtSceneryInScripterExamples >> dragNodeEdge_id2ZoomLevel05Factor200DragX120Y30_releaseDragging [
	<gtExample>
	| aScripter |
	aScripter := self dragNodeEdge_id2ZoomLevel05Factor200DragX120Y30.
	self releaseDragging: aScripter.
	^ aScripter
]

{ #category : #examples }
GtSceneryInScripterExamples >> dragNodeEdge_id2ZoomLevel05Factor200DragXM120Y30 [
	<gtExample>
	| aScripter |
	aScripter := self mindmapWithTwoSubnodes.

	self
		scripter: aScripter
		sceneryZoomLevel: 0.5
		childrenTranslationFactor: 200.

	self
		scripter: aScripter
		dragNodeEdgeFromItemId: (GtSceneryItemId indexed: 2)
		by: -120 @ 30.

	^ aScripter
]

{ #category : #examples }
GtSceneryInScripterExamples >> dragNodeEdge_id2ZoomLevel15Factor250DragX120Y30 [
	<gtExample>
	| aScripter |
	aScripter := self mindmapWithTwoSubnodes.

	self
		scripter: aScripter
		sceneryZoomLevel: 1.5
		childrenTranslationFactor: 250.

	self
		scripter: aScripter
		dragNodeEdgeFromItemId: (GtSceneryItemId indexed: 2)
		by: 120 @ 30.

	^ aScripter
]

{ #category : #examples }
GtSceneryInScripterExamples >> dragNodeEdge_id2ZoomLevel15Factor250DragXM120Y30 [
	<gtExample>
	| aScripter |
	aScripter := self mindmapWithTwoSubnodes.

	self
		scripter: aScripter
		sceneryZoomLevel: 1.5
		childrenTranslationFactor: 250.

	self
		scripter: aScripter
		dragNodeEdgeFromItemId: (GtSceneryItemId indexed: 2)
		by: -120 @ 30.

	^ aScripter
]

{ #category : #examples }
GtSceneryInScripterExamples >> mindmapWithTwoSubnodes [
	<gtExample>
	^ self scripterWithModel: [ GtSceneryMindmapExamples new mindmapWithTwoSubnodes ]
]

{ #category : #examples }
GtSceneryInScripterExamples >> releaseDragging: aScripter [
	<gtExample>
	aScripter
		substeps: 'Release dragging'
		do: [ :aStep | 
			aStep mouseUp
				label: 'Mouse up';
				modifiers: BlKeyModifiers ctrl;
				play.

			aStep assert
				label: 'Mouse position element';
				notExists;
				// #'scenery--mouse-position';
				play ]
]

{ #category : #examples }
GtSceneryInScripterExamples >> resizeNode_id2ZoomLevel15Factor250DragX120Y30 [
	<gtExample>
	| aScripter |
	aScripter := self
			dragNodeEdge_id1ZoomLevel15Factor250DragX120Y30_releaseDragging.

	self
		scripter: aScripter
		dragNodeResizerFromItemId: (GtSceneryItemId indexed: 2)
		by: 30 @ 0.

	^ aScripter
]

{ #category : #examples }
GtSceneryInScripterExamples >> scripter: aScripter dragNodeEdgeFromItemId: aSceneryItemId by: aPoint [
	<gtExample>
	| anExpectedStartPosition anExpectedLastPosition aStartPosition |
	aScripter
		substeps: ('Drag node edge from {1} by {2}'
				format: {aSceneryItemId.
						aPoint})
		do: [ :aStep | 
			aStep mouseMoveOver
				label: 'Move mouse over target element';
				// aSceneryItemId;
				play.
			aStep mouseDown
				label: 'Mouse down';
				modifiers: BlKeyModifiers ctrl;
				play.
			aStep mouseMove
				label: ('Move mouse by {1}' format: {aPoint});
				by: aPoint;
				modifiers: BlKeyModifiers ctrl;
				play.

			anExpectedStartPosition := aScripter events reversed
					detectEventOfClass: BlDragStartEvent
					ifFound: [ :anEvent | anEvent position ]
					ifNone: [ NotFound signal: BlDragEvent in: aScripter events ].
			aStep assert
				label: 'Assert edge start point position is inside of node bounds';
				satisfies: [ :anElement | 
						| aHandler aPosition |
						aHandler := anElement eventDispatcher handlers
								detect: [ :each | each isKindOf: GtSceneryDragHandler ].
						aPosition := aHandler instVarNamed: #originalChildrenPosition.
						aStartPosition := anElement parent childrenPointToLocal: aPosition.
						aStartPosition := anElement parent localPointToGlobal: aStartPosition.
						anElement bounds inSpace asRectangle containsPoint: aStartPosition ]
					description: [ :anElement | 
						'Node {1} bounds in space {2} does not contains {3} point'
							format: {aSceneryItemId.
									anElement bounds inSpace.
									aStartPosition} ];
				// aSceneryItemId;
				play.

			aStep assert
				label: 'Assert edge start point position in space';
				satisfies: [ :anElement | aStartPosition closeTo: anExpectedStartPosition precision: 0.0001 ]
					description: [ :anElement | 
						'Edge start position in space {1} ~= drag start event position {2}'
							format: {aStartPosition.
									anExpectedStartPosition} ];
				play.

			anExpectedLastPosition := aScripter events reversed
					detectEventOfClass: BlDragEvent
					ifFound: [ :anEvent | anEvent position ]
					ifNone: [ NotFound signal: BlDragEvent in: aScripter events ].
					
			aStep assert
				label: 'Assert mouse position element in space';
				satisfies: [ :anElement | 
						| aCenter |
						aCenter := anElement bounds inSpace center.
						aCenter closeTo: anExpectedLastPosition precision: 0.0001 ]
					description: [ :anElement | 
						'Mouse position element is not in its expected position: {1} ~= {2}'
							format: {anElement bounds inSpace center.
									anExpectedLastPosition} ];
				// #'scenery--mouse-position';
				play ]
]

{ #category : #examples }
GtSceneryInScripterExamples >> scripter: aScripter dragNodeResizerFromItemId: aSceneryItemId by: aPoint [
	<gtExample>
	| anInitialNodeBounds anUpdatedNodeBounds anExpectedNodeBounds |
	aScripter
		substeps: ('Drag node {1} resizer by {2}'
				format: {aSceneryItemId.
						aPoint})
		do: [ :aStep | 
			aStep do
				label: 'Read current node bounds';
				block: [ :aNodeElement | anInitialNodeBounds := aNodeElement bounds inSpace ];
				// aSceneryItemId;
				play.

			aStep mouseMoveOver
				label: 'Move mouse over target element';
				// aSceneryItemId;
				play.
			aStep click
				label: 'Select node';
				// aSceneryItemId;
				play.

			aStep mouseMoveOver
				label: 'Move mouse over resizer handle element';
				// BlResizerElement;
				/ BlElement;
				play.
			aStep mouseDown
				label: 'Mouse down';
				play.
			aStep mouseMove
				label: ('Move mouse by {1}' format: {aPoint});
				by: aPoint;
				play.

			aStep do
				label: 'Read updated node bounds';
				block: [ :aNodeElement | anUpdatedNodeBounds := aNodeElement bounds inSpace ];
				// aSceneryItemId;
				play.

			anExpectedNodeBounds := anInitialNodeBounds topLeft
					corner: anInitialNodeBounds bottomRight + aPoint.
			aStep assert
				label: 'Assert resized node bounds';
				satisfies: [ anUpdatedNodeBounds asRectangle
							closeTo: anExpectedNodeBounds
							precision: 0.0001 ]
					description: [ 'Updated node bounds {1} ~= {2}'
							format: {anUpdatedNodeBounds.
									anExpectedNodeBounds} ];
				play ]
]

{ #category : #examples }
GtSceneryInScripterExamples >> scripter: aScripter sceneryZoomLevel: aZoom childrenTranslationFactor: aFactor [
	<gtExample>
	aScripter
		substeps: 'Set zoom level and translation factor'
		do: [ :aStep | 
			aStep do
				label: ('Set zoom level {1} and children translation factor {2}'
						format: {aZoom.
								aFactor});
				block: [ :anElement | 
					anElement
						zoomLevel: aZoom;
						childrenTranslationFactor: aFactor ];
				// BlCanvassableElement;
				play.

			aStep assert
				label: 'Assert zoom level value';
				value: [ :anElement | anElement zoomLevel ] equals: aZoom;
				// BlCanvassableElement;
				play.

			aStep assert
				label: 'Assert children translation factor';
				value: [ :anElement | anElement childrenTranslationFactor ] equals: aFactor;
				// BlCanvassableElement;
				play ]
]
