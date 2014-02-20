require 'spreadsheet'

#coding: utf-8

#include RSpec::Expectations

class DataDrivenTest
  attr_accessor :linha, :coluna

  def initialize
    Spreadsheet.client_encoding = 'UTF-8'
  end

  def readSheet(vFile, vSheetNumber)
    book = Spreadsheet.open vFile
    sheet = book.worksheet vSheetNumber
    sheet
  end

  def readLine(vSheet, vlineNumber)
    line = vSheet.row(vlineNumber)
    line 
  end

  def readColumn(vSheet, vLine, vColumn)
    cel = vSheet.row(vLine)

    if cel[vColumn].class == Spreadsheet::Formula then res = cel[vColumn].value
    else res = cel[vColumn]
    end
    res
  end

  def readSelectionedCell(vSheet)
  	cel = vSheet.row(@linha)
    if cel[@coluna].class == Spreadsheet::Formula then res = cel[@coluna].value
    else res = cel[@coluna]
    end
    res 
  end
end
