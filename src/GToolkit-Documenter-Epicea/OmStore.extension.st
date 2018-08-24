Extension { #name : #OmStore }

{ #category : #'*GToolkit-Documenter-Epicea' }
OmStore >> gtInspectorEntriesIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite fastList 
		title: [ 'Entries' translated ];
		display: [ self entries ];
		when: [ (self class xdIsAbstract) not ];
		icon: [ :eachOmEntry | 
			eachOmEntry content accept: EpIconVisitor new ];
		format: [ :eachOmEntry | 
			EpMorphFactory default
				rowWithAll: (eachOmEntry content accept: EpMorphVisitor new) ];
		yourself
]

{ #category : #'*GToolkit-Documenter-Epicea' }
OmStore class >> xdIsAbstract [
	^ self name = #OmStore 
]
