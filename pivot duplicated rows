/*
I had a single column containing values to dispatch in different columns. 
   |      Values    |
   | Val for Col 1  |
   | Val for Col 2  |
   | Val for Col 3  |
   | Val for Col 1  |
   | Val for Col 2  |
   | Val for Col 3  |

The columns needed to be dispatch to a column according to their position in the source column 
    result expected:
    | Col 1 | Col 2 | Col 3 |
    | val   | val   | val   |
    | val   | val   | val   |

I tried to generate a pattern which was supposed to be used as headers. 1,2,3,1,2,3 (I knew the values were well sorted)
    |      Values    | Pattern |
    | Val for Col 1  | 1       |
    | Val for Col 2  | 2       | 
    | Val for Col 3  | 3       |
    | Val for Col 1  | 1       |
    | Val for Col 2  | 2       |
    | Val for Col 3  | 3       |
The idea of the above table was to pivot the Pattern column with the option selected 'Don't aggregate'.
It did not worked. The error raised was 'Expression.Error: There were too many elements in the enumeration to complete the operation.'
Here is a workaround:
    |      Values    | Pattern | BlockId |
    | Val for Col 1  | 1       | 1       |
    | Val for Col 2  | 2       | 1       | 
    | Val for Col 3  | 3       | 1       |
    | Val for Col 1  | 1       | 2       |
    | Val for Col 2  | 2       | 2       |
    | Val for Col 3  | 3       | 2       |
Unpivoting the Pattern column now works.

For this function to work you need to
*/ 
let 
    source = (
        myTable as table, // The table containing a column with consecutive values to be passed in one row
        myBlockSize as number // The number of consecutive rows that need to be pivoted in one row
    ) =>

    let 
        addBlockId =
            Table.RemoveColumns(
                Table.AddColumn( 
                    Table.ReplaceValue(
                        Table.AddColumn(
                            Table.AddIndexColumn(
                                myTable, "index", 1, 1, Int64.Type
                            ),
                            "headers",
                            each Number.Mod([index], myBlockSize), 
                            type number
                        ),
                        0, myBlockSize, Replacer.ReplaceValue,{"headers"} 
                    ),
                    "id",
                    each if
                        ( 
                            [index] - [headers]
                        ) = 0
                        then 1
                        else
                        ( 
                            ( [index] - [headers] ) / myBlockSize
                        ) + 1,
                    type text
                ),
                {"index"}
            )
    in addBlockId
in source
    
