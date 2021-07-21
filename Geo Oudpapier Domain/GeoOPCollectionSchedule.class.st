Class {
	#name : #GeoOPCollectionSchedule,
	#superclass : #Object,
	#instVars : [
		'users',
		'collectionMonths',
		'status',
		'collectionPartTimes',
		'collectionDays',
		'randomGenerator',
		'actions',
		'mailPassword',
		'mutex',
		'websiteUrl',
		'collectionYears'
	],
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPCollectionSchedule >> actions [
	^ actions
]

{ #category : #actions }
GeoOPCollectionSchedule >> addAction: anAction [

	actions add: anAction
]

{ #category : #'adding removing' }
GeoOPCollectionSchedule >> addCollectionPartTime: aCollectionPartTime [

	Transcript cr; show: aCollectionPartTime dateAndTime.

	collectionPartTimes at: aCollectionPartTime dateAndTime put: aCollectionPartTime
]

{ #category : #'adding removing' }
GeoOPCollectionSchedule >> addCollectionPartTimes: aCollectionOfCollectionDays [
	aCollectionOfCollectionDays do: [ :collectionDay | self addCollectionPartTime: collectionDay ]
]

{ #category : #actions }
GeoOPCollectionSchedule >> addPartTime: partTimeName date: aDate title: title numberOfUsers: numberOfUsers needCar: needCar [
	| action |
	action := GeoOPActionAddCollectionPartTime new.
	action
		schedule: self;
		partTimeName: partTimeName;
		date: aDate;
		title: title;
		numberOfUsers: numberOfUsers;
		needCar: needCar.
	action doIt
]

{ #category : #'adding removing' }
GeoOPCollectionSchedule >> addUser: aUser [

	users at: aUser id put: aUser.
	aUser schedule: self.
	aUser ensureCollectionPartTimes
	
	
]

{ #category : #actions }
GeoOPCollectionSchedule >> addUserNamed: userName email: email phoneNumber: phoneNumber [
	| action |
	action := GeoOPActionAddUser new.
	action
		schedule: self;
		name: userName;
		email: email;
		phoneNumber: phoneNumber.
	action doIt
]

{ #category : #'adding removing' }
GeoOPCollectionSchedule >> addUsers: aCollectionOfUsers [

	aCollectionOfUsers do: [ : user | self addUser: user ]
]

{ #category : #accessing }
GeoOPCollectionSchedule >> closedCollectionPartTimes [
	^ self sortedCollectionPartTimes
		select: [ :partTime | partTime status = GeoOPPartTimeStatusClosed singleInstance ]
]

{ #category : #accessing }
GeoOPCollectionSchedule >> collectHtmlString [
	| ws partTimes monthNames sortedUsers |
	self collectionMonths.
	partTimes := self closedCollectionPartTimes.
	sortedUsers := self sortedUsers.
	monthNames := (partTimes collect: [ :partTime | partTime monthName ]) asSet.
	ws := WriteStream on: String new.
	ws
		nextPutAll: '<p>Beste Oud Papier Vrijwilligers,</p>';
		
		nextPutAll: '<p>Hierbij de indeling van het ophalen van het oud papier in '.
	monthNames do: [ :monthName | ws nextPutAll: monthName ] separatedBy: [ ws nextPut: $/ ].
	ws
		nextPutAll: '.</p>'.
	
	partTimes
		do: [ :partTime | 
			ws nextPutAll: '<p>'.
			partTime
				collectHtmlStringOn: ws
				users: sortedUsers. ws nextPutAll: '</p>'].
		
	ws nextPutAll: '<p>Zouden jullie nog even willen bevestigen door middel van een reply op deze mail?<br><br>Bedankt en goed weekend!<br><br>Georges en Rene</p>'.
	^ ws contents
]

{ #category : #accessing }
GeoOPCollectionSchedule >> collectionDays [

	collectionDays ifNil: [ self createCollectionDays ].
	^collectionDays
]

{ #category : #accessing }
GeoOPCollectionSchedule >> collectionMonths [

	collectionMonths ifNil: [ self createCollectionMonths ].
	^collectionMonths
]

{ #category : #accessing }
GeoOPCollectionSchedule >> collectionPartTimeAt: dateAndTime [

	^collectionPartTimes at: dateAndTime
]

{ #category : #accessing }
GeoOPCollectionSchedule >> collectionPartTimes [

	^collectionPartTimes
]

{ #category : #accessing }
GeoOPCollectionSchedule >> collectionYears [

	collectionYears ifNil: [ self createCollectionYears ].
	^collectionYears
]

{ #category : #actions }
GeoOPCollectionSchedule >> confirmPartTime: collectionPartTime user: user [
	| action |
	action := GeoOPActionUserConfirm new.
	action
		schedule: self;
		partTime: collectionPartTime;
		user: user.
	action doIt
]

{ #category : #private }
GeoOPCollectionSchedule >> createCollectionDays [
	collectionDays := SortedCollection new sortBlock: [ :dayA :dayB | dayA date <= dayB date ].
	(self sortedCollectionPartTimes groupedBy: [ :partTime | partTime date ])
		keysAndValuesDo: [ :date :partTimes | 
			| day |
			day := GeoOPCollectionDay new
				date: date;
				partTimes: (partTimes asSortedCollection: [ :pta :ptb | pta dateAndTime <= ptb dateAndTime ]).
			partTimes do: [ :partTime | partTime day: day ].
			collectionDays add: day ]
]

{ #category : #private }
GeoOPCollectionSchedule >> createCollectionMonths [
	| dict |
	dict := Dictionary new.
	collectionMonths := SortedCollection new sortBlock: [ :monthA :monthB | monthA monthObject <= monthB monthObject ].
	self sortedCollectionDays do: [ :day | (dict at: day date asMonth ifAbsentPut: [ OrderedCollection new ]) add: day ].
	dict
		keysAndValuesDo: [ :monthObject :days | 
			| month |
			month := GeoOPCollectionMonth new
				monthObject: monthObject;
				index: monthObject index;
				month: (self monthNameForIndex: monthObject index);
				days: days.
				days do: [ : day | day month: month ].
			collectionMonths add: month ]
]

{ #category : #private }
GeoOPCollectionSchedule >> createCollectionYears [
	| dict  |
	dict := Dictionary new.
	collectionYears := SortedCollection new sortBlock: [ :yearA :yearB | yearA year <= yearB year ].
	self collectionMonths  do: [ :month | (dict at: month year ifAbsentPut: [ OrderedCollection new ]) add: month ].
	dict
		keysAndValuesDo: [ :yearInt :months | 
			| year |
			year := GeoOPCollectionYear new
				year: yearInt;
				months: months.
			collectionYears add: year ]
]

{ #category : #accessing }
GeoOPCollectionSchedule >> currentCollectionYear [

	^self collectionYears ifEmpty: [ nil ] ifNotEmpty: [ :years | years last ]
]

{ #category : #persistence }
GeoOPCollectionSchedule >> fileContents [
	| contents fileReference |
	fileReference := self fileReference.
	fileReference exists
		ifFalse: [ ^'' ].
	contents := fileReference contents.
	^contents
]

{ #category : #persistence }
GeoOPCollectionSchedule >> fileIn [
	| contents |
	contents := self fileContents.
	(contents
		substrings: '%')
		do: [ :subString | 
			subString notEmpty
				ifTrue: [ (GeoOPAction fromString: subString schedule: self) fileIn ] ]
]

{ #category : #accessing }
GeoOPCollectionSchedule >> fileReference [
	^'./files/schedule.txt' asFileReference 
]

{ #category : #initialization }
GeoOPCollectionSchedule >> initialize [

	super initialize.
	users := Dictionary new.
	collectionPartTimes := Dictionary new.
	randomGenerator := Random new.
	actions := OrderedCollection new.
	mutex := Mutex new
]

{ #category : #accessing }
GeoOPCollectionSchedule >> mailPassword [
	^ mailPassword
]

{ #category : #accessing }
GeoOPCollectionSchedule >> mailPassword: anObject [
	mailPassword := anObject
]

{ #category : #actions }
GeoOPCollectionSchedule >> modifyUser: user name: userName email: email phoneNumber: phoneNumber [

	| action |
	action := GeoOPActionModifyUser new.
	action
		schedule: self;
		user: user;
		name: userName;
		email: email;
		phoneNumber: phoneNumber.
	action doIt
]

{ #category : #private }
GeoOPCollectionSchedule >> monthNameForIndex: monthIndex [
	^ {'Jan' . 'Feb' . 'Mrt' . 'Apr' . 'Mei' . 'Jun' . 'Jul' . 'Aug' . 'Sep' . 'Okt'.
	'Nov' . 'Dec'} at: monthIndex
]

{ #category : #accessing }
GeoOPCollectionSchedule >> mutex [

	^mutex
]

{ #category : #accessing }
GeoOPCollectionSchedule >> nextPassword [

	^(randomGenerator nextInt: 10000) asString
]

{ #category : #accessing }
GeoOPCollectionSchedule >> nextUserId [
	^(users ifEmpty: [ 0 ] ifNotEmpty: [ users maxValue: [ :user | user id ] ]) + 1.
]

{ #category : #accessing }
GeoOPCollectionSchedule >> reversedCollectionYears [

	^self collectionYears asSortedCollection: [ : yearA : yearB | yearA year >= yearB year ]
]

{ #category : #actions }
GeoOPCollectionSchedule >> sendConfirmMailForPartTime: collectionPartTime [
	| action |
	action := GeoOPActionConfirmMail new.
	action
		schedule: self;
		partTime: collectionPartTime.
	action doIt
]

{ #category : #'accessing mail' }
GeoOPCollectionSchedule >> sendConfirmMailToUsersFor: aPartTime [
	| usersToConfirm |
	usersToConfirm := self sortedUsers
		select: [ :user | (user collectionPartTimeAt: aPartTime) isScheduled].
	usersToConfirm do: [ :user | user sendConfirmMailFor: aPartTime ]
]

{ #category : #'accessing mail' }
GeoOPCollectionSchedule >> sendMailMessage: aMailMessage email: email [
	GeoOudPapierMailClient new
		sendTo: email
		message: aMailMessage
		password: mailPassword
]

{ #category : #'accessing mail' }
GeoOPCollectionSchedule >> sendMailMessage: aMailMessage to: aUser [
	| action |
	mailPassword ifNil: [ ^ self ].
	aUser email isEmpty ifTrue: [ ^self ].
	action := GeoOPActionEmail new.
	action
		schedule: self;
		user: aUser;
		email: aUser email;
		message: aMailMessage.
	action doIt
]

{ #category : #accessing }
GeoOPCollectionSchedule >> senderAddress [
	^ 'oud-papier@acwaterland.nl'
]

{ #category : #actions }
GeoOPCollectionSchedule >> setAdminUser [
	self
		addUser:
			(GeoOPUser new
				id: 0;
				name: 'admin';
				email: '';
				phoneNumber: '';
				password: 'opacw2017';
				role: GeoOPArchiveRole new;
				websiteRole: GeoOPUserWebsiteAdminRole new;
				yourself)
]

{ #category : #'accessing testEnvironment' }
GeoOPCollectionSchedule >> setupAsTestEnvironment [
	
	self users do: [ : user | user email: 'gkgobith@gmail.com'].
	websiteUrl := 'http://localhost:8080'
]

{ #category : #accessing }
GeoOPCollectionSchedule >> smptServerString [
	^ 'smtp.acwaterland.nl'
]

{ #category : #accessing }
GeoOPCollectionSchedule >> sortedCollectionDays [

	^self collectionDays asSortedCollection: [ : dayA : dayB | dayA date <= dayB date ]
]

{ #category : #accessing }
GeoOPCollectionSchedule >> sortedCollectionPartTimes [

	^collectionPartTimes asSortedCollection: [ : partTimeA : partTimeB | partTimeA dateAndTime <= partTimeB dateAndTime ]
]

{ #category : #accessing }
GeoOPCollectionSchedule >> sortedCollectionPartTimesByStatus [
	| open finished closed archived closedCollection openCollection finishedCollection archivedCollection |
	closed := GeoOPPartTimeStatusClosed singleInstance.
	open := GeoOPPartTimeStatusOpen singleInstance.
	finished := GeoOPPartTimeStatusFinished singleInstance.
	archived := GeoOPPartTimeStatusArchived singleInstance.
	closedCollection := SortedCollection
		sortBlock: [ :partTimeA :partTimeB | partTimeA dateAndTime <= partTimeB dateAndTime ].
	openCollection := SortedCollection
		sortBlock: [ :partTimeA :partTimeB | partTimeA dateAndTime <= partTimeB dateAndTime ].
	finishedCollection := SortedCollection
		sortBlock: [ :partTimeA :partTimeB | partTimeA dateAndTime <= partTimeB dateAndTime ].
	archivedCollection := SortedCollection
		sortBlock: [ :partTimeA :partTimeB | partTimeA dateAndTime <= partTimeB dateAndTime ].
	self collectionPartTimes
		do: [ :partTime | 
			partTime status = closed
				ifTrue: [ closedCollection add: partTime ].
			partTime status = open
				ifTrue: [ openCollection add: partTime ].
			partTime status = finished
				ifTrue: [ finishedCollection add: partTime ].
			partTime status = archived
				ifTrue: [ archivedCollection add: partTime ] ].
	^ Array
		with: closedCollection
		with: openCollection
		with: finishedCollection
		with: archivedCollection
]

{ #category : #accessing }
GeoOPCollectionSchedule >> sortedUsers [

	^users asSortedCollection: [ : userA : userB | userA name <= userB name ]
]

{ #category : #accessing }
GeoOPCollectionSchedule >> sortedUsersInSchedule [
	^ self sortedUsers select: [ :user | user showInSchedule ]
]

{ #category : #actions }
GeoOPCollectionSchedule >> updateRolesFor: aUser websiteRoleString: websiteRoleString roleString: roleString [
	| action |
	action := GeoOPActionUpdateUserRoles new.
	action
		schedule: self;
		user: aUser;
		websiteRoleString: websiteRoleString;
		roleString: roleString.
	action doIt
]

{ #category : #actions }
GeoOPCollectionSchedule >> updateStatus: newStatus partTime: collectionPartTime [
	| action |
	action := GeoOPActionUpdatePartTimeStatus new.
	action
		schedule: self;
		partTime: collectionPartTime;
		status: newStatus.
	action doIt
]

{ #category : #actions }
GeoOPCollectionSchedule >> updateStatus: newStatus user: user collectionPartTime: collectionPartTime [
	| action |
	action := GeoOPActionUpdateUserPartTimeStatus new.
	action
		schedule: self;
		user: user;
		collectionPartTime: collectionPartTime;
		status: newStatus.
	action doIt
]

{ #category : #accessing }
GeoOPCollectionSchedule >> userAt: userId [

	^users at: userId ifAbsent: nil
]

{ #category : #accessing }
GeoOPCollectionSchedule >> userNamed: userName [

	^users detect: [ : user | user name = userName ] ifNone: nil
]

{ #category : #accessing }
GeoOPCollectionSchedule >> userWelcomeHtmlString [
	| ws |
	ws := WriteStream on: String new.
	self sortedUsers
		do: [ :user | user welcomeHtmlStringOn: ws ]
		separatedBy: [ ws nextPutAll: '---'
				].
	^ ws contents
]

{ #category : #accessing }
GeoOPCollectionSchedule >> users [
	^ users
]

{ #category : #accessing }
GeoOPCollectionSchedule >> visibleCollectionMonths [

	^self collectionMonths select: [ : month | month isVisible ]
]

{ #category : #accessing }
GeoOPCollectionSchedule >> visibleCollectionYears [

	^self collectionYears select: [ : year | year isVisible ]
]

{ #category : #accessing }
GeoOPCollectionSchedule >> visibleSortedCollectionPartTimes [

	^self sortedCollectionPartTimes select: [ : pt | pt isVisible ]
]

{ #category : #accessing }
GeoOPCollectionSchedule >> websiteUrl [

	websiteUrl ifNil: [ websiteUrl := 'http://oudpapieracw.pharocloud.com' ].
	^websiteUrl
]
