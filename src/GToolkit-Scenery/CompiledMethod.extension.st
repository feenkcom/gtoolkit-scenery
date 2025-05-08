Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Scenery' }
CompiledMethod >> sceneryInspectorStencil [
	"Specialize the stencil based on the kind of value returned."

	| stencilClass returnType |
	(self hasPragmaNamed: #gtSlide)
		ifTrue: [ stencilClass := GtScenerySlideStencil ]
		ifFalse: [ (self hasPragmaNamed: #gtExample)
				ifTrue: [ stencilClass := GtSceneryExampleStencil.
					self pragmas
						detect: [ :p | p selector = #return: ]
						ifFound: [ :p | 
							returnType := p arguments first.
							returnType = 'GtScenery'
								ifTrue: [ stencilClass := GtEmbeddedSceneryStencil ].
							returnType = 'BlScripter'
								ifTrue: [ stencilClass := GtSceneryScripterStencil ] ] ]
				ifFalse: [ ^ super sceneryInspectorStencil ] ].
	^ stencilClass new
		exampleMethodName: self;
		yourself
]
