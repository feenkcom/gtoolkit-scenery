Extension { #name : #BrStencil }

{ #category : #'*GToolkit-Scenery' }
BrStencil >> asItem [
	^ GtSceneryItem new
		stencil: self;
		yourself
]

{ #category : #'*GToolkit-Scenery' }
BrStencil >> isSceneryStencil [
	^ false
]

{ #category : #'*GToolkit-Scenery' }
BrStencil >> isValidIn: aSceneryContext [
	"To be used by Scenery stencils, given a context which may be either the item or the connection for that stencil."

	^ true
]
