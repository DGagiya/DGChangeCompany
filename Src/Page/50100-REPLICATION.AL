page 73100 "DG Replication Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Replication;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("From Company"; Rec."From Company")
                {
                    ApplicationArea = All;

                }
                field("To Company"; Rec."To Company")
                {
                    ApplicationArea = All;

                }
                field(Enable; Rec.Enable)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}