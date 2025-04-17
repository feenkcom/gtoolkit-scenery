Extension { #name : #Array }

{ #category : #'*GToolkit-Scenery' }
Array >> asBrMenuItems [
	"Convenience method to generate simple nested menus from nested association lists
	mapping labels to blocks, or to further nested lists.
	{#foo -> [ #foo inspect ]. #bar -> [ #bar inspect ].
	 #foobar -> {#foobar -> [ #foobar inspect ]. #foobaz -> [ #foobaz inspect ]}} asBrMenuItems
	"

	| menuItems |
	menuItems := BrMenuItems new.
	self
		associationsDo: [ :each | 
			each isAssociation
				ifTrue: [ each value isBlock
						ifTrue: [ menuItems addItemLabel: each key asString action: each value ]
						ifFalse: [ each value isArray
								ifTrue: [ menuItems
										addItem: (BrMenuSubmenuItem new
												label: each key asString;
												submenu: each value asBrMenuItems) ] ] ] ].
	^ menuItems
]
