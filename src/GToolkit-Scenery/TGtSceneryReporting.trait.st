"
I am a trait for GtScenery items and connections that need to keep track of and report their “validity”.

For example a UML item is only valid if a class with that name exists, and an inheritance  connection is only valid if the connected classes are actually in an inheritance relation.

Validity checks are delegated to stencils, by sending `#isValidIn:` a context, which is true  by default.
Stencil subclasses can override `BrStencil>>#isValidIn:`

"
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
