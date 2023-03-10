Class {
	#name : #BaselineOfGToolkitScenery,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitScenery
}

{ #category : #baseline }
BaselineOfGToolkitScenery >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec
				baseline: 'GToolkitPhlow'
				with: [ spec repository: 'github://feenkcom/gtoolkit-phlow:main/src' ].
			spec 
				package: 'GToolkit-Scenery' 
				with: [ spec requires: #(GToolkitPhlow) ] ]
]
