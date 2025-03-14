"
I am an abstract superclass for stencils of scenery items and connections.

Subclasses should implement `storeOn:` and also `postCopy` so cloning will work correctly.
"
Class {
	#name : #GtSceneryItemStencil,
	#superclass : #BrStencil,
	#category : #'GToolkit-Scenery-Model'
}
