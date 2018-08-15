accessing
allClasses
	^ allClasses ifNil: [ allClasses := GtPrefixTree withAll: (ProtoObject withAllSubclasses collect: [ :each | each name ]) ]