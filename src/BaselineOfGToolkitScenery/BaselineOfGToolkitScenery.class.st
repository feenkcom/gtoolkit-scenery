Class {
	#name : #BaselineOfGToolkitScenery,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitScenery
}

{ #category : #baseline }
BaselineOfGToolkitScenery >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec package: 'GToolkit-Scenery'.
	]
]
