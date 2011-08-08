require 'csv'

module Tuk
  
  class Number
    
    def initialize(with_number)
      @original_number = with_number.gsub(" ", "")
    end
    
    def normalised_number
      @_normalised_number ||= begin
        self.class.remove_country_code(@original_number)
      end
    end
    
    def area_code
      self.class.area_code_for(normalised_number)
    end
    
    class << self
      def remove_country_code(number)
        if number[0..2] == "+44"
          "0" + number[3..-1]
        elsif number[0..1] == "44"
          "0" + number[2..-1]
        elsif number[0..3] == "0044"
          "0" + number[4..-1]
        else
          number
        end
      end
      
      def area_code_for(number)
        if matched = number.match(area_code_regex)
          matched[1]
        else
          nil
        end
      end
      
      def area_code_regex
        @_area_code_regex || begin
          Regexp.new("^(#{area_codes.join('|')}).*")
        end
      end
      
      def area_codes
        @_area_codes || begin
          codes = CSV.read(File.dirname(__FILE__) + '/area_codes.csv').drop(1).map{|n| n.first}
        end
      end      
      
    end
    
  end
end