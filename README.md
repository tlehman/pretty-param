Pretty Param
============

Easily make your resource-based routes more search engine friendly without doing a bunch of crazy shit or changing your routes.

Installation
------------

Gemfile:

    gem 'pretty_param'

Usage 
-----

    class Person < ActiveRecord::Base
    	has_pretty_param :first_name, :last_name
    end
    
    # => "http://localhost:3000/people/1-ronald-mcdonald"