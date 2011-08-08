require 'helper'
require File.dirname(__FILE__) + '/../lib/tuk.rb'

class TestTuk < Test::Unit::TestCase
  def test_can_strip_country_code
    assert_equal Tuk::Number.remove_country_code("442089732951"),"02089732951"
    assert_equal Tuk::Number.remove_country_code("+442089732951"),"02089732951"
    assert_equal Tuk::Number.remove_country_code("00442089732951"),"02089732951"
  end
  
  def test_knows_about_area_codes
    assert Tuk::Number.area_codes.is_a? Array
  end
  
  def test_can_generate_a_regex    
    assert Tuk::Number.area_code_regex.is_a? Regexp
  end
  
  def test_can_get_area_code
    assert_equal '020', Tuk::Number.area_code_for("02089732951")
    assert_equal '020', Tuk::Number.new('442089732951').area_code
  end
end
