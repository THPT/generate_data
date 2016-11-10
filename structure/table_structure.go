package structure

type TableStructure struct {
	FromTableName string            `json:"from_table_name"`
	DestTableName string            `json:"dest_table_name"`
	Columns       []ColumnStructure `json:"columns"`
}

type ColumnStructure struct {
	ColumnName string `json:"column_name"`
	DataType   string `json:"data_type"`
}
