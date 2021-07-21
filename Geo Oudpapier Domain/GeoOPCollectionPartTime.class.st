Class {
	#name : #GeoOPCollectionPartTime,
	#superclass : #Object,
	#instVars : [
		'dateAndTime',
		'day',
		'title',
		'numberOfUsers',
		'needCar',
		'status',
		'nrOfSendMail'
	],
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPCollectionPartTime class >> fromString: aString [
	^ (self subclasses detect: [ :cls | cls partTimeName = aString ]) new
]

{ #category : #accessing }
GeoOPCollectionPartTime class >> neoJsonMappingOn: mapping [

	"dateAndTime day title numberOfUsers needCar status nrOfSendMail"

	mapping
		mapAccessor: #dateAndTimeString to: #datetime;
		mapInstVar: #title;
		mapInstVar: #numberOfUsers;
		mapAccessor: #statusSymbol to: #status;
		mapAccessor: #longName;
		mapAccessor: #shortName
		
]

{ #category : #accessing }
GeoOPCollectionPartTime class >> partTimeName [

	^self subclassResponsibility 
]

{ #category : #comparing }
GeoOPCollectionPartTime >> <= aGeoOPCollectionPartTime [

	^dateAndTime <= aGeoOPCollectionPartTime dateAndTime
]

{ #category : #accessing }
GeoOPCollectionPartTime >> addOneToNrOfSendMail [

	nrOfSendMail := nrOfSendMail + 1
]

{ #category : #printing }
GeoOPCollectionPartTime >> collectHtmlStringOn: ws users: sortedUsers [
	ws
		nextPutAll: 'Ingepland ';
		nextPutAll: day dayName;
		space;
		print: self dayOfMonth;
		space;
		nextPutAll: self monthName;
		space;
		nextPutAll:
			(self isMorning
				ifTrue: [ 'in de ochtend ' ]
				ifFalse: [ 'in de middag ' ]);
		nextPutAll: '(verzamelen ';
		nextPutAll: self startTimeString;
		nextPutAll: ' uur op de parkeerplaats aan de Sportlaan), ';
		nextPutAll: self routeString.
	ws nextPutAll: '<br>'.
	ws nextPutAll: '<ul>'.
	sortedUsers
		do: [ :user | 
			| userPartTime |
			userPartTime := user collectionPartTimeAt: self.
			userPartTime isScheduled
				ifTrue: [ ws nextPutAll: '<li>'.
					ws nextPutAll: user name.
					userPartTime status isScheduledDriver
						ifTrue: [ ws nextPutAll: ' (+auto en aanhanger)' ].
					ws nextPutAll: '</li>' ] ].
	ws nextPutAll: '</ul>'
]

{ #category : #accessing }
GeoOPCollectionPartTime >> date [
	^dateAndTime asDate 
]

{ #category : #accessing }
GeoOPCollectionPartTime >> dateAndTime [

	^dateAndTime
]

{ #category : #accessing }
GeoOPCollectionPartTime >> dateAndTime: aDateAndTime [

	dateAndTime := aDateAndTime
]

{ #category : #accessing }
GeoOPCollectionPartTime >> dateAndTimeString [

	^dateAndTime printString 
]

{ #category : #accessing }
GeoOPCollectionPartTime >> dateAndtimeString [

	^dateAndTime asSeconds printString
]

{ #category : #printing }
GeoOPCollectionPartTime >> dateString [

	^self date printString
]

{ #category : #accessing }
GeoOPCollectionPartTime >> day [
	^ day
]

{ #category : #accessing }
GeoOPCollectionPartTime >> day: anObject [
	day := anObject
]

{ #category : #accessing }
GeoOPCollectionPartTime >> dayName [
	^day dayName
]

{ #category : #accessing }
GeoOPCollectionPartTime >> dayOfMonth [

	^dateAndTime dayOfMonth
]

{ #category : #accessing }
GeoOPCollectionPartTime >> fromDate: aDate [ 
	self subclassResponsibility .
]

{ #category : #initialization }
GeoOPCollectionPartTime >> initialize [

	super initialize.
	status := GeoOPPartTimeStatusOpen singleInstance.
	nrOfSendMail := 0
]

{ #category : #testing }
GeoOPCollectionPartTime >> isActive [

	^status isActive
]

{ #category : #testing }
GeoOPCollectionPartTime >> isMorning [

	^false
]

{ #category : #testing }
GeoOPCollectionPartTime >> isVisible [

	^status isVisible
]

{ #category : #printing }
GeoOPCollectionPartTime >> longName [

	^self subclassResponsibility 
]

{ #category : #testing }
GeoOPCollectionPartTime >> meetsRequirements: users [
	| selectedUsers |
	selectedUsers := users select: [ :user | (user collectionPartTimeAt: self) isParticipating ].
	selectedUsers size >= numberOfUsers
		ifFalse: [ ^ false ].
	^ needCar
		ifTrue: [ selectedUsers anySatisfy: [ :user | user isDriver ] ]
		ifFalse: [ true ]
]

{ #category : #accessing }
GeoOPCollectionPartTime >> month [

	^day month
]

{ #category : #accessing }
GeoOPCollectionPartTime >> monthName [
	^day monthName
]

{ #category : #accessing }
GeoOPCollectionPartTime >> needCar [
	^ needCar
]

{ #category : #accessing }
GeoOPCollectionPartTime >> needCar: aBoolean [

	needCar := aBoolean
]

{ #category : #accessing }
GeoOPCollectionPartTime >> nrOfSendMail [
	^ nrOfSendMail
]

{ #category : #accessing }
GeoOPCollectionPartTime >> numberOfUsers [
	^ numberOfUsers
]

{ #category : #accessing }
GeoOPCollectionPartTime >> numberOfUsers: anInteger [ 
	
		numberOfUsers := anInteger
]

{ #category : #accessing }
GeoOPCollectionPartTime >> partTimeName [
	^self class partTimeName
]

{ #category : #printing }
GeoOPCollectionPartTime >> partTimeString [

	^self subclassResponsibility 
]

{ #category : #printing }
GeoOPCollectionPartTime >> postFixString [

	^self subclassResponsibility 
]

{ #category : #printing }
GeoOPCollectionPartTime >> prettyString [

	^self longName , ' ' , self date printString
]

{ #category : #printing }
GeoOPCollectionPartTime >> printOn: aStream [
	aStream
		nextPutAll: self longName;
		tab;
		nextPutAll: self dateString
]

{ #category : #printing }
GeoOPCollectionPartTime >> routeString [
	title = 'Ten Oosten van het Lint (Ochtend)'
		ifTrue: [ ^ 'route oude dorp en fiets' ].
	title = 'Ten Oosten van het Lint (Middag)'
		ifTrue: [ ^ 'route Havezathe' ].
	title = 'Ten Westen van het Lint (Ochtend)'
		ifTrue: [ ^ 'route West (omgeving Sportlaan, Het Lint en Luijendijk)' ].
	^ title
]

{ #category : #printing }
GeoOPCollectionPartTime >> scheduledHtmlStringOn: ws [
	ws
		nextPutAll: '<b>Zaterdag ';
		print: self dayOfMonth;
		space;
		nextPutAll: self monthName;
		space;
		nextPutAll:
			(self isMorning
				ifTrue: [ 'in de ochtend' ]
				ifFalse: [ 'in de middag' ]);
		nextPutAll: '</b>';
		nextPutAll: ' (verzamelen ';
		nextPutAll: self startTimeString;
		nextPutAll: ', ';
		nextPutAll: self routeString;
		nextPutAll: ')'
]

{ #category : #printing }
GeoOPCollectionPartTime >> shortName [

	^self subclassResponsibility 
]

{ #category : #accessing }
GeoOPCollectionPartTime >> startTimeString [

	^self subclassResponsibility 
]

{ #category : #accessing }
GeoOPCollectionPartTime >> status [

	^status
]

{ #category : #accessing }
GeoOPCollectionPartTime >> status: aStatus [

	status := aStatus
]

{ #category : #accessing }
GeoOPCollectionPartTime >> statusString [

	^status statusString
]

{ #category : #accessing }
GeoOPCollectionPartTime >> statusSymbol [

	^status statusSymbol
]

{ #category : #accessing }
GeoOPCollectionPartTime >> title [
	
		^title 
]

{ #category : #accessing }
GeoOPCollectionPartTime >> title: aString [ 
	
		title := aString
]

{ #category : #accessing }
GeoOPCollectionPartTime >> userCollectionDayClass [

	^self subclassResponsibility 
]
