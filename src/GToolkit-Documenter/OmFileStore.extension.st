Extension { #name : #OmFileStore }

{ #category : #'*GToolkit-Documenter' }
OmFileStore >> gtReset [
	self
		ensureDeleteFile;
		refresh
]
