preview
ensurePreviewElement: aBlock
	<return: #BlElement>
	^ aBlock 
		on: Error 
		do: [ :anException | 
			anException asDebuggableElement ]