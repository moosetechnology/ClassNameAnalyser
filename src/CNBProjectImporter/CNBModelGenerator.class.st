"
I generate the FamixJavaModel from an MSE file or a pharo project
"
Class {
	#name : #CNBModelGenerator,
	#superclass : #Object,
	#category : #CNBProjectImporter
}

{ #category : #'as yet unclassified' }
CNBModelGenerator class >> importProject: aPath [ 
	| model |
	aPath asFileReference 
		readStreamDo: [ :stream | 
			model := FamixJavaModel importFromMSEStream: stream.
			model name: model rootFolder basenameWithoutExtension.
			 ].	
		^ model

	
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
		addFromPackagesMatching: [:p | p name beginsWith: aString];
		run.
		model name: aString.
		^ model

	
]
