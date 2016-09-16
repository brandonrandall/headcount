require_relative 'test_helper'
require_relative '../lib/district_repository'
require 'csv'
require 'pry'

class DataExtractorTest < Minitest::Test
  # def test_extract
  #   file_data = {:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}}
  #   table = DataExtractor.extract(file_data)
  #   assert_equal CSV::Table, table.class
  # end

  def test_extract_path_gives_file_name
    file_data = {:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}}
    assert_equal "./data/Kindergartners in full-day program.csv", DataExtractor.extract_path(file_data)
  end

  def test_extract
    file_data = {
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
        }
      }
    assert_equal "{:kindergarten=>#<CSV::Table mode:col_or_row row_count:1992>, :high_school_graduation=>#<CSV::Table mode:col_or_row row_count:906>}", DataExtractor.extract(file_data).to_s
  end

  def test_extract_with_partial_hash
    file_data = {
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      }
    assert_equal "{:kindergarten=>#<CSV::Table mode:col_or_row row_count:1992>}", DataExtractor.extract(file_data).to_s
  end
end
