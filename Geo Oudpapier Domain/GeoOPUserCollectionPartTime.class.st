Class {
	#name : #GeoOPUserCollectionPartTime,
	#superclass : #Object,
	#instVars : [
		'user',
		'dateAndTime',
		'partTime',
		'status'
	],
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPUserCollectionPartTime class >> neoJsonMappingOn: mapping [

	"user dateAndTime partTime status"

	mapping
		mapAccessor: #partTimeName to: #partTime;
		mapAccessor: #userId to: #user;
		mapAccessor: #dateAndTimeString to: #datetime;
		mapAccessor: #statusSymbol to: #status
]

{ #category : #accessing }
GeoOPUserCollectionPartTime class >> partTimeName [

	self subclassResponsibility 
]

{ #category : #comparing }
GeoOPUserCollectionPartTime >> <= aPartTime [

	^dateAndTime <= aPartTime dateAndTime 
	
	
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> colorString [
	^ partTime isActive
		ifTrue: [ status colorString]
		ifFalse: [ status inactiveColorString ]
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> date [
	^ dateAndTime asDate
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> dateAndTime [
	^ dateAndTime
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> dateAndTime: anObject [
	dateAndTime := anObject
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> dateAndTimeString [

	^dateAndTime printString
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> dateAndtimeString [

	^dateAndTime asSeconds printString
]

{ #category : #initialization }
GeoOPUserCollectionPartTime >> initialize [

	super initialize.
	status := GeoOPUserStatusNeutral singleInstance
]

{ #category : #testing }
GeoOPUserCollectionPartTime >> isActive [

	^partTime isActive
]

{ #category : #testing }
GeoOPUserCollectionPartTime >> isConfirmed [

	^status isConfirmed
]

{ #category : #testing }
GeoOPUserCollectionPartTime >> isParticipating [

	^status isParticipating
]

{ #category : #testing }
GeoOPUserCollectionPartTime >> isScheduled [

	^status isScheduled
]

{ #category : #testing }
GeoOPUserCollectionPartTime >> isScheduledOrConfirmed [
	^status isScheduledOrConfirmed
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> isVisible [
	
		^partTime isVisible
]

{ #category : #printing }
GeoOPUserCollectionPartTime >> longName [

	^self subclassResponsibility 
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> month [
	^partTime month
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> partTime [
	^ partTime
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> partTime: anObject [
	partTime := anObject
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> partTimeName [

	^self class partTimeName
]

{ #category : #printing }
GeoOPUserCollectionPartTime >> partTimeString [

	^partTime partTimeString
]

{ #category : #printing }
GeoOPUserCollectionPartTime >> prettyLongString [

	^self date printString , ' ' , self title
]

{ #category : #printing }
GeoOPUserCollectionPartTime >> prettyString [

	^self longName , ' ' , self date printString
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> scheduleImage [
	^ partTime status scheduleImageFor: status
	
	
	
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> scheduleString [
	^ partTime status scheduleStringFor: status
	
	
	
]

{ #category : #printing }
GeoOPUserCollectionPartTime >> scheduledHtmlString [
	| ws |
	ws := WriteStream on: String new.
	self scheduledHtmlStringOn: ws.
	^ ws contents
]

{ #category : #printing }
GeoOPUserCollectionPartTime >> scheduledHtmlStringOn: ws [
	
	ws
		nextPutAll: '<b>';
		nextPutAll: partTime dayName;
		space;
		print: partTime dayOfMonth;
		space;
		nextPutAll: partTime monthName;
		space;
		nextPutAll:
			(partTime isMorning
				ifTrue: [ 'in de ochtend' ]
				ifFalse: [ 'in de middag' ]);
		nextPutAll: '</b>';
		nextPutAll: '<ul>'.
	(status isScheduledDriver or: [ status isConfirmedDriver ])
		ifTrue: [ ws nextPutAll: '<li>auto met aanhanger</li>' ].
	ws
		nextPutAll: '<li>verzamelen ';
		nextPutAll: partTime startTimeString;
		nextPutAll: ' uur op de parkeerplaats aan de Sportlaan';
		nextPutAll: '</li>';
		nextPutAll: '<li>';
		nextPutAll: partTime routeString;
		nextPutAll: '</li>';
		nextPutAll: '</ul>'
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> status [

	^status
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> status: newStatus [ 
	status := newStatus
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> statusSymbol [

	^status statusSymbol
	
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> title [
	^partTime title
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> user [
	^ user
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> user: anObject [
	user := anObject
]

{ #category : #accessing }
GeoOPUserCollectionPartTime >> userId [

	^user id
]
