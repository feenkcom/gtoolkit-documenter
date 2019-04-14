Trait {
	#name : #TDocumentLinkStyler,
	#category : #'GToolkit-Documenter-Model'
}

{ #category : #'private - styling' }
TDocumentLinkStyler >> styleLinkButtonInText: aBlRope [
	(aBlRope from: self start to: self stop) 
		attribute: (GtButtonAttribute new
			beAppend;
			stencil: (GtButtonStencilBuilder new
				label: self styledLinkButtonText;
				icon: BrGlamorousIcons inspect;
				action: [ :aButton | self styledLinkButtonActionFrom: aButton ] ))
]

{ #category : #'private - styling' }
TDocumentLinkStyler >> styledLinkButtonActionFrom: aButton [
	"Perform an action on mouse click"
	self explicitRequirement
]

{ #category : #'private - styling' }
TDocumentLinkStyler >> styledLinkButtonText [
	"Return a button link name"
	<return: #String>
	^ self explicitRequirement
]
