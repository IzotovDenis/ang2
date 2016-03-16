@dashboard = angular.module("Dashboard", ["ngResource","ng-rails-csrf", "templates", "ngRoute", "ui.bootstrap", "ngSanitize", "naif.base64", "textAngular", "dndLists", "treeControl","angularFileUpload"])

dashboard.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
	$locationProvider.html5Mode false
	$routeProvider.when '/users', templateUrl: 'dashboard/templates/users/index.html', controller: "UsersIndexCtrl"
	$routeProvider.when '/users/:userId', templateUrl: 'dashboard/templates/users/show.html', controller: "UsersShowCtrl"
	$routeProvider.when '/users/:userId/edit', templateUrl: 'dashboard/templates/users/edit.html', controller: "UsersEditCtrl"
	$routeProvider.when '/activities', templateUrl: 'dashboard/templates/activities/index.html', controller: "ActivitiesIndexCtrl"
	$routeProvider.when '/orders', templateUrl: 'dashboard/templates/orders/index.html', controller: "OrdersIndexCtrl"
	$routeProvider.when '/offers', templateUrl: 'dashboard/templates/offers/index.html', controller: "OffersIndexCtrl"
	$routeProvider.when '/offers/:offerId', templateUrl: 'dashboard/templates/offers/show.html', controller: "OffersShowCtrl"
	$routeProvider.when '/orders/:orderId', templateUrl: 'dashboard/templates/orders/show.html', controller: "OrdersShowCtrl"
	$routeProvider.when '/orders/new', templateUrl: 'dashboard/templates/orders/show.html', controller: "OrdersShowCtrl"
	$routeProvider.when '/banners', templateUrl: 'dashboard/templates/banners/index.html', controller: "BannersIndexCtrl"
	$routeProvider.when '/groups', templateUrl: 'dashboard/templates/groups/index.html', controller: "GroupsIndexCtrl"
	$routeProvider.when '/groups/:groupId', templateUrl: 'dashboard/templates/groups/show.html', controller: "GroupsShowCtrl"
	$routeProvider.when '/posts', templateUrl: 'dashboard/templates/posts/index.html', controller: "PostsIndexCtrl"
	$routeProvider.when '/posts/:postId', templateUrl: 'dashboard/templates/posts/show.html', controller: "PostsShowCtrl"
	$routeProvider.when '/pricelist/', templateUrl: 'dashboard/templates/pricelists/index.html', controller: "PricelistsIndexCtrl"
	$routeProvider.when '/files/', templateUrl: 'dashboard/templates/files/index.html', controller: "FilesIndexCtrl"
	$routeProvider.when '/', templateUrl: 'dashboard/templates/dashboard.html', controller: "MainCtrl"

]