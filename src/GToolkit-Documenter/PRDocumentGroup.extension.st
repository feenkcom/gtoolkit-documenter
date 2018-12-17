Extension { #name : #PRDocumentGroup }

{ #category : #'*GToolkit-Documenter' }
PRDocumentGroup >> gtInspectorTree2RepresentationIn: composite [
	<gtInspectorPresentationOrder: 29>
	composite tree
		title: 'S-Tree';
		children: [ :item | 
					item hasChildren
						ifTrue: [ item children ] ];
		format: [ :item | (item class name allButFirst: 2) , '(' , ((PRPillarWriter write: item) printStringLimitedTo: 200) lines first , ')' ]
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentGroup >> gtTreeFor: aView [
	<gtView>
	^ aView explicit
			title: 'Tree';
			priority: 2;
			stencil: [ 
				| aList |
				aList := BrSimpleList new.
				aList
					display: (Array streamContents: [ :aStream | 
						self gtTreeListFor: self depth: 0 in: aStream ]);
					stencil: [ :aTwoSizeArray :anIndex | 
						| aText aDepth anItem |
						aDepth := aTwoSizeArray first.
						anItem := aTwoSizeArray second.
						aText := ((anItem class name allButFirst: 2) , '(' , 
							((PRPillarWriter write: anItem) printStringLimitedTo: 200) lines first , ')') 
								asRopedText readonly.
						BlElement new
							layout: BlLinearLayout horizontal;
							constraintsDo: [ :c | 
								c horizontal matchParent.
								c vertical fitContent.
								c padding: (BlInsets top: 1 bottom: 1) ];
							addChild: (BlElement new 
								constraintsDo: [ :c |
									c horizontal exact: aDepth * 10.
									c vertical fitContent ]);
							addChild: (BlTextElement new 
								text: aText;
								when: BlClickEvent do: [ :anEvent | 
									anEvent currentTarget fireEvent: (
										GtPhlowObjectToSelect new object: anItem; sourceElement: anEvent currentTarget)
									])
						 ]
				]
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentGroup >> gtTreeListFor: aDocumentGroup depth: anInteger in: aStream [
	aStream nextPut: { anInteger . aDocumentGroup }.
	aDocumentGroup hasChildren ifFalse: [ ^ self ].
	aDocumentGroup children do: [ :eachChild | 
		self gtTreeListFor: eachChild depth: anInteger + 1 in: aStream ]
]
