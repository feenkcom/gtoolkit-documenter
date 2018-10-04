Extension { #name : #GtExample }

{ #category : #'*GToolkit-Documenter' }
GtExample >> gtInspectorBlocCodeGraphIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite blocMondrian
		title: '_Code graph';
		painting: [ :view :x :presentation |
			view nodes 
				shape: [ :each | 
					| text styler editor editorElement |
					text := each method sourceCode asRopedText.
					styler := GtExamplesStyler new classOrMetaClass: each methodClass.
					editor := BrTextEditor new.
					editor styler: styler.
					editor text: text.
					editorElement := BrEditorElement new.
					editorElement constraintsDo: [ :c |
					    c horizontal matchParent.
					    c vertical matchParent ].
					editorElement editor: editor.
					editorElement
						addEventHandlerOn: BlClickEvent do: [ :anEvent | presentation selection: each ].
					editorElement ];
				with: (self withDeepCollect: #directDependencies) asSet.
			view edges 
				fromRightCenter; toLeftCenter;
				connectToAll: #directDependencies.
			view layout horizontalDominanceTree layered horizontalGap: 100 ]
]

{ #category : #'*GToolkit-Documenter' }
GtExample >> gtInspectorBlocGraphIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite blocMondrian
		title: '_Graph';
		painting: [ :view :x :presentation |
			view nodes 
				shape: [ :each | 
					BlElement new 
						geometry: BlEllipse new; 
						border: (BlBorder paint: Color black width: 1);	
						background: (each = self
							ifTrue: [ Color gray ]
							ifFalse: [ Color white ]);
						size: 10@10;
						addEventHandlerOn: BlClickEvent do: [ :anEvent | presentation selection: each ] ];
				with: (self withDeepCollect: #directDependencies) asSet.
			view edges 
				fromCenterBottom; toCenterTop;
				connectToAll: #directDependencies.
			view layout tree ]
]

{ #category : #'*GToolkit-Documenter' }
GtExample >> gtInspectorBlocSourceIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite bloc
		title: '_Source';
		element: [ 
			| text styler editor editorElement |
			text := self method sourceCode asRopedText.
			text attributes: { BrFontGenericFamilyAttribute monospace beNotOverwritableByStyler}.
			styler := GtExamplesStyler new classOrMetaClass: self methodClass.
			editor := BrTextEditor new.
			editor styler: styler.
			editor text: text.
			editorElement := BrEditorElement new.
			editorElement constraintsDo: [ :c |
			    c horizontal matchParent.
			    c vertical matchParent ].
			editorElement editor: editor ]
]
