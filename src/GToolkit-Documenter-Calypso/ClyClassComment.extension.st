Extension { #name : #ClyClassComment }

{ #category : #'*GToolkit-Documenter-Calypso' }
ClyClassComment >> handlesAnnouncement: anAnnouncement [

	^anAnnouncement affectsClass: self definingClass
]
