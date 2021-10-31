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
		stencil: [ (GtDocumenter forFile: self asFileReference) withDefaultToolbar ];
		actionButtonIcon: BrGlamorousVectorIcons accept 
			tooltip: 'Save document' 
			action: [ :aToggle :aTab | aTab viewContentElement save ];
		actionToggleIcon: BrGlamorousIcons edit 
			tooltip: 'Show/Hide Markups'
			activated: [ :aToggle :aTab | aTab viewContentElement showMarkup ] 
			deactivated: [ :aToggle :aTab | aTab viewContentElement hideMarkup ];
		actionButtonIcon: BrGlamorousVectorIcons remove
			tooltip: 'Decrease font size'
			action: [ :aToggle :aTab | aTab viewContentElement decreaseNormalFontSize ];
		actionButtonIcon: BrGlamorousVectorIcons add
			tooltip: 'Increase font size'
			action: [ :aToggle :aTab | aTab viewContentElement increaseNormalFontSize ]
]

{ #category : #'*GToolkit-Documenter' }
AbstractFileReference >> gtEventsFor: aView [
	<gtView>
	(self isFile and: [ self extension asLowercase = 'ombu' ])
		ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Change List';
		priority: 10;
		object: [ GtEpicea new
				ombuFile: self;
				yourself ];
		view: #gtEventsFor:
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
