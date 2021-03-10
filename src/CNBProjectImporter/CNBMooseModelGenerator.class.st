Class {
	#name : #CNBMooseModelGenerator,
	#superclass : #Object,
	#category : #CNBProjectImporter
}

{ #category : #'as yet unclassified' }
CNBMooseModelGenerator class >> importProject: aPath [ 

	^ aPath asFileReference 
		readStreamDo: [ :stream | MooseModel importFromMSEStream: stream ].

	
]

{ #category : #'as yet unclassified' }
CNBMooseModelGenerator class >> projectNameMatches: aString [ 
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
