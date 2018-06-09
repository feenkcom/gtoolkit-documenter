private
unsubscribeFromDocument: aGtDocument 
	self 
		assert: [ aGtDocument notNil ] 
		description: [ 'Document has to be initialized' ].
	aGtDocument systemChangesHandler unsubscribe: self.