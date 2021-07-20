Class {
	#name : #GeoOPActionUpdateUserPartTimeStatus,
	#superclass : #GeoOPAction,
	#instVars : [
		'user',
		'id',
		'collectionPartTime',
		'status'
	],
	#category : #'Geo Oudpapier Persistency'
}

{ #category : #private }
GeoOPActionUpdateUserPartTimeStatus class >> headerString [

	^'UpdateUserPartTimeStatus'
]

{ #category : #accessing }
GeoOPActionUpdateUserPartTimeStatus >> collectionPartTime [
	^ collectionPartTime
]

{ #category : #accessing }
GeoOPActionUpdateUserPartTimeStatus >> collectionPartTime: anObject [
	collectionPartTime := anObject
]

{ #category : #actions }
GeoOPActionUpdateUserPartTimeStatus >> doIt [

	collectionPartTime status = status ifTrue: [ ^self ].
	
	collectionPartTime status: status.
	
	self persist
]

{ #category : #actions }
GeoOPActionUpdateUserPartTimeStatus >> fileIn [
	| schedulePartTime |
	id := (substrings at: 3) asInteger.
	user := schedule userAt: id.	
	status := GeoOPUserStatus fromSymbol: (substrings at: 5) asSymbol.
	schedulePartTime := schedule
		collectionPartTimes at: (DateAndTime fromSeconds: (substrings at: 4) asInteger).
	collectionPartTime := user collectionPartTimeAt: schedulePartTime.
	collectionPartTime status: status.
	self addToSchedule
]

{ #category : #accessing }
GeoOPActionUpdateUserPartTimeStatus >> id [
	^ id
]

{ #category : #accessing }
GeoOPActionUpdateUserPartTimeStatus >> id: anObject [
	id := anObject
]

{ #category : #persistence }
GeoOPActionUpdateUserPartTimeStatus >> persistenceString [
	| ws |
	ws := WriteStream on: String new.
	self addHeaderOn: ws.
	ws
		print: user id;
		nextPut: self separator;
		nextPutAll: collectionPartTime dateAndtimeString;
		nextPut: self separator;
		nextPutAll: status statusSymbol.
	^ ws contents
]

{ #category : #printing }
GeoOPActionUpdateUserPartTimeStatus >> prettyStringOn: ws [
	super prettyStringOn: ws.
	ws
		tab;
		nextPutAll: user name;
		tab;
		print: collectionPartTime date;
		tab;
		nextPutAll: collectionPartTime partTimeString;
		tab;
		nextPutAll: (status ifNil: [ 'Obsolete status' ] ifNotNil: [ status userStatusString ])
]

{ #category : #accessing }
GeoOPActionUpdateUserPartTimeStatus >> status [
	^ status
]

{ #category : #accessing }
GeoOPActionUpdateUserPartTimeStatus >> status: anObject [
	status := anObject
]

{ #category : #accessing }
GeoOPActionUpdateUserPartTimeStatus >> user [
	^ user
]

{ #category : #accessing }
GeoOPActionUpdateUserPartTimeStatus >> user: anObject [
	user := anObject
]
