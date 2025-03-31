Trait {
	#name : #TGtSceneryShared,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #view }
TGtSceneryShared >> gtStoreOnFor: aView [
	<gtView>
	^ aView explicit
		title: 'Store on';
		priority: 120;
		stencil: [ (GtPharoSnippetCoder new
				forSource: self storeString;
				format;
				subscribeToSystem;
				asExpandedOnlyElement) vFitContentLimited ];
		actionButtonIcon: BrGlamorousVectorIcons playinspect
			tooltip: 'Do it and go'
			action: [ :button | 
				button phlow
					spawnObject: (Smalltalk compiler evaluate: (String streamContents: [ :s | self storeOn: s ])) ];
		actionUpdateButton
]
