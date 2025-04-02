Trait {
	#name : #TGtSceneryReporting,
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #view }
TGtSceneryReporting >> gtReportFor: aView [
	<gtView>
	self isValid ifTrue: [ ^ aView empty ].
	^ aView textEditor
		title: 'Report';
		priority: 30;
		text: [ self reportString ]
]

{ #category : #required }
TGtSceneryReporting >> isInvalid [
	^ self isValid not
]

{ #category : #required }
TGtSceneryReporting >> isValid [
	self explicitRequirement
]

{ #category : #validity }
TGtSceneryReporting >> reportOn: aStream [
	self isValid ifFalse: [ self stencil reportOn: aStream in: self ]
]

{ #category : #validity }
TGtSceneryReporting >> reportString [
	| stream |
	stream := '' writeStream.
	self reportOn: stream.
	^ stream contents
]

{ #category : #required }
TGtSceneryReporting >> stencil [
	self explicitRequirement
]
