Extension { #name : 'PRDocumentGroup' }

{ #category : '*GToolkit-Documenter' }
PRDocumentGroup >> gtChildren [
	^ self children
]

{ #category : '*GToolkit-Documenter' }
PRDocumentGroup >> gtChildrenFor: aView [
	<gtView>
	self children ifNil: [ ^ aView empty ].
	self hasChildren ifFalse: [ ^ aView empty ].
	^ aView tree
		title: 'Structure';
		items: [ { self } ];
		children: [ :aNode | aNode gtChildren ];
		expandUpTo: 3
]
