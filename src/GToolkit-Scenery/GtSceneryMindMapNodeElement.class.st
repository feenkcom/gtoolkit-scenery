"
I am an element for a mindmap item.
I support a `tab` shortcut to create new subitems.
"
Class {
	#name : #GtSceneryMindMapNodeElement,
	#superclass : #BrEditableLabel,
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #initalization }
GtSceneryMindMapNodeElement >> defaultLabelShortcuts [
	^ {BrEditorShortcut new
			name: 'Add subnode';
			description: 'Add a subnode.';
			combination: BlKeyCombination tab;
			performBlock: [ self
					fireEvent: (GtSceneryAddNewConnection new
							fromItemElement: self;
							toStencil: GtSceneryMindMapNodeStencil new;
							yourself) ];
			yourself} , super defaultLabelShortcuts
]

{ #category : #initalization }
GtSceneryMindMapNodeElement >> initialize [
	| resizer |
	super initialize.
	self
		aptitude: BrGlamorousEditableLabelAptitude new glamorousRegularFontAndSize;
		id: GtSceneryMindmapNodeId.
	resizer := BlResizerElement new preventMouseEvents zIndex: 100.
	self
		when: BlFocusOutEvent
			do: [ :e | 
				resizer
					detach;
					removeFromParent ];
		when: BlFocusInEvent
			do: [ :e | 
				resizer
					detach;
					removeFromParent.
				self parent addChild: resizer.
				resizer attachTo: self.
				self
					when: BlResizerResizedEvent
					do: [ :evt | 
						self width: evt extent x.
						self
							hExact: self width;
							vFitContent ] ]
]
