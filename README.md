# Jungle

Jungle is a mini e-commerce application built with Rails. For this project I took on an existing codebase and integrated new features and test suites.

## Getting Started

1. Run `bundle install` to install dependencies
4. Run `bin/rake db:reset` to create, load and seed the database
8. Run `bin/rails s -b 0.0.0.0` to start the server. The app will be served at <http://localhost:3000/>.

## Stripe Testing

For testing payment success scenarios, use Visa # 4242 4242 4242 4242 with any CVC and any future date.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

* Rails 4.2
* PostgreSQL 9.x
* Stripe