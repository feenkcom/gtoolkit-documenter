Class {
	#name : #Gt2Epicea,
	#superclass : #Object,
	#traits : 'TBlDebug + TGt2DocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait',
	#instVars : [
		'ombuFile',
		'epiceaLog',
		'events'
	],
	#category : #'GToolkit-NewDocumenter-Epicea'
}

{ #category : #modification }
Gt2Epicea >> addEvent: anEpEvent [ 
	self ombuFile parent exists ifFalse: [ self ombuFile parent ensureCreateDirectory ].
	self 
		assert: [ self ombuFile parent exists ] 
		description: [ 'The parent directory of the Epicea change file must exist' ].
	self log addEntryWith: anEpEvent tags: [ :tags | "ignore" ].
	self log store flush.
	events addLast: anEpEvent.
]

{ #category : #accessing }
Gt2Epicea >> entries [
	<return: #OrderedeCollection of: #OmEntry>
	^ self log entries
]

{ #category : #accessing }
Gt2Epicea >> events [
	<return: #OrderedeCollection of: #EpEvent>
	^ events
]

{ #category : #'gt-extension' }
Gt2Epicea >> gtEventsFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Tutorial';
		priority: 0;
		stencil: [ 
			| aList |
			aList := BrColumnedList new display: self events.
			aList addEventHandler: GtInspectorListToSelectHandler new.
			aList constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
			"self announcer 
				when: EpEntryAdded 
				do: [ :anAnnouncement | aList display: theLog store entries ]."
			
			aList column 
				title: 'Icon';
				stencil: [ :anEpEvent :anIndex | 
					(anEpEvent accept: EpIconVisitor new) asElement ].
				
			aList column 
				title: 'Description';
				stencil: [ :anEpEvent :anIndex |
					| aRemoveButton aContainer | 
					aRemoveButton := BrButton new.
					aRemoveButton
						layout: BlLinearLayout new;
						look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
						icon: (BlElement new 
							geometry: BlRectangle new;
							layout: BlLinearLayout new;
							background: Color lightGray;
							size: 10@3);
						action: [ 
							self removeEvent: anEpEvent.
							aRemoveButton enqueueTask: (BlTaskAction new 
								action: [ aRemoveButton visibility: BlVisibility hidden ]) ];
						visibility: BlVisibility hidden.
					aContainer := BlElement new 
						layout: BlLinearLayout horizontal;
						addChildren: (anEpEvent accept: GtEpiceaBrickVisitor new);
						addChild: aRemoveButton;
						constraintsDo: [ :c | 
							c horizontal fitContent.
							c vertical fitContent ].
					aContainer when: BlMouseEnterEvent do: [ :anEvent | 
						aRemoveButton visibility: BlVisibility visible ].
					aContainer when: BlMouseLeaveEvent do: [ :anEvent | 
						aRemoveButton visibility: BlVisibility hidden ].
					aContainer ].
			aList ]
]

{ #category : #'gt-extension' }
Gt2Epicea >> gtGlobalEntriesIn: aView [
	<gtView>
	^ aView explicit 
		title: 'Global Changes';
		priority: 20;
		stencil: [ 
			| aList aGlobalLog |
			aGlobalLog := EpMonitor current log entries reversed.
			aList := BrColumnedList new display: aGlobalLog.
			aList addEventHandler: GtInspectorListToSelectHandler new.
			aList constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
			
			aList column 
				title: 'Icon';
				stencil: [ :anOmEntry :anIndex | 
					(anOmEntry content accept: EpIconVisitor new) asElement ].
				
			aList column 
				title: 'Description';
				stencil: [ :anOmEntry :anIndex |
					| anAddButton aContainer | 
					anAddButton := BrButton new.
					anAddButton
						layout: BlLinearLayout new;
						look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
						icon: GtInspectorPlusIconStencil new asElement;
						action: [ 
							self addEvent: anOmEntry content.
							anAddButton enqueueTask: (BlTaskAction new 
								action: [ anAddButton visibility: BlVisibility hidden ]) ];
						visibility: BlVisibility hidden.
					aContainer := BlElement new 
						layout: BlLinearLayout horizontal;
						addChildren: (anOmEntry content accept: GtEpiceaBrickVisitor new);
						addChild: anAddButton;
						constraintsDo: [ :c | 
							c horizontal fitContent.
							c vertical fitContent.
							c linear vertical alignCenter ].
					aContainer when: BlMouseEnterEvent do: [ :anEvent | 
						anAddButton visibility: BlVisibility visible ].
					aContainer when: BlMouseLeaveEvent do: [ :anEvent | 
						anAddButton visibility: BlVisibility hidden ].
					aContainer ].
			aList
			 ]
]

{ #category : #accessing }
Gt2Epicea >> log [
	<return: #EpLog>
	^ epiceaLog
]

{ #category : #accessing }
Gt2Epicea >> numberOfEvents [
	<return: #Integer>
	^ events ifNotNil: #size ifNil: 0
]

{ #category : #accessing }
Gt2Epicea >> ombuFile [
	<return: #FileReference>
	^ ombuFile
]

{ #category : #accessing }
Gt2Epicea >> ombuFile: aFileReference [
	ombuFile := aFileReference.
	epiceaLog := EpLog fromFile: "freshFromFile:" ombuFile.
	events := self entries collect: #content.
]

{ #category : #modification }
Gt2Epicea >> removeEvent: anEpEvent [
	| aNewEvents |
	aNewEvents := self events reject: [ :eachEvent | eachEvent = anEpEvent ].
	ombuFile ensureDelete.
	aNewEvents do: [ :eachEvent | self addEvent: eachEvent ].
	self log store flush.
	events := aNewEvents.
]
