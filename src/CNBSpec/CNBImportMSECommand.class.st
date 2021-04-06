Class {
	#name : #CNBImportMSECommand,
	#superclass : #CmCommand,
	#category : #CNBSpec
}

{ #category : #initialization }
CNBImportMSECommand class >> defaultIconName [ 

	^ MooseIcons mooseImportMse 
]

{ #category : #default }
CNBImportMSECommand class >> defaultName [
	^ 'Open MSE'
]

{ #category : #accessing }
CNBImportMSECommand >> category [

	^ 'Import'
]

{ #category : #accessing }
CNBImportMSECommand >> execute [

	| importForm |
	importForm := MooseImportFromMSEForm new.
	importForm announcer
		when: MPNewModelInstalled
		do: [ :ann | self context model: ann newModel ].
	importForm openModalWithSpec
]

{ #category : #accessing }
CNBImportMSECommand >> icon [
	^ MooseIcons mooseImportMse
]

{ #category : #accessing }
CNBImportMSECommand >> label [
	^ 'Import model from MSE file'
]
