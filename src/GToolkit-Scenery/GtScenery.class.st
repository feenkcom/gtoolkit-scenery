Class {
	#name : #GtScenery,
	#superclass : #BrStencil,
	#instVars : [
		'sceneryItems'
	],
	#category : #'GToolkit-Scenery-Model'
}

{ #category : #accessing }
GtScenery >> addSceneryItem: anItem [ 
	sceneryItems add: anItem
]

{ #category : #accessing }
GtScenery >> create [
	| container |
	container := BlCanvassableElement new
			background: Color white;
			constraintsDo: [ :c | 
				c vertical matchParent.
				c horizontal matchParent ].
	sceneryItems do: [ :each | 
		container addChild: each asElement ].
	^ container
]

{ #category : #accessing }
GtScenery >> gtSceneryItemsFor: aView [ 
	<gtView>
	^ aView list 
		title: 'Items';
		items: [ sceneryItems ]
]

{ #category : #accessing }
GtScenery >> initialize [
	super initialize.
	sceneryItems := OrderedCollection new 
]
