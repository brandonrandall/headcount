require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
end
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'rubygems'
require 'mocha'
require 'mocha/mini_test'
