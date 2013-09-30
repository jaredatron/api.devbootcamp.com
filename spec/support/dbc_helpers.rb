module DbcHelpers

  extend ActiveSupport::Concern

  def create_user_with_roles *roles
    create('dbc/user', :roles => roles)
  end

  def become *users
    @dbc = Dbc.new as: users
    ApplicationController.any_instance.stub(:current_user_ids).
      and_return(dbc.current_user_group.user_ids)
  end

  def become_a *roles
    become create_user_with_roles(roles)
  end

  def current_users
    dbc.current_user_group.users
  end

  def as *users, &block
    original_user_ids = dbc.current_user_group.user_ids if dbc
    become *users
    yield
  ensure
    become *original_user_ids if original_user_ids
  end

  def as_a *roles, &block
    as create_user_with_roles(roles), &block
  end
  alias_method :as_an, :as_a

  attr_reader :dbc

  module ClassMethods

    def become *roles
      before{ become *roles }
    end

    # as_a :student do
    #   …
    # end
    #
    # as_an :admin do
    #   …
    # end
    #
    def as_a *roles, &block
      context "as a user_group with the roles: #{roles.inspect}" do
        become *roles
        class_eval(&block)
      end
    end
    alias_method :as_an, :as_a

  end

end
