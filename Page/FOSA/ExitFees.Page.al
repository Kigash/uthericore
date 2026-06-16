page 50248 "Exit Fees"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Exit Fee";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Earning Party"; Rec."Earning Party")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

