let

  // Variables
  Source = 
  (
    myTable                 as table, 
    optional delimiter      as text,
    optional columns        as number,
    optional encoding       as number,
    optional expandColumns  as logical, 
    optional promoteHeaders as logical

  ) =>
  // Transformation
    let
      //optional variables: if null then default else user choice
      checkDelimiter      = if delimiter = null then "," else delimiter,
      checkColumns        = if columns = null then null else columns,
      checkEncoding       = if encoding = null then 1252 else encoding,
      checkExpandColumns  = if expandColumns  = null then true else expandColumns,
      checkPromoteHeaders = if promoteHeaders = null then true else promoteHeaders,
      
      // Transform data with header promoting according to user choice
      getTable = Table.TransformColumns(
        myTable,
        {
          {
            "Content",
            if checkPromoteHeaders then 
              each Table.PromoteHeaders(Csv.Document(_,[Delimiter = checkDelimiter, Columns = checkColumns, Encoding = checkEncoding, QuoteStyle=QuoteStyle.None]))
            else 
              each Csv.Document(_,[Delimiter = checkDelimiter, Columns = checkColumns, Encoding = checkEncoding, QuoteStyle=QuoteStyle.None])
          }
        }
      ),
      
      // Expand columns according to user choice
      expandCol =
        if checkExpandColumns then
          Table.ExpandTableColumn( getTable, "Content", Table.ColumnNames(getTable[Content]{0}) )
        else
          getTable

    in
      expandCol
in
  Source
