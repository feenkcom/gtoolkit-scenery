Extension { #name : #BrStencil }

{ #category : #'*GToolkit-Scenery' }
BrStencil >> asItem [
	^ GtSceneryItem new
		stencil: self;
		yourself
]
