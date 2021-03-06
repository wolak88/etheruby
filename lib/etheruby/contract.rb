require 'singleton'

require_relative 'client'
require_relative 'contract_method_dsl'
require_relative 'arguments_generator'
require_relative 'response_parser'
require_relative 'contract_base'

module Etheruby::Contract

  def initialize
    @c_methods = {}
    @logger = ::Logger.new(STDOUT)
    @logger.level = if ENV.has_key? 'ETHERUBY_DEBUG'
      ::Logger::DEBUG
    else
      ::Logger::WARN
    end
    @logger.progname = "Etheruby Contract '#{self.class.name}'"
  end

  module ClassMethods
    def method_missing(sym, *args, &blk)
      self.instance.send(sym, *args, &blk)
    end
  end

  def self.included(base)
    base.include(::Singleton)
    base.include(Etheruby::ContractBase)
    base.extend(ClassMethods)
  end

end
