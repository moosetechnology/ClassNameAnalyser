"
I print the hierarchy of the class or FamixJavaClass.
"
Class {
	#name : #CNBClassHierarchyPrinter,
	#superclass : #ClassHierarchyPrinter,
	#instVars : [
		'text'
	],
	#category : #'CNB-Core'
}

{ #category : #shapes }
CNBClassHierarchyPrinter >> arrow [
	| arrow |
	arrow := '------->'. 
	^ arrow asText addAttribute: (TextEmphasis bold) from: 1 to:  arrow size
]

{ #category : #initialization }
CNBClassHierarchyPrinter >> initialize [ 
	super initialize.
	
	text := Text new.
]

{ #category : #'instance creation' }
CNBClassHierarchyPrinter >> newLine [ 

	^ String cr asText
]

{ #category : #'public API' }
CNBClassHierarchyPrinter >> print [
	"Answer a description containing the names and instance variable names 
	of all of the subclasses and superclasses of the class."
	
	theClass ifNotNil: [ 
		 	self printSuperclasses.
			self printTheClass.
			self printSubclasses ]
]

{ #category : #printing }
CNBClassHierarchyPrinter >> printClass: aClass [

	text ifNotEmpty: [ text append: self newLine ].
	(aClass = theClass) ifTrue: [	text append: self arrow	].
	text append: aClass name.
]

{ #category : #'public API' }
CNBClassHierarchyPrinter >> printFamixJava [
	"Answer a description containing the names and instance variable names 
	of all of the subclasses and superclasses of the class."
	
	theClass ifNotNil: [ 
		self printFamixJavaSuperclasses.
		self printTheClass.
		self printFamixJavaSubclasses ].
]

{ #category : #printing }
CNBClassHierarchyPrinter >> printFamixJavaSubclasses [
	"As part of the algorithm for printing a description of the receiver, print the
	subclass on the file stream, aStream, indenting level times."

	(theClass subInheritances collect: #source)
		do: [ :aClass | 
			self printClass: aClass ].
]

{ #category : #printing }
CNBClassHierarchyPrinter >> printFamixJavaSuperclasses [

	 self superclasses
		ifNotEmpty: [ 
			self superclasses 
				reverseDo: [ :aClass | self printClass: aClass ].
				 ].
		

		
	
]

{ #category : #printing }
CNBClassHierarchyPrinter >> printSubclasses [
	"As part of the algorithm for printing a description of the receiver, print the
	subclass on the file stream, aStream, indenting level times."

	| sortedSubclasses |

	sortedSubclasses := theClass subclasses
		asSortedCollection: [ :c1 :c2 | c1 name <= c2 name ].
	sortedSubclasses do: [ :subclass | 
			self printClass: subclass ]
]

{ #category : #printing }
CNBClassHierarchyPrinter >> printTheClass [ 

	self printClass: theClass.

]

{ #category : #printing }
CNBClassHierarchyPrinter >> printWithBoldJavaClass: aStringOrText [ 

	| ranges theRange textAsString |
	self printFamixJava.
	textAsString := text asString.
	ranges := textAsString allRangesOfSubstring: aStringOrText.
	theRange := ranges first.
	
    text 
       addAttribute: (TextEmphasis bold)
       from: theRange first
       to: theRange last.
	^ text
]

{ #category : #printing }
CNBClassHierarchyPrinter >> printWithBoldPharoClass: aStringOrText [ 

	| ranges theRange textAsString |
	self print.
	textAsString := text asString.
	ranges := textAsString allRangesOfSubstring: aStringOrText.
	theRange := ranges first.
	
    text 
       addAttribute: (TextEmphasis bold)
       from: theRange first
       to: theRange last.
	^ text
]

{ #category : #accessing }
CNBClassHierarchyPrinter >> superclassOf: aClass [

	^ aClass superClass
]

{ #category : #'as yet unclassified' }
CNBClassHierarchyPrinter >> superclasses [ 

	| superclass superclasses |
	superclass := self superclassOf: theClass. 
	superclasses := OrderedCollection new.
	
	[ superclass isNotNil ] 
		whileTrue: [ 
			superclasses add: superclass.
			superclass := self superclassOf: superclass.			
					].
	^ superclasses		
]
