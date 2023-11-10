Class {
	#name : #CNBClassHierarchyPrinterTest,
	#superclass : #TestCase,
	#instVars : [
		'printer'
	],
	#category : #'CNB-Core'
}

{ #category : #helpers }
CNBClassHierarchyPrinterTest >> actualClass [

	^ CNBClassHierarchyPrinter
]

{ #category : #expected }
CNBClassHierarchyPrinterTest >> expectedString [

	^ 'ProtoObject
	Object
--> CNBAbstractModel
			CNBAbstractViewModel
			CNBClassModel
			CNBConceptualModel
			CNBPackageModel
			CNBRootModel'
]

{ #category : #expected }
CNBClassHierarchyPrinterTest >> expectedStringForJava [

	^ 'Superclass
--> TheClass
		FirstSubclass
		SecondSubclass'
]

{ #category : #helpers }
CNBClassHierarchyPrinterTest >> javaClassWithHierarchy [

	| javaSuperClass javaClass javaSubclass1 javaSubclass2 |
	javaSuperClass := FamixJavaClass named: #Superclass.
	javaClass := FamixJavaClass named: #TheClass.
	javaSubclass1 := FamixJavaClass named: #FirstSubclass.
	javaSubclass2 := FamixJavaClass named: #SecondSubclass.

	FamixJavaInheritance new
		subclass: javaSubclass1;
		superclass: javaClass.
	FamixJavaInheritance new
		subclass: javaSubclass2;
		superclass: javaClass.
	FamixJavaInheritance new
		subclass: javaClass;
		superclass: javaSuperClass.

	^ javaClass
]

{ #category : #running }
CNBClassHierarchyPrinterTest >> testPrintForJavaClass [

	printer := self actualClass forFamixClass: self javaClassWithHierarchy.
	self
		assert: (printer printWithEmphasisOn: #Class) asString
		equals: self expectedStringForJava
]

{ #category : #running }
CNBClassHierarchyPrinterTest >> testPrintForPharoClass [

	printer := self actualClass forPharoClass: CNBAbstractModel.
	self assert: printer print equals: self expectedString
]
