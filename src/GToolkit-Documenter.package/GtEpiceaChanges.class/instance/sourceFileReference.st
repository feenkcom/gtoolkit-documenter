accessing
sourceFileReference
	<return: #FileReference>
	self 
		assert: [ sourceFileReference notNil ]
		description: [ 'Pillar source file has to be initialized first' ].	
	^ sourceFileReference