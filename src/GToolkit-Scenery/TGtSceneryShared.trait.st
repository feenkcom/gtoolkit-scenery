Trait {
	#name : #TGtSceneryShared,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #view }
TGtSceneryShared >> gtStoreOnFor: aView [
	<gtView>
	"^ aView textEditor
		title: 'Store on';
		priority: 50;
		styler: (BrRBTextStyler new
				isForWorkspace: true;
				yourself);
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ String streamContents: [ :s | self storeOn: s ] ];
		actionButtonIcon: BrGlamorousVectorIcons playinspect
			tooltip: 'Do it and go'
			action: [ :button | 
				button phlow
					spawnObject: (Smalltalk compiler evaluate: (String streamContents: [ :s | self storeOn: s ])) ];
		actionUpdateButton"
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
