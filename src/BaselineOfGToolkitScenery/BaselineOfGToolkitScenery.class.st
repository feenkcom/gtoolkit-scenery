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
	spec
		for: #common
		do: [ spec
				baseline: 'GToolkitPhlow'
				with: [ spec repository: 'github://feenkcom/gtoolkit-phlow:main/src' ].
			spec
				baseline: 'GToolkitLudoDemo'
				with: [ spec repository: 'github://feenkcom/gtoolkit-demos:main/src' ].
			spec
				baseline: 'GToolkitMemoryDemo'
				with: [ spec repository: 'github://feenkcom/gtoolkit-demos:main/src' ].
			spec
				baseline: 'GToolkitMoldableDevelopmentDemo'
				with: [ spec repository: 'github://feenkcom/gtoolkit-demos:main/src' ].
			spec
				baseline: 'GToolkitDemoReflection'
				with: [ spec repository: 'github://feenkcom/gtoolkit-demos:main/src' ].
			spec
				baseline: 'GToolkitDemoSlideshows'
				with: [ spec repository: 'github://feenkcom/gtoolkit-demos:main/src' ].
			spec
				baseline: 'GToolkitInspector'
				with: [ spec repository: 'github://feenkcom/gtoolkit-inspector:main/src' ].
			spec
				baseline: 'GToolkitVisualizer'
				with: [ spec repository: 'github://feenkcom/gtoolkit-visualizer:main/src' ].
			spec
				baseline: 'LepiterEngineCore'
				with: [ spec repository: 'github://feenkcom/gtoolkit-lepiter:main/src' ].
			spec
				package: 'GToolkit-Scenery'
				with: [ spec
						requires: #(GToolkitPhlow GToolkitLudoDemo GToolkitMemoryDemo GToolkitMoldableDevelopmentDemo GToolkitDemoReflection GToolkitDemoSlideshows GToolkitInspector GToolkitVisualizer LepiterEngineCore) ] ]
]
