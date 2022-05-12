table 73100 Replication//DG
{
    DataClassification = CustomerContent;
    DataPerCompany = false;
    fields
    {
        field(1; "From Company"; text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = Company.Name;
        }
        field(2; "To Company"; text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = Company.Name;
        }
        field(3; "Enable"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "To Company", "From Company")
        {
            Clustered = true;
        }
    }
    var
        comp: Record Company;
}