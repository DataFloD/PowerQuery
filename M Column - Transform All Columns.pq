Let 
  Source = ... ,
  MultipleTableTransform = Table.TransformColumns(#"ExpandCol", List.Transform(Table.ColumnNames(#"ExpandCol"), (col) => {col, each if _ = "" then null else Text.Clean(Text.Trim(_)), type text}))
in
  MultipleTableTransform
