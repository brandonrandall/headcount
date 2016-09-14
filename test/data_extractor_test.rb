require_relative 'test_helper'
require_relative '../lib/district_repository'
require 'csv'
require 'pry'

class DataExtractorTest < Minitest::Test
  def test_extract
    load_hash = {:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}}
    table = DataExtractor.extract(load_hash)
    assert_equal CSV::Table, table.class
  end

  def test_extract_path_gives_file_name
    load_hash = {:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}}
    assert_equal "./data/Kindergartners in full-day program.csv", DataExtractor.extract_path(load_hash)
  end
end
