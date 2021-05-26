Class {
	#name : #CNBAnalysisDescriptionTest,
	#superclass : #TestCase,
	#instVars : [
		'cnD',
		'presenter'
	],
	#category : #'CNB-Core'
}

{ #category : #tests }
CNBAnalysisDescriptionTest >> addFromPackagesMatching: aBlock [

	| packages |
	packages := OrderedCollection new.
	RPackage organizer packages do: [:each |
		 (aBlock value: each) ifTrue: [packages add: each]].
	^ packages
]

{ #category : #running }
CNBAnalysisDescriptionTest >> setUp [
	super setUp.
	
	"Put here a common initialization logic for tests"
	presenter := CNBPresenter new.
	presenter packagesList selectItems: (RPackageOrganizer default packages select: [ :p | 'moose-*' match: p name ]).
	presenter onAddClicked.
	presenter onVisualizeClicked.
]

{ #category : #tests }
CNBAnalysisDescriptionTest >> testClasses [ 

	self 
		assert: presenter suffixCnb analysisDescription classes 
		
		equals: 
			((self addFromPackagesMatching: 
						[ :p | 'moose-*' match: p name ]) flatCollect: #definedClasses) size.
]

{ #category : #tests }
CNBAnalysisDescriptionTest >> testFatBlob [ 

	| fatBlobTokens |
	fatBlobTokens 
		:= presenter suffixCnb viewModel 
					tokenModels select: [ :each | 
						(each root isMultiToken and: [ 
							(each belongers size >= CNBFatBlobPattern fatBlobSize ) and: [ 
								each outsiders size <= CNBFatBlobPattern maxOutsiders ] ]) ].
		self 
			assert: presenter suffixCnb analysisDescription fatBlob 
			equals: fatBlobTokens size
]

{ #category : #tests }
CNBAnalysisDescriptionTest >> testMaxChildren [

	self
		assert: (Smalltalk image classNamed:
				 presenter suffixCnb analysisDescription maxChildrenRoot)
		equals: TestAsserter
]

{ #category : #tests }
CNBAnalysisDescriptionTest >> testPackages [ 

	self 
		assert: presenter suffixCnb analysisDescription packages
		equals: (presenter model allPackages reject: #isStub) size
]

{ #category : #tests }
CNBAnalysisDescriptionTest >> testScatteredVocabulary [

	
]
