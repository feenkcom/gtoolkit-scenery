Class {
	#name : #BaselineOfGToolkitScenery,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitScenery
}

{ #category : #loading }
BaselineOfGToolkitScenery class >> loadLepiterSceneryHelp [
	"Load this only if we need to edit the help pages."

	IceRepository registry
		detect: [ :aRepository | aRepository name = 'gtoolkit-scenery' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties
				addRegisteredDirectory: aRepository repositoryDirectory / 'scenery-help'.
			defaultDatabase reload ]
		ifNone: [ self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfGToolkitScenery >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'GToolkitPhlow' with: [
				spec repository: 'github://feenkcom/gtoolkit-phlow:v0.8.1896/src' ].

		spec package: 'GToolkit-Scenery' with: [
			spec requires: #(#GToolkitPhlow) ].
	]
]
