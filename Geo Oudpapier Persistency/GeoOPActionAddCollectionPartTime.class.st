Class {
	#name : #GeoOPActionAddCollectionPartTime,
	#superclass : #GeoOPAction,
	#instVars : [
		'partTimeName',
		'date',
		'title',
		'numberOfUsers',
		'needCar'
	],
	#category : #'Geo Oudpapier Persistency'
}

{ #category : #private }
GeoOPActionAddCollectionPartTime class >> headerString [
	^'AddCollectionPartTime'
]

{ #category : #accessing }
GeoOPActionAddCollectionPartTime >> date [
	^ date
]

{ #category : #accessing }
GeoOPActionAddCollectionPartTime >> date: anObject [
	date := anObject
]

{ #category : #actions }
GeoOPActionAddCollectionPartTime >> doIt [
	| partTime |
	partTime := GeoOPCollectionPartTime fromString: partTimeName.
	partTime fromDate: date.
	partTime
		title: title;
		numberOfUsers: numberOfUsers;
		needCar: needCar.
	schedule addCollectionPartTime: partTime.
	self persist
]

{ #category : #actions }
GeoOPActionAddCollectionPartTime >> fileIn [
	| partTime |
	partTimeName := (substrings at: 3).
	date := Date julianDayNumber: (substrings at: 4) asInteger.
	title := (substrings at: 5).
	numberOfUsers := (substrings at: 6) asInteger min: 4.
	needCar := false.
	partTime := GeoOPCollectionPartTime fromString: partTimeName.
	partTime fromDate: date.
	partTime
		title: title;
		numberOfUsers: numberOfUsers;
		needCar: needCar.
	schedule addCollectionPartTime: partTime.
	self addToSchedule
]

{ #category : #accessing }
GeoOPActionAddCollectionPartTime >> needCar [
	^ needCar
]

{ #category : #accessing }
GeoOPActionAddCollectionPartTime >> needCar: anObject [
	needCar := anObject
]

{ #category : #accessing }
GeoOPActionAddCollectionPartTime >> numberOfUsers [
	^ numberOfUsers
]

{ #category : #accessing }
GeoOPActionAddCollectionPartTime >> numberOfUsers: anObject [
	numberOfUsers := anObject
]

{ #category : #accessing }
GeoOPActionAddCollectionPartTime >> partTimeName [
	^ partTimeName
]

{ #category : #accessing }
GeoOPActionAddCollectionPartTime >> partTimeName: anObject [
	partTimeName := anObject
]

{ #category : #persistence }
GeoOPActionAddCollectionPartTime >> persistenceString [
	| ws |
	ws := WriteStream on: String new.
	self addHeaderOn: ws.
	ws
		nextPutAll: partTimeName;
		nextPut: self separator;
		print: date julianDayNumber;
		nextPut: self separator;
		nextPutAll: title;
		nextPut: self separator;
		print: numberOfUsers;
		nextPut: self separator;
		print: needCar.
	^ ws contents
]

{ #category : #accessing }
GeoOPActionAddCollectionPartTime >> title [
	^ title
]

{ #category : #accessing }
GeoOPActionAddCollectionPartTime >> title: anObject [
	title := anObject
]
