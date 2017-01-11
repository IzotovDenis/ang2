@app = angular.module("App", ["ngResource", "treeControl","ng-rails-csrf", "templates", "ngRoute", "ui.bootstrap", "ngSanitize", "ngAnimate", "QuickList"])

app.config ["$routeProvider", "$locationProvider", "$httpProvider", ($routeProvider, $locationProvider, $httpProvider) ->
	$httpProvider.interceptors.push('httpInterceptor')
	$locationProvider.html5Mode true
	$routeProvider.when '/groups/:groupId', templateUrl: 'groups/show.html', controller: 'GroupCtrl'
	$routeProvider.when '/brands', templateUrl: 'brands/index.html', controller: 'BrandIndexCtrl'
	$routeProvider.when '/brands/:brandId', templateUrl: 'brands/show.html', controller: 'BrandShowCtrl'
	$routeProvider.when '/items/:itemId', templateUrl: 'items/show.html', controller: 'ItemShowCtrl'
	$routeProvider.when '/find', templateUrl: 'find/index.html', controller: 'FindCtrl'
	$routeProvider.when '/newest', templateUrl: 'newest/index.html', controller: 'NewestCtrl'
	$routeProvider.when '/profile', templateUrl: 'profile/index.html', controller: "ProfileCtrl"
	$routeProvider.when '/orders', templateUrl: 'orders/index.html', controller: "OrderIndexCtrl"
	$routeProvider.when '/orders/:orderId', templateUrl: 'orders/show.html', controller: "OrderShowCtrl"
	$routeProvider.when '/offers/:offerId', templateUrl: 'offers/show.html', controller: "OfferShowCtrl"
	$routeProvider.when '/info/:page', templateUrl: 'info/show.html', controller: "InfoShowCtrl"
	$routeProvider.when '/booking', templateUrl: 'booking/index.html', controller: "BookingCtrl"
	$routeProvider.when '/', templateUrl: 'groups/index.html', controller: "GroupIndexCtrl"
	$routeProvider.otherwise templateUrl: '404.html'
]

app.factory "OrderItem", ["$resource",($resource) ->
	$resource("api/order_items/:id.json", {id: "@id"}, {update: {method: "PUT"}})
]

app.run ["$rootScope", "User", "Order","$http", "System", ($rootScope, User, Order, $http, System)->
	$rootScope.system = System
	User.getCurrent().then ((res) ->
		doc = document.querySelector('meta[name="csrf-token"]').content
		ang = $http.defaults.headers.common['X-CSRF-TOKEN']
		unless doc == res.token
			document.querySelector('meta[name="csrf-token"]').content = res.token
		unless ang == res.token
			$http.defaults.headers.common['X-CSRF-TOKEN'] = res.token
		$rootScope.appLoad = true
		Order.getCurrentIds()
	), (reason) ->
		$rootScope.appLoad = true
	]