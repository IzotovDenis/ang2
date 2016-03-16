app.filter "getById", ->
  (input, id) ->
    i = 0
    len = input.length
    while i < len
      return input[i]  if +input[i].item_id is +id
      i++
    null