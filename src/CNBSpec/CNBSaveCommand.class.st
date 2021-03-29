Class {
	#name : #CNBSaveCommand,
	#superclass : #CNBCommand,
	#category : #CNBSpec
}

{ #category : #accessing }
CNBSaveCommand class >> defaultIconName [  
	^ #glamorousSave
]

{ #category : #accessing }
CNBSaveCommand class >> defaultName [ 
	^ 'Save'

]

{ #category : #executing }
CNBSaveCommand >> execute [ 
| modelDictionary saveFileDialog |
	
"	modelDictionary := { 
		'settings' -> context settings .
		'projectHistory' -> context projectHistory .
		'recommendations' -> context recommendations
	} asDictionary.
	
	saveFileDialog := FDSaveFileDialog new whenSelected: [ :selectedFile |
		selectedFile writeStreamDo: [ :writeStream |
			MooseModel put: modelDictionary onStream: writeStream  ] ].
		
	saveFileDialog openWithSpec.
	"
]
