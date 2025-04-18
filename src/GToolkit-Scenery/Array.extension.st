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

{ #category : #'*GToolkit-Scenery' }
Array >> asBrMenuItemsStoreString [
	"Temporary hack to rewrite the association lists as straight code.
	To be removed ..."

	| stream |
	stream := '' writeStream.
	self asBrMenuItemsStoreStringOn: stream.
	^ stream contents
]

{ #category : #'*GToolkit-Scenery' }
Array >> asBrMenuItemsStoreStringOn: aStream [
	"Temporary hack to rewrite the association lists as straight code.
	To be removed ..."

	aStream
		nextPutAll: 'BrMenuItems new';
		cr.
	self
		associationsDo: [ :each | 
			each isAssociation
				ifTrue: [ each value isBlock
						ifTrue: [ aStream
								nextPutAll: 'addItemLabel: ';
								nextPutAll: each key printString;
								nextPutAll: ' action: ';
								nextPutAll: each value printString;
								nextPutAll: ';';
								cr ]
						ifFalse: [ each value isArray
								ifTrue: [ aStream
										nextPutAll: 'addItemLabel: ';
										nextPutAll: each key printString;
										cr;
										nextPutAll: ' submenu: (';
										cr.
									each value asBrMenuItemsStoreStringOn: aStream.
									aStream
										nextPutAll: ');';
										cr ] ] ] ].
							
	aStream
		nextPutAll: 'yourself';
		cr.
]
