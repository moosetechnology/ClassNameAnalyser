Extension { #name : #FAMIXPackage }

{ #category : #'*DMModels' }
FAMIXPackage >> classmodels [
	^self classes collect: [ :each | each classmodel ]
]

{ #category : #'*DMModels' }
FAMIXPackage >> conceptualClassModels [ 
	^DMClassModelGroup new addAll: (self classmodels)
]

{ #category : #'*DMModels' }
FAMIXPackage >> packagemodel [
	^DMPackageModel name: self name with: self conceptualClassModels  
]
