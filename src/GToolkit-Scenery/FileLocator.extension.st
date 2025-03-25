Extension { #name : #FileLocator }

{ #category : #'*GToolkit-Scenery' }
FileLocator >> gtStoreOnFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Store on';
		priority: 70;
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
		actionUpdateButton
]

{ #category : #'*GToolkit-Scenery' }
FileLocator >> storeOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: Character space;
		nextPutAll: origin.
	path
		do: [ :item | 
			aStream
				nextPutAll: ' / ''';
				nextPutAll: item;
				nextPut: $' ]
]
