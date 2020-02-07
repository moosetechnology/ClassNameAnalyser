Extension { #name : #FAMIXNamespace }

{ #category : #'*DMModels' }
FAMIXNamespace >> classmodels [
	^self classes collect: [ :each | each classmodel ]
]

{ #category : #'*DMModels' }
FAMIXNamespace >> conceptualClassModels [ 
	^DMClassModelGroup new addAll: (self classmodels)
]

{ #category : #'*DMModels' }
FAMIXNamespace >> packagemodel [

	^DMPackageModel new
	name: self name;
	classmodels: self conceptualClassModels  
]
