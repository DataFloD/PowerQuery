let

  // Variables
  Source = 
  (
    myTable       as table, 
    excelItemKind as text,  // The kind of excel item you want to import in your model ("Sheet" or "Table")
    excelItemName as text,  // The name of the excel item you want to import
    promoteHeader as logical, // write true if you want to promote headers for each file, false if you don't
    expandColumns as logical // write true if you want to automatically expand the columns, false if you don't
  ) =>
  // Transformation
    let

      getTable = Table.TransformColumns(
        myTable,
        {
          {
            "Content",
            each Excel.Workbook(_, promoteHeader) {[Kind = excelItemKind, Item = excelItemName]} [Data]
          }
        }
      ),

      expandCol =
        if expandColumns then
          Table.ExpandTableColumn( getTable, "Content", Table.ColumnNames(getTable[Content]{0}) )
        else
          getTable
    in
      expandCol
in
  Source
