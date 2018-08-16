private-annotations
annotationTagActionsFor: tagString startAt: annotationStart
	| prefix |
	prefix := tagString first: position - annotationStart + 1.
	^ (annotationTags first: max startingWith: prefix)
		collect: [ :each | 
			self
				complete: each
				with: (each allButFirst: prefix size)
				deleting: tagString size - prefix size
				at: position ]