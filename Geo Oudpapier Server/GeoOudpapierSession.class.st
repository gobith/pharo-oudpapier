Class {
	#name : #GeoOudpapierSession,
	#superclass : #Object,
	#instVars : [
		'teapot',
		'schedule'
	],
	#category : #'Geo Oudpapier Server'
}

{ #category : #initialization }
GeoOudpapierSession >> addRoutes [

	teapot
		GET: '/getuser' -> [ :request | self request_user: request ];
		GET: '/login' -> [ :request | self request_login: request ];
		GET: '/logout' -> [ :request | self request_logout: request ];
		GET: '/users' -> [ :request | self request_users: request ];
		GET: '/years' -> [ :request | self request_years: request ];
		GET: '/current-year' -> [ :request | self request_currentYear: request ]
]

{ #category : #'accessing-objects' }
GeoOudpapierSession >> adminYears [

	| dict |
	dict := Dictionary new.

	dict at: 'years' put: schedule reversedCollectionYears.
	dict
		at: 'users'
		put: (schedule sortedUsersInSchedule
		collect: [ :user | 
			Dictionary new
				at: 'id' put: user id;
				at: 'name' put: user name;
				yourself ]).
			dict at: 'status' put: schedule statusCollection.

	^ dict
]

{ #category : #initialization }
GeoOudpapierSession >> initialize [ 

	super initialize .
	
]

{ #category : #initialization }
GeoOudpapierSession >> login: aRequest [

	^'{"test": 12}'
]

{ #category : #'accessing-objects' }
GeoOudpapierSession >> normalUserYears [

		| dict |
	dict := Dictionary new.

	dict at: 'years' put: (Array with: schedule currentCollectionYear ).
	dict
		at: 'users'
		put: (schedule sortedUsersInSchedule
		collect: [ :user | 
			Dictionary new
				at: 'id' put: user id;
				at: 'name' put: user name;
				yourself ]).
			dict at: 'status' put: schedule statusCollection.

	^ dict

]

{ #category : #initialization }
GeoOudpapierSession >> portNumber [
	^ 8090
]

{ #category : #'accessing-requests' }
GeoOudpapierSession >> request_currentYear: aRequest [ 

		| dict |
	dict := Dictionary new.

	dict at: 'years' put: (Array with: schedule currentCollectionYear ).
	dict
		at: 'users'
		put: (schedule sortedUsersInSchedule
		collect: [ :user | 
			Dictionary new
				at: 'id' put: user id;
				at: 'name' put: user name;
				yourself ]).
			dict at: 'status' put: schedule statusCollection.

	^ dict

]

{ #category : #'accessing-requests' }
GeoOudpapierSession >> request_login: aRequest [

	| authorization response userName password user session |

	response := self userObjectFor: nil.

	authorization := [ aRequest basicAuthentication ]
		                 on: Error
		                 do: [ nil ].

	authorization ifNil: [ ^response ].
	userName := authorization first.
	password := authorization last.

	user := schedule userNamed: userName.
	user ifNil: [ ^ response ].
	user password = password ifFalse: [ ^ response ].
	session := aRequest session.
	session attributeAt: 'user' put: user id.

	
		
	^self userObjectFor: user
]

{ #category : #'accessing-requests' }
GeoOudpapierSession >> request_logout: aRequest [

	| response |
	response := Dictionary new.
	response
		at: 'id' put: nil;
		at: 'name' put: '';
		at: 'loggedIn' put: false;
		at: 'isAdmin' put: false.

	aRequest session removeAttribute: 'user'.


	^ response
]

{ #category : #'accessing-requests' }
GeoOudpapierSession >> request_user: aRequest [

	| session user |
	user := nil.
	session := aRequest session.
	session isValid ifTrue: [ 
		(session attributeAt: 'user' ifAbsent: [ nil ]) ifNotNil: [ :userId | 
			user := schedule userAt: userId ] ].

	^ self userObjectFor: user
]

{ #category : #'accessing-requests' }
GeoOudpapierSession >> request_users: aRequest [
		
	^schedule sortedUsers
]

{ #category : #'accessing-requests' }
GeoOudpapierSession >> request_years: aRequest [

	| user |
	user := self userOrNilFor: aRequest.
	user ifNil: [ ^ Dictionary new ].

	^ user isAdmin
		  ifTrue: [ self adminYears ]
		  ifFalse: [ self normalUserYears ]
]

{ #category : #'accessing-objects' }
GeoOudpapierSession >> scheduledObjectFor: aUser [

	^ (aUser sortedCollectionPartTimes select: [ :partTime | 
		   partTime isActive and: [ 
			   partTime isScheduled or: [ partTime isConfirmed ] ] ]) collect: [ 
		  :userPartTime | 
		  | dict partTime |
		  dict := Dictionary new.
		  partTime := userPartTime partTime.
		  dict at: 'date' put: ('<1s> <2p> <3s> <4s>'
				   expandMacrosWith: partTime dayName
				   with: partTime dayOfMonth
				   with: partTime monthName
				   with: (partTime isMorning
						    ifTrue: [ 'in de ochtend' ]
						    ifFalse: [ 'in de middag' ])).
		  dict
			  at: 'time'
			  put:
				  ('<1s> uur op de parkeerplaats aan de Sportlaan' 
					   expandMacrosWith: partTime startTimeString).
		  dict at: 'route' put: partTime routeString.
		  dict ]
]

{ #category : #initialization }
GeoOudpapierSession >> start [

	self stop.
	
	schedule := GeoOPCollectionSchedule new.
	schedule fileIn.
	schedule setAdminUser.
	schedule createCollectionMonths.
	
	teapot := Teapot configure: {(#port -> self portNumber) . #defaultOutput -> #json . #debugMode -> true}.

	self addRoutes.
	teapot start
]

{ #category : #initialization }
GeoOudpapierSession >> stop [ 
	
	teapot ifNotNil: [ teapot stop ].
	teapot := nil.
	schedule := nil
]

{ #category : #'accessing-objects' }
GeoOudpapierSession >> userObjectFor: aUser [

	| dict |
	dict := Dictionary new.

	aUser
		ifNil: [ 
			dict
				at: 'id' put: nil;
				at: 'name' put: '';
				at: 'loggedIn' put: false;
				at: 'isAdmin' put: false ]
		ifNotNil: [ 
			dict
				at: 'id' put: aUser id;
				at: 'name' put: aUser name;
				at: 'loggedIn' put: true;
				at: 'isAdmin' put: aUser isAdmin;
				at: 'scheduled' put: (self scheduledObjectFor: aUser)  ].

	
	^ dict
]

{ #category : #'accessing-requests' }
GeoOudpapierSession >> userOrNilFor: aRequest [

	| session user |
	user := nil.
	session := aRequest session.
	session isValid ifTrue: [ 
		(session attributeAt: 'user' ifAbsent: [ nil ]) ifNotNil: [ :userId | 
			user := schedule userAt: userId ] ].

	^ user
]
