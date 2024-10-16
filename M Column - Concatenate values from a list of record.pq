Table.AddColumn(
    #"My Table",
    "Custom",
    each
        let
            col_list = [myCol],
            col_list_count = List.Count([myCol])
        in 
            Text.Combine(
                List.Transform(
                    List.Numbers(0,col_list_count,1), 
                    each Record.Field(col_list{_},"theValueIwantInRecord")
                )
                , ","
            )
)
