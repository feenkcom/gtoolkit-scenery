"
I am a class for storing Sceneries with a storeStringMethod defined.

Any Scenery can have a storeStringMethod, which identifies a gtExemple method of an arbitrary class.
If defined, the scenery will offer a “save” action to override that method with the current storeString as a `<noTest>` gtExample method that can be replayed.

NB: For larger sceneries, we should probably use JSON instead to expert sceneries as files.
"
Class {
	#name : #GtSceneryStoreStringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #'as yet unclassified' }
GtSceneryStoreStringExamples >> classScripterDemo [
	<gtExample>
	<noTest>
	| scenery item1 item2 |
	scenery := GtScenery new.
	item1 := scenery
			addItem: (GtSceneryMindMapNodeStencil new width: 102.93202209472656) asItem.
	item1 position: 182.67466227213458 @ 159.2318572998047.
	item1 extent: 102.93202209472656 @ 28.0.
	item2 := scenery
			addItem: (GtSceneryMindMapNodeStencil new width: 102.93202209472656) asItem.
	item2 position: 493.4436035156241 @ 156.06937154134118.
	item2 extent: 102.93202209472656 @ 28.0.
	scenery.
	^ scenery
]
