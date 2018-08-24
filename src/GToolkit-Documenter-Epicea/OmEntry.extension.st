Extension { #name : #OmEntry }

{ #category : #'*GToolkit-Documenter-Epicea' }
OmEntry >> gtInspectorDiffEnvironmentIn: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite morph 
		title: [ 'Changes Environment' translated ];
		morph: [ | oldString newString diffMorph |
			oldString := self content accept: (
				GtEpiceaCurrentStateVisitor inEnvironment: 
					self class environment).
			newString := self content accept: EpNewStateVisitor new.
			diffMorph := DiffMorph from: oldString to: newString.
			oldString ifEmpty: [ diffMorph showOnlyDestination: true ].
			newString ifEmpty: [ diffMorph showOnlySource: true ].
			diffMorph ]
]

{ #category : #'*GToolkit-Documenter-Epicea' }
OmEntry >> gtInspectorDiffIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite morph 
		title: [ 'Changes' translated ];
		morph: [ | oldString newString diffMorph |
			oldString := self content accept: EpOldStateVisitor new.
			newString := self content accept: EpNewStateVisitor new.
			diffMorph := DiffMorph from: oldString to: newString.
			oldString ifEmpty: [ diffMorph showOnlyDestination: true ].
			newString ifEmpty: [ diffMorph showOnlySource: true ].
			diffMorph ]
]

{ #category : #'*GToolkit-Documenter-Epicea' }
OmEntry >> xdEquals: other [
	^ other species = self species and: [ 
		other content xdEquals: self content ]
]

{ #category : #'*GToolkit-Documenter-Epicea' }
OmEntry >> xdTimestamp [
	^ self tags at: #time ifAbsent: [ DateAndTime now ]
]
