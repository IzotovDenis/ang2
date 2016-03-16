app.factory "httpInterceptor", ["$location", "$q", "$rootScope", ($location, $q, $rootScope) ->
	{	'responseError': (rejection) ->
			url = rejection.config.url
			if rejection.status == 0
				switch (true)
					when /api\/order_items/.test(url), /api\/orders/.test(url)
							alert("Ошибка. Сервер не доступен.")	
					else
							$rootScope.system.error.status = true
							$rootScope.system.error.message = "Невозможно подключиться к серверу. Проверьте подключение к интернету."
			if rejection.status == 500
				switch (true)
					when /api\/order_items/.test(url)
							alert("Ошибка при добавлении в корзину")
					else
							$rootScope.system.error.status = true
							$rootScope.system.error.message = "Произошла ошибка 500. Попробуйте позже."
			if rejection.status == 404
				switch (true)
					when /api\/order_items/.test(url)
							alert("Ошибка, объект не найден.")
					else
							$rootScope.system.error.status = true
							$rootScope.system.error.message = "Произошла ошибка 404. Страница не найдена."
			if rejection.status == 422
				console.log("error")
			return $q.reject(rejection)
		'response': (response) ->
			if /api/.test(response.config.url)
				$rootScope.system.error.status = false
			$rootScope.system.error.status = false
			return response
	}
]