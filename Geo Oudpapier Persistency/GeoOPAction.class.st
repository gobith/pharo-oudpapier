Class {
	#name : #GeoOPAction,
	#superclass : #Object,
	#instVars : [
		'schedule',
		'actionTime',
		'substrings'
	],
	#category : #'Geo Oudpapier Persistency'
}

{ #category : #accessing }
GeoOPAction class >> fromHeaderString: headerString [
	^ (self subclasses detect: [ :each | each headerString = headerString ]) new
]

{ #category : #accessing }
GeoOPAction class >> fromString: aString schedule: aSchedule [
	| substrings action |
	substrings := aString substrings: ';'.
	action := self fromHeaderString: substrings second.
	action schedule: aSchedule.
	action substrings: substrings.
	^action
]

{ #category : #private }
GeoOPAction class >> headerString [

	^self subclassResponsibility 
]

{ #category : #accessing }
GeoOPAction >> actionTime [
	^ actionTime
]

{ #category : #accessing }
GeoOPAction >> actionTime: anObject [
	actionTime := anObject
]

{ #category : #persistence }
GeoOPAction >> addHeaderOn: ws [
	ws
		print: self actionTime asSeconds;
		nextPut: self separator;
		nextPutAll: self headerString;
		nextPut: self separator
]

{ #category : #actions }
GeoOPAction >> addToSchedule [

	actionTime := DateAndTime fromSeconds: (substrings at: 1) asInteger.

	schedule addAction: self
]

{ #category : #actions }
GeoOPAction >> doIt [

	self subclassResponsibility 
]

{ #category : #accessing }
GeoOPAction >> fileReference [

	^schedule fileReference
]

{ #category : #accessing }
GeoOPAction >> headerString [

	^self class headerString
]

{ #category : #actions }
GeoOPAction >> persist [
	actionTime := DateAndTime now.
	schedule addAction: self.
	schedule mutex
		critical: [ self fileReference
				writeStreamDo: [ :writeStream | 
					writeStream setToEnd.
					writeStream
						nextPutAll: self persistenceString;
						nextPut: self terminateCharacter ] ]
]

{ #category : #persistence }
GeoOPAction >> persistenceString [

	^self subclassResponsibility 
]

{ #category : #printing }
GeoOPAction >> prettyString [

	| ws |
	ws := WriteStream on: String new.
	
	self prettyStringOn: ws.
	
	^ws contents
]

{ #category : #printing }
GeoOPAction >> prettyStringOn: ws [
	ws
		nextPutAll: actionTime asDate yyyymmdd;
		tab.
	actionTime printHMSOn: ws.
	ws
		tab;
		nextPutAll: self headerString
]

{ #category : #accessing }
GeoOPAction >> schedule [
	^ schedule
]

{ #category : #accessing }
GeoOPAction >> schedule: anObject [
	schedule := anObject
]

{ #category : #accessing }
GeoOPAction >> separator [
	^ $;
]

{ #category : #accessing }
GeoOPAction >> substrings [
	^ substrings
]

{ #category : #accessing }
GeoOPAction >> substrings: anObject [
	substrings := anObject
]

{ #category : #accessing }
GeoOPAction >> terminateCharacter [

	^$%
]
