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
			baseline: 'GToolkitLudoDemo' with: [
				spec repository: 'github://feenkcom/gtoolkit-demos:v0.9.95/src' ].
		spec
			baseline: 'GToolkitMemoryDemo' with: [
				spec repository: 'github://feenkcom/gtoolkit-demos:v0.9.95/src' ].
		spec
			baseline: 'GToolkitMoldableDevelopmentDemo' with: [
				spec repository: 'github://feenkcom/gtoolkit-demos:v0.9.95/src' ].
		spec
			baseline: 'GToolkitDemoReflection' with: [
				spec repository: 'github://feenkcom/gtoolkit-demos:v0.9.95/src' ].
		spec
			baseline: 'GToolkitDemoSlideshows' with: [
				spec repository: 'github://feenkcom/gtoolkit-demos:v0.9.95/src' ].

		spec package: 'GToolkit-Scenery' with: [
			spec requires: #(#GToolkitLudoDemo #GToolkitMemoryDemo #GToolkitMoldableDevelopmentDemo #GToolkitDemoReflection #GToolkitDemoSlideshows) ].
	]
]
