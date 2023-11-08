"
I print the hierarchy of the class or FamixJavaClass.
"
Class {
	#name : #CNBClassHierarchyPrinter,
	#superclass : #ClassHierarchyPrinter,
	#instVars : [
		'forPharo'
	],
	#category : #'CNB-Core'
}

{ #category : #'instance creation' }
CNBClassHierarchyPrinter class >> forFamixClass: aClass [

	^ self new
		  beForFamix;
		  forClass: aClass;
		  yourself
]

{ #category : #'instance creation' }
CNBClassHierarchyPrinter class >> forPharoClass: aClass [

	^ self new
		  beForPharo;
		  forClass: aClass;
		  yourself
]

{ #category : #printing }
CNBClassHierarchyPrinter >> arrow [

	^ '----> '
]

{ #category : #'public API' }
CNBClassHierarchyPrinter >> beForFamix [

	forPharo := false
]

{ #category : #'public API' }
CNBClassHierarchyPrinter >> beForPharo [

	forPharo := true
]

{ #category : #printing }
CNBClassHierarchyPrinter >> emphasisFor: aStringOrText in: aString [

	| text |
	text := aString asText.

	(aString allRangesOfSubstring: aStringOrText) do: [ :range |
		text
			addAttribute: TextEmphasis bold
			from: range first
			to: range last ].

	^ text
]

{ #category : #initialization }
CNBClassHierarchyPrinter >> initialize [

	super initialize.
	self beForFamix
]

{ #category : #testing }
CNBClassHierarchyPrinter >> isForPharo [
	"False when for a Famix class"

	^ forPharo
]

{ #category : #'public API' }
CNBClassHierarchyPrinter >> print [

	theClass ifNil: [ ^ '' ].

	self printSuperclasses.
	self printTheClass.
	self printSubclasses.

	^ stream contents
]

{ #category : #printing }
CNBClassHierarchyPrinter >> printClass: aClass [

	aClass = theClass
		ifTrue: [
			stream
				<< self arrow;
				tab: index - 2 ]
		ifFalse: [ stream tab: index ].

	stream << aClass name
]

{ #category : #printing }
CNBClassHierarchyPrinter >> printSubclasses [

	self subclasses do: [ :subclass |
		stream cr.
		self printClass: subclass ]
]

{ #category : #printing }
CNBClassHierarchyPrinter >> printSuperclasses [

	self superclasses reverseDo: [ :aClass |
		self printClass: aClass.
		stream cr.
		index := index + 1 ]
]

{ #category : #printing }
CNBClassHierarchyPrinter >> printTheClass [

	self printClass: theClass.
	index := index + 1
]

{ #category : #'public API' }
CNBClassHierarchyPrinter >> printWithEmphasisOn: aStringOrText [

	^ self emphasisFor: aStringOrText in: self print
]

{ #category : #printing }
CNBClassHierarchyPrinter >> subclasses [

	^ (self isForPharo
		   ifTrue: [ theClass subclasses ]
		   ifFalse: [ theClass subclassHierarchy ]) sort: #name ascending
]

{ #category : #printing }
CNBClassHierarchyPrinter >> superclasses [

	^ self isForPharo
		  ifTrue: [ theClass allSuperclasses ]
		  ifFalse: [ theClass superclassHierarchy ]
]
