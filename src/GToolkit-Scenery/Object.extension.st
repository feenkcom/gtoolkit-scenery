Extension { #name : #Object }

{ #category : #'*GToolkit-Scenery' }
Object >> implementsStoreOn [
	"True if the object has its own implementation of #storeOn: rather than the default.
	Assumption: if there is a dedicated #storeOn: in the object's class
	(or one of its superclasses) we suppose that the object is reliably serializable,
	otherwise not."

	^ (self class
		classAndMethodFor: #storeOn:
		do: [ :c :m | m ]
		ifAbsent: [ ^ false ]) ~= (Object >> #storeOn:)
]

{ #category : #'*GToolkit-Scenery' }
Object >> sceneryInspectorStencil [
	"The default stencil for arbitrary objects."

	^ GtSceneryInspectorStencil new
		target: [ self ];
		yourself
]
