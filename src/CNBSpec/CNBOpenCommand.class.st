Class {
	#name : #CNBOpenCommand,
	#superclass : #CNBCommand,
	#category : #CNBSpec
}

"{ #category : #default }
CNBOpenCommand class >> defaultDescription [
	^ ''
]

{ #category : #default }
CNBOpenCommand class >> defaultIconName [
	^ #glamorousOpen
]

{ #category : #default }
CNBOpenCommand class >> defaultName [
	^ 'Open'
]

{ #category : #executing }
CNBOpenCommand >> execute [
	| openFileDialog modelDictionary |

	openFileDialog := FDOpenFileDialog new whenSelected: [ :selectedFile |
			modelDictionary := selectedFile readStreamDo: [ :readStream |
				MooseModel importFromMSEStream: readStream ] ].
	openFileDialog openWithSpec

		context
			loadWithSettings: (modelDictionary at: 'settings')
			projectHistory: (modelDictionary at: 'projectHistory')
			recommendations: (modelDictionary at: 'recommendations') ].

	openFileDialog openWithSpec
]
"
