private
methodsStartingWith: aString
	^ self methodsStartingWith: aString classes: self allClasses methods: [ :class | self methodsIn: class ]