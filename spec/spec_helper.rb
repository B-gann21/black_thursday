require 'simplecov'
SimpleCov.start
require "./spec/sales_engine_spec"
require './spec/sales_analyst_spec'
require "./spec/item_spec"
require './spec/item_repository_spec.rb'
require "./spec/merchant_repository_spec"
require "./spec/merchant_spec"
require './spec/id_manager_spec.rb'
require "./spec/invoice_spec"
require './spec/invoice_repository_spec'
require './spec/invoice_item_spec'
require './spec/invoice_item_repository_spec'
require './spec/customers_spec'
require './spec/customer_repository_spec'
require './spec/transaction_spec'
require './spec/transaction_repo_spec'
