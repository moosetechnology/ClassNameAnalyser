Class {
	#name : #CNBModelGenerator,
	#superclass : #Object,
	#category : #CNBProjectImporter
}

{ #category : #'as yet unclassified' }
CNBModelGenerator class >> importProject: aPath [ 

	^ aPath asFileReference 
		readStreamDo: [ :stream | FamixJavaModel importFromMSEStream: stream ].

	
]

{ #category : #'as yet unclassified' }
CNBModelGenerator class >> packagesNamed: aCollection [
	| model  |

	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		doNotRunCandidateOperator;
		importingContext:
			(MooseImportingContext new
			   mergeClassAndMetaclass;
				importClass;
				importInheritance ; 
				importPackage;
				yourself);
		model: model;
		addFromPackagesNamed: aCollection;
		run.
		^ model

	
]

{ #category : #'as yet unclassified' }
CNBModelGenerator class >> projectNameMatches: aString [ 
	| model  |

	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		doNotRunCandidateOperator;
		importingContext:
			(MooseImportingContext new
			   mergeClassAndMetaclass;
				importClass;
				importInheritance ; 
				importPackage;
				yourself);
		model: model;
		addFromPackagesMatching: [:p | aString match: p name];
		run.
		^ model

	
]
