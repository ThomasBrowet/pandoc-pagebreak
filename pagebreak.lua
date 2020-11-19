local function newpage(format)
  if format == 'docx' then
    local pagebreak = '<w:p><w:r><w:br w:type="page"/></w:r></w:p>'
    return pandoc.RawBlock('openxml', pagebreak)
  else
    return pandoc.Para{pandoc.Str '\f'}
  end
end

local function endLandscape(format)
  if format == 'docx' then
    local pagebreak = '<w:p xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\" xmlns:wp=\"http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\" xmlns:w14=\"http://schemas.microsoft.com/office/word/2010/wordml\"><w:pPr><w:sectPr><w:officersection/><w:pPr><w:sectPr><w:officersection/><w:pgSz w:orient=\"landscape\" w:w=\"15840\" w:h=\"12240\"/></w:sectPr></w:pPr></w:sectPr></w:pPr></w:p>'
    return pandoc.RawBlock('openxml', pagebreak)
  else
    return pandoc.Para{pandoc.Str '\f'}
  end
end

local function endPortrait(format)
  if format == 'docx' then
    local pagebreak = '<w:p xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\" xmlns:wp=\"http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\" xmlns:w14=\"http://schemas.microsoft.com/office/word/2010/wordml\"><w:pPr><w:sectPr><w:officersection/><w:pPr><w:sectPr><w:officersection/><w:pgSz w:orient=\"portrait\" w:w=\"12240\" w:h=\"15840\"/></w:sectPr></w:pPr></w:sectPr></w:pPr></w:p>'
    return pandoc.RawBlock('openxml', pagebreak)
  else
    return pandoc.Para{pandoc.Str '\f'}
  end
end

local function endContinuous(format)
  if format == 'docx' then
    local pagebreak = '<w:p xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\" xmlns:wp=\"http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\" xmlns:w14=\"http://schemas.microsoft.com/office/word/2010/wordml\"><w:pPr><w:sectPr><w:officersection/><w:type w:val=\"continuous\"/></w:sectPr></w:pPr></w:p>'
    return pandoc.RawBlock('openxml', pagebreak)
  else
    return pandoc.Para{pandoc.Str '\f'}
  end
end

-- Filter function called on each RawBlock element.
function RawBlock (el)
  if el.text:match '\\newpage' then
    return newpage(FORMAT)
  elseif el.text:match '\\endLandscape' then
    return endLandscape(FORMAT)
  elseif el.text:match '\\endContinuous' then
    return endContinuous(FORMAT)
  elseif el.text:match '\\endPortrait' then
    return endPortrait(FORMAT)
  end
  -- otherwise, leave the block unchanged
  return nil
end