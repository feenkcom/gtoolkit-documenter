Trait {
	#name : #TStylingModesWorkInProgress,
	#category : #'GToolkit-NewDocumenter-Utility'
}

{ #category : #'api - style' }
TStylingModesWorkInProgress >> styleTextEditingMode: aBlRope [
	self styleText: aBlRope
]

{ #category : #'api - style' }
TStylingModesWorkInProgress >> styleTextReadingMode: aBlRope [
	self styleTextEditingMode: aBlRope
]
