Class {
	#name : #CNBExportCSVCommand,
	#superclass : #CmCommand,
	#category : #CNBSpec
}

{ #category : #initialization }
CNBExportCSVCommand class >> defaultIconName [ 

	^ MooseIcons mooseImportMse 
]

{ #category : #default }
CNBExportCSVCommand class >> defaultName [
	^ 'Export to CSV'
]

{ #category : #accessing }
CNBExportCSVCommand >> category [

	^ 'Import'
]

{ #category : #executing }
CNBExportCSVCommand >> execute [ 
	| openFileDialog |
	
	openFileDialog 
		:= FDOpenFileDialog new whenSelected: [ :selectedFile |	context exportTo: selectedFile ].
	
	openFileDialog openWithSpec  
]

{ #category : #accessing }
CNBExportCSVCommand >> icon [
	^ MooseIcons mooseImportMse
]

{ #category : #accessing }
CNBExportCSVCommand >> label [
	^ 'Import model from MSE file'
]
