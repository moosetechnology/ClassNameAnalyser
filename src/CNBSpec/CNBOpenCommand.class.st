Class {
	#name : #CNBOpenCommand,
	#superclass : #CNBCommand,
	#category : #CNBSpec
}

{ #category : #accessing }
CNBOpenCommand class >> defaultIconName [ 

	^ #glamorousOpen

]

{ #category : #accessing }
CNBOpenCommand class >> defaultName [

	^ 'Open'
]

{ #category : #executing }
CNBOpenCommand >> execute [ 
	| openFileDialog modelDictionary |
	
	openFileDialog := FDOpenFileDialog new whenSelected: [ :selectedFile |
		modelDictionary := selectedFile readStreamDo: [ :readStream |
			MooseModel importFromMSEStream: readStream ].

		"context
			loadWithSettings: (modelDictionary at: 'settings')
			projectHistory: (modelDictionary at: 'projectHistory')
			recommendations: (modelDictionary at: 'recommendations') "
			].
	
	openFileDialog openWithSpec  
]
