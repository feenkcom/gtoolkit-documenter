private
filenamesStartingWith: aString
	| fileReference segments currentDirectory filenamePart names |
	currentDirectory := self directory.
	fileReference := aString asFileReference.
	segments := fileReference pathSegments.
	1 to: segments size - 1 do: [ :i | currentDirectory := currentDirectory / (segments at: i) ].
	(segments notEmpty and: [ aString last = FileSystem disk delimiter ])
		ifTrue: [ currentDirectory := currentDirectory / segments last.
			filenamePart := '' ]
		ifFalse: [ filenamePart := segments isEmpty
				ifTrue: [ '' ]
				ifFalse: [ segments last ] ].
	(currentDirectory exists and: [ currentDirectory isDirectory ])
		ifFalse: [ ^ #() ].
	names := GtPrefixTree
		withAll:
			(currentDirectory children
				collect: [ :each | 
					each basename
						,
							(each isDirectory
								ifTrue: [ '/' ]
								ifFalse: [ '' ]) ]).
	^ (names first: max startingWith: filenamePart)
		collect: [ :each | 
			self
				complete: each
				with: (each allButFirst: filenamePart size)
				deleting: 0
				at: position ]