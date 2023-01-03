# README

### Dependences
- Ruby: 3.0.4
- Rails: 7.0.4

### Environment
```
$ cp .env.example .env
```

### Run app
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

### Run Rspec

```
bundle exec rspec
```

### Get access token
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
	> eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NzUyNjI3NzMsImp0aSI6IjNiYWVlMDQ1LTQyMWItNDAyOS1iOWYxLWE1Zjk3ZTMxZDE0MiIsInN1YiI6MX0.La8nhxnzuQdzTYPDqSywPpZAUKygBKx4znAyJyu9giM

### Documentation
[Postman](https://documenter.getpostman.com/view/3235454/2s8Z711CQs)


### Access token

- Note: You can use this access_token to access 

    ```
    eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NzUyNjI3NzMsImp0aSI6IjNiYWVlMDQ1LTQyMWItNDAyOS1iOWYxLWE1Zjk3ZTMxZDE0MiIsInN1YiI6MX0.La8nhxnzuQdzTYPDqSywPpZAUKygBKx4znAyJyu9giM
    ```

- Get access_token

    ```
    docker exec -ti rails bundle exec rails console
    ```

    ```
    [1] pry(main)> JsonWebToken.encode(sub: 1)
    => "eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NzUyNjI3NzMsImp0aSI6IjNiYWVlMDQ1LTQyMWItNDAyOS1iOWYxLWE1Zjk3ZTMxZDE0MiIsInN1YiI6MX0.La8nhxnzuQdzTYPDqSywPpZAUKygBKx4znAyJyu9giM"

    ```