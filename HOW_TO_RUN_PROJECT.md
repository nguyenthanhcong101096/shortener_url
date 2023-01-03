# README
## Dependences
- Ruby: 3.0.4
- Rails: 7.0.4

## Environment
```
$ cp .env.example .env
```

## Run app
- run in local

	```
	cd /project

	bundle install

	rails db:create db:migrate db:seed

	rails server
	```

- run docker

	```
	cd /project

	docker-compose -f docker-compose.yml up -d

	docker exec -ti rails bundle exec rake db:create db:migrate db:seed
	```

## Run rspec

```
bundle exec rspec
```

## Run rubocop

```
bundle exec rubocop
```

## Get access token
- in local

	```
	 rails console
	```

	```ruby
	pry(main)> JsonWebToken.encode(sub: User.first.id)
	
	=>"eyJhbGciOiJIUzI1NiJ9eyJleHAiOjE2NzUyNjI3NzMsImp0aSI6IjNiYWVlMDQ1LTQyMWItNDAyOS1iOWYxLWE1Zjk3ZTMxZDE0MiIsInN1YiI6MX0La8nhxnzuQdzTYPDqSywPpZAUKygBKx4znAyJyu9giM"
	```

- in docker

	```
	docker exec -ti rails bundle exec rails console
	```

	```ruby
	pry(main)> JsonWebToken.encode(sub: User.first.id)
	
	=>"eyJhbGciOiJIUzI1NiJ9eyJleHAiOjE2NzUyNjI3NzMsImp0aSI6IjNiYWVlMDQ1LTQyMWItNDAyOS1iOWYxLWE1Zjk3ZTMxZDE0MiIsInN1YiI6MX0La8nhxnzuQdzTYPDqSywPpZAUKygBKx4znAyJyu9giM"
	```

	> NOTE: You can use this access_token to using API
	> eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NzUyNjA3MDEsImp0aSI6IjZlYWU5MzUzLWFkZDUtNDg5Ni05YzUzLTE4YTg4YzVjMjUwMiIsInN1YiI6MX0.F2P5OEg76wFnMSixMy8gt8_gecZVPIWEQpxD8IdQqbo

## Use API
[Documentation](https://documenter.getpostman.com/view/3235454/2s8Z711CQs)

Access Token 

`eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NzUyNjA3MDEsImp0aSI6IjZlYWU5MzUzLWFkZDUtNDg5Ni05YzUzLTE4YTg4YzVjMjUwMiIsInN1YiI6MX0.F2P5OEg76wFnMSixMy8gt8_gecZVPIWEQpxD8IdQqbo`

### Enpoint

|                                                | METHOD        | URI              |
| ---------------------------------------------- | --------------- | ---------------- |
| Encodes a URL to a shortened URL           | POST| /api/v1/encode |
| Decodes a shortened URL to its original    | GET | /api/v1/decode  |

### Encodes a URL to a shortened URL
- Enpoint

  ```
  POST api/v1/encode
  ```

- Parameter

  | Location | Required | Name | Type | Description |
  | ---------| ---------|------|------|-------------|
  | Headers  | true     | Authorization | string | abc|
  | Body     | true     | origin_url    | string | That a URL can be encoded into a short URL
  | Body     | optional | custom_short_url | string | User can custom short_url

- Example

  request
  ```shell
  curl --location -g --request POST '{{base_url}}/api/v1/encode' \
  --header 'Authorization: Bearer {{access_token}}x' \
  --data-raw '{
      "origin_url": "https://stackoverflow.com/questions/22623656/how-to-redirect-to-and-return-a-200-status-code",
      "custom_short_url": "xsxXXZZX"
  }'
  ```
  
  response

  ```json
   {
      "short_url": "localhost:3000/CustomUrl"
   }
  ```

### Decodes a shortened URL to its original
- Enpoint

  ```
  GET api/v1/decode
  ```

- Parameter

  | Location | Required | Name | Type | Description |
  | ---------| ---------|------|------|-------------|
  | Headers  | true     | Authorization | string | abc|
  | Body     | true     | short_url    | string | That a URL can be decoded into a origin URL

- Example

  request
  ```shell
  curl --location -g --request GET '{{base_url}}/api/v1/decode?short_url=quEfUy' \
  --header 'Authorization: {{access_token}} c' \
  --data-raw '{
      "origin_url": "https://stackoverflow.com/questions/22623656/how-to-redirect-to-and-return-a-200-status-code"
  }'
  ```
  
  response

  ```json
  {
    "origin_url": "https://stackoverflow.com/questions/1/test"
  }
  ```