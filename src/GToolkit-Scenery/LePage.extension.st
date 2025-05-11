Extension { #name : #LePage }

{ #category : #'*GToolkit-Scenery' }
LePage >> sceneryInspectorStencil [
	^ GtSceneryLepiterPageStencil new
		pageName: self title;
		databaseName: self database databaseName;
		yourself
]
