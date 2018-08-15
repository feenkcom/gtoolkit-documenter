private
exampleMethodsStartingWith: aString
	^ self methodsStartingWith: aString classes: self exampleClasses methods: [ :class | self exampleMethodsIn: class ]