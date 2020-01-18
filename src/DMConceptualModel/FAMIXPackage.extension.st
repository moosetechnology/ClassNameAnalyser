Extension { #name : #FAMIXPackage }

{ #category : #'*DMConceptualModel' }
FAMIXPackage >> classmodels [
	^self classes collect: [ :each | each classmodel ]
]

{ #category : #'*DMConceptualModel' }
FAMIXPackage >> conceptualClassModels [ 
	^DMClassModelGroup new addAll: (self classmodels)
]

{ #category : #'*DMConceptualModel' }
FAMIXPackage >> packagemodel [
	^DMPackageModel name: self name with: self conceptualClassModels  
]
