Extension { #name : #OmStore }

{ #category : #'*GToolkit-Documenter-Epicea' }
OmStore >> gtEntriesFor: aView [
	<gtView>
	self class xdIsAbstract ifTrue: [ ^ aView empty ].
	^ aView explicit 
		title: 'Entries';
		stencil: [ 
			| list |
			list := BrColumnedList new display: self entries.
			list addEventHandler: GtInspectorListToSelectHandler new.
			list constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
			
			list column 
				title: 'Icon';
				stencil: [ :anOmEntry :anIndex | 
					(anOmEntry content accept: EpIconVisitor new) asElement ].
				
			list column 
				title: 'Description';
				stencil: [ :anOmEntry :anIndex |
					BlTextElement new text: anOmEntry printString asRopedText ].
			list
			 ]
]

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
