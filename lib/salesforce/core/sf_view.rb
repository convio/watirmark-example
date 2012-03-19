module Salesforce
  class SFView < Page

    keyword(:home_tab)    {}
    keyword(:lead_tab)    {}
    keyword(:contact_tab) {}

    class << self
      def home
        home_tab.click
      end

      def create(hash)
        raise NoMethodError, "You must Override this"
      end

      def edit(hash)
        raise NoMethodError, "You must Override this"
      end

      def delete(hash)
        raise NoMethodError, "You must Override this"
      end

      def verify(hash)
        raise NoMethodError, "You must Override this"
      end

      def locate_record(hash)
        raise NoMethodError, "You must Override this"
      end
    end

  end
end