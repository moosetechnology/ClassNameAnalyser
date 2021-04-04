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
	| openFileDialog mseFile |
	
	openFileDialog := FDOpenFileDialog new whenSelected: [ :selectedFile |
		mseFile := selectedFile readStreamDo: [ :readStream |
			FamixJavaModel importFromMSEStream: readStream ].
		
			context model: mseFile
			].
	
	openFileDialog openWithSpec  
]
