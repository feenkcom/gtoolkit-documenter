Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Documenter' }
AbstractFileReference >> gtDocumentFor: aView [
	<gtView>
	(#('pier' 'pillar') includes: self extension) ifFalse: [ ^ 
aView empty ].
	self exists ifFalse: [ ^ aView empty ].

	^ aView explicit
		title: 'Document';
		priority: 1;
		disableAsync;
		stencil: [ GtDocumenter forClass: self ];
		actionButtonIcon: BrGlamorousVectorIcons accept 
			tooltip: 'Save document' 
			action: [ :aToggle :aTab | aTab viewContentElement save ];
		actionToggleIcon: BrGlamorousIcons edit 
			tooltip: 'Show/Hide Markups'
			activated: [ :aToggle :aTab | aTab viewContentElement showMarkup ] 
			deactivated: [ :aToggle :aTab | aTab viewContentElement hideMarkup ]
]

{ #category : #'*GToolkit-Documenter' }
AbstractFileReference >> parseWithGt2Documenter [
	| encoding |
	encoding := [ self binaryReadStreamDo: [ :in | (ZnCharacterEncoder detectEncoding: in upToEnd) identifier ] ]
		on: ZnCharacterEncodingError
		do: [ nil ].
	^ self binaryReadStreamDo: [ :in | 
		PRPillarParser new optimize parse: (ZnCharacterReadStream on: in encoding: encoding) upToEnd ]
]
