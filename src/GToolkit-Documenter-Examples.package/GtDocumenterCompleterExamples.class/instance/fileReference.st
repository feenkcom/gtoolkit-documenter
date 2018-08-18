completion
fileReference
	<gtExample>
	| dir |
	dir := FileSystem memory workingDirectory.
	#('a1' 'a2' 'a3') do: [ :each | dir / each writeStreamDo: [ :stream | stream nextPutAll: each ] ].
	#('aa' 'ab')
		do: [ :each | 
			| subdir |
			subdir := dir / each.
			subdir ensureCreateDirectory.
			1 to: 2 do: [ :i | 
				subdir / i printString
					writeStreamDo: [ :stream | 
						stream
							nextPutAll: each;
							nextPutAll: i printString ] ] ].
	^ dir