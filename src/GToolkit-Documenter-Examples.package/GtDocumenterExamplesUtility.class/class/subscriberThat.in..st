utility - system environment
subscriberThat: anOneArgBlock in: anAnnouncer
	<return: #Object>
	^ (self 
		subscriptionThat: [ :eachSubscription | 
			anOneArgBlock cull: eachSubscription subscriber ] 
		in: anAnnouncer) subscriber