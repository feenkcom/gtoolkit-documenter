Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Documenter-Exporter' }
AbstractFileReference >> gtInspectorGtDocumenterParse [
	<gtInspectorAction>
	^ GLMGenericAction new
		action:  [ :presentation | self showParsedDocumentIn: presentation ];
		condition: [ self exists and: [ self extension = 'pillar' ] ];
		iconName: #glamorousDiveRight;
		title: 'Parse using GToolkit Documenter' translated;
		yourself
]

{ #category : #'*GToolkit-Documenter-Exporter' }
AbstractFileReference >> showParsedDocumentIn: aGLMCompositePresentation [ 
	aGLMCompositePresentation selection: self parseWithGtDocumenter 
]
