*GToolkit-Documenter
gtInspectorSubscriptionsMultiIn: composite
	<gtInspectorPresentationOrder: 29>
	composite table
		title: 'M-Subscriptions';
		display: [ self subscriptions glmSubscriptions ];
		when: [ self numberOfSubscriptions isZero not ];
		beMultiple;
		column: 'Subscriber' evaluated: [ :each | each subscriber asString ];
		column: 'Announcement' evaluated: [ :each | each announcementClass printString ];
		column: 'Kind' evaluated: [ :each | each class name ];
		act: [ :table | 
			self subscriptions reset.
			table update ] icon: GLMUIThemeExtraIcons glamorousCancel entitled: 'Reset';
		selectionAct: [ :table | 
			table selection do: [ :eachSelection | 
				self subscriptions remove: eachSelection ].
			table update ] entitled: 'Remove subscription'