Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Documenter' }
AbstractFileReference >> gtDocumentFor: aView [
	<gtView>
	| aDocument |
	(#('pier' 'pillar') includes: self extension) ifFalse: [ ^ 
aView empty ].
	self exists ifFalse: [ ^ aView empty ].

	aDocument := GtDocument forFile: self.
	^ (aDocument gtTextFor: aView)
		priority: 9;
		action: [ :anAction | 
			aDocument gtSaveActionFor: anAction ];
		action: [ :anAction | 
			aDocument gtShowMarkupActionFor: anAction ].
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
