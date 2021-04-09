Class {
	#name : #CNBClassHierarchyPrinter,
	#superclass : #ClassHierarchyPrinter,
	#category : #CNBBuilder
}

{ #category : #'public API' }
CNBClassHierarchyPrinter >> print [
	"Answer a description containing the names and instance variable names 
	of all of the subclasses and superclasses of the class."
	
	theClass ifNotNil: [ 
		showSuperclasses 
			ifTrue: [ self printSuperclasses ].
			stream nextPutAll: '------->'.	
			self printSubclassesOf: theClass ].
	^ stream contents
]

{ #category : #printing }
CNBClassHierarchyPrinter >> printClass: aClass [
	"Print a single line in the printout."
	stream tab: index.
	stream nextPutAll: aClass name.
	
	stream cr
]

{ #category : #'public API' }
CNBClassHierarchyPrinter >> printFamixJava [
	"Answer a description containing the names and instance variable names 
	of all of the subclasses and superclasses of the class."
	
	theClass ifNotNil: [ 
		showSuperclasses 
			ifTrue: [ self printFamixJavaSuperclasses  ].
			stream nextPutAll: '------->'.	
			self printClass: theClass.
			self printFamixJavaSubclasses ].
	^ stream contents
]

{ #category : #printing }
CNBClassHierarchyPrinter >> printFamixJavaSubclasses [
	"As part of the algorithm for printing a description of the receiver, print the
	subclass on the file stream, aStream, indenting level times."

(theClass subclassHierarchy )
		do: [ :aClass | 
			self printClass: aClass.
			index := index + 1 ].
	stream cr.	"to spot the requested class."
]

{ #category : #printing }
CNBClassHierarchyPrinter >> printFamixJavaSubclassesOf: aClass [
	"As part of the algorithm for printing a description of the receiver, print the
	subclass on the file stream, aStream, indenting level times."

	| sortedSubclasses |
	limitedToClasses ifNotEmpty: [ 
			(limitedToClasses includes: aClass) 
				ifFalse: [ ^ self ]
			].
	(excludedClasses includes: aClass)
		ifTrue: [ ^ self ].
	self printClass: aClass.
	aClass == Class
		ifTrue: [ stream
				tab: index + 1;
				nextPutAll: '[ ... all the Metaclasses ... ]'.
			^ self ].
	sortedSubclasses := aClass subclassHierarchy
		asSortedCollection: [ :c1 :c2 | c1 name <= c2 name ].
	sortedSubclasses do: [ :subclass | 
			index := index + 1.
			self printFamixJavaSubclassesOf: subclass.
			index := index - 1 ]
]

{ #category : #printing }
CNBClassHierarchyPrinter >> printFamixJavaSuperclasses [


(theClass superclassHierarchy reject: #isInterface)
		reverseDo: [ :aClass | 
			self printClass: aClass.
			index := index + 1 ].
	stream cr.	"to spot the requested class."
]

{ #category : #printing }
CNBClassHierarchyPrinter >> printSubclassesOf: aClass [
	"As part of the algorithm for printing a description of the receiver, print the
	subclass on the file stream, aStream, indenting level times."

	| sortedSubclasses |
	limitedToClasses ifNotEmpty: [ 
			(limitedToClasses includes: aClass) 
				ifFalse: [ ^ self ]
			].
	(excludedClasses includes: aClass)
		ifTrue: [ ^ self ].
	self printClass: aClass.
	aClass == Class
		ifTrue: [ stream
				tab: index + 1;
				nextPutAll: '[ ... all the Metaclasses ... ]'.
			^ self ].
	sortedSubclasses := aClass subclasses
		asSortedCollection: [ :c1 :c2 | c1 name <= c2 name ].
	sortedSubclasses do: [ :subclass | 
			self printClass: subclass ]
		
"	(theClass superclassHierarchy reject: #isInterface)
		reverseDo: [ :aClass | 
			self printClass: aClass.
			index := index + 1 ].
	stream cr.	""to spot the requested class."""
]
