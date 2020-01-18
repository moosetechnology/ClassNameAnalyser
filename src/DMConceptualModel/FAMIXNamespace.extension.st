Extension { #name : #FAMIXNamespace }

{ #category : #'*DMConceptualModel' }
FAMIXNamespace >> classmodels [
	^self classes collect: [ :each | each classmodel ]
]

{ #category : #'*DMConceptualModel' }
FAMIXNamespace >> conceptualClassModels [ 
	^DMClassModelGroup new addAll: (self classmodels)
]

{ #category : #'*DMConceptualModel' }
FAMIXNamespace >> packagemodel [
	^DMPackageModel name: self name with: self conceptualClassModels  
]
