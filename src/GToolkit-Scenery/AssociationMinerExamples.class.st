Class {
	#name : #AssociationMinerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Scenery-Examples'
}

{ #category : #examples }
AssociationMinerExamples >> ludoGameIteration1 [
	<gtExample>
	| miner |
	miner := AssociationMiner forPackage: GtLudoGame package.
	
	self assert: miner iterations size equals: 1.
	self assert: miner iterations last observations size equals: 0.
	self assert: miner exampleClasses size equals: 4.
	self assert: miner packageClasses size equals: 21.
	self assert: miner seeds size equals: 41.
	self assert: miner scenery items size equals: 6.
	self assert: miner scenery connections size equals: 4.

	^ miner
]

{ #category : #examples }
AssociationMinerExamples >> ludoGameIteration2 [
	"A bit slow, so noTest"

	<gtExample>
	<noTest>
	| miner |
	miner := self ludoGameIteration1.
	miner iterate.

	self assert: miner iterations size equals: 2.
	self assert: miner iterations last observations size equals: 38.
	self assert: miner scenery items size equals: 12.
	self assert: miner scenery connections size equals: 17.

	^ miner
]
