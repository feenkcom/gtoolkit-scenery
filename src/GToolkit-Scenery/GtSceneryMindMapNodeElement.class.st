"
I am an element for a mindmap item.
I support a `tab` shortcut to create new subitems.
"
Class {
	#name : #GtSceneryMindMapNodeElement,
	#superclass : #GtSceneryEditableTextLabel,
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
GtSceneryMindMapNodeElement >> idClass [
	"Not used for now. Maybe all nodes should have their own (indexed) ids."
	^ GtSceneryMindmapNodeId
]
